#!/usr/bin/env bash

confirm_details() {
  _print "${GREEN}Username: $USER"
  _print "Email: $GIT_EMAIL"
  _print "Name: $GIT_NAME${NC}"

  if [[ "$OS" != "Darwin" ]]; then
    _print "${GREEN}Primary interface: $PRIMARY_IFACE"
    _print "Boot disk: $BOOT_DISK"
    _print "Hostname: $HOST_NAME${NC}"
  fi

  _print "${GREEN}Secrets repository: $GITHUB_USER/$GITHUB_SECRETS_REPO${NC}"

  _prompt "${YELLOW}Is this correct? (Yes/No): ${NC}" choice
  choice="${choice:-yes}"

  case "$choice" in
  [Nn] | [Nn][Oo])
    _print "${RED}Exiting script.${NC}"
    exit 1
    ;;
  [Yy] | [Yy][Ee][Ss])
    _print "${GREEN}Continuing...${NC}"
    ;;
  *)
    _print "${RED}Invalid option. Exiting script.${NC}"
    exit 1
    ;;
  esac
}
#!/usr/bin/env bash

git_info() {
  if [[ "$USER" == "nixos" ]] || [[ "$USER" == "root" ]]; then
    _prompt "${YELLOW}You're running as $USER. Please enter your desired username: ${NC}" USER
  fi

  # Check if git is available
  if command -v git >/dev/null 2>&1; then
    # Fetch email and name from git config
    GIT_EMAIL=$(git config --get user.email)
    export GIT_EMAIL
    GIT_NAME=$(git config --get user.name)
    export GIT_NAME
  else
    _print "${RED}Git is not available on this system.${NC}"
  fi

  # If git email is not found or git is not available, ask the user
  if [[ -z "$GIT_EMAIL" ]]; then
    _prompt "${YELLOW}Please enter your email: ${NC}" GIT_EMAIL
  fi

  # If git name is not found or git is not available, ask the user
  if [[ -z "$GIT_NAME" ]]; then
    _prompt "${YELLOW}Please enter your name: ${NC}" GIT_NAME
  fi

  _prompt "${YELLOW}Please enter your Github username: ${NC}" GITHUB_USER
  _prompt "${YELLOW}Please enter your Github secrets repository name: ${NC}" GITHUB_SECRETS_REPO

  export GITHUB_USER
  export GITHUB_SECRETS_REPO
}

insert_secrets_input() {
  # Define file path
  FILE_PATH="flake.nix"

  # Backup the original file
  cp "$FILE_PATH" "${FILE_PATH}.bak"

  # Temporary file for the text to insert
  TEMP_FILE="temp_insert.txt"

  # Write the formatted text to the temporary file
  cat >"$TEMP_FILE" <<'EOF'
    secrets = {
      url = "git+ssh://git@github.com/%GITHUB_USER%/%GITHUB_SECRETS_REPO%.git";
      flake = false;
    };
EOF

  # Check if the 'secrets' block already exists
  if grep -q 'url = "git+ssh://git@github.com/%GITHUB_USER%/%GITHUB_SECRETS_REPO%.git"' "$FILE_PATH"; then
    echo "The 'secrets' block already exists in the file."
    rm "$TEMP_FILE"
    rm "${FILE_PATH}.bak"
    exit 0
  fi

  # Find the start and end line numbers of the 'disko' block
  START_LINE=$(grep -n 'disko = {' "$FILE_PATH" | head -n 1 | cut -d: -f1)
  END_LINE=$(tail -n +$START_LINE "$FILE_PATH" | grep -n '};' | head -n 1 | cut -d: -f1)
  END_LINE=$((START_LINE + END_LINE - 1))

  # Create a new file with the insertion
  {
    sed -n "1,${END_LINE}p" "$FILE_PATH"
    cat "$TEMP_FILE"
    sed -n "$((END_LINE + 1)),\$p" "$FILE_PATH"
  } >"${FILE_PATH}.new"

  # Replace the original file with the new file
  mv "${FILE_PATH}.new" "$FILE_PATH"

  # Clean up the temporary files
  rm "$TEMP_FILE"
  rm "${FILE_PATH}.bak"
}

insert_secrets_output() {
  local pattern="outputs = { self, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, home-manager, nixpkgs, disko, agenix } @inputs:"
  local insert_text="secrets "

  awk -v pat="$pattern" -v insert="$insert_text" '
    $0 ~ pat {
      sub(/} @inputs:/, ", " insert "} @inputs:"); # Replace the closing brace with the insert text followed by the brace
      gsub(/ ,/, ","); # Correct any spaces before commas
      print
      next
    }
    { print }
  ' flake.nix >flake.nix.tmp

  mv flake.nix.tmp flake.nix
}

replace_tokens() {
  local file="$1"
  if [[ $(basename "$1") != "apply" ]]; then
    if [[ "$OS" == "Darwin" ]]; then
      # macOS
      LC_ALL=C LANG=C sed -i '' -e "s/%USER%/$USER/g" "$file"
      LC_ALL=C LANG=C sed -i '' -e "s/%EMAIL%/$GIT_EMAIL/g" "$file"
      LC_ALL=C LANG=C sed -i '' -e "s/%NAME%/$GIT_NAME/g" "$file"
      LC_ALL=C LANG=C sed -i '' -e "s/%GITHUB_USER%/$GITHUB_USER/g" "$file"
      LC_ALL=C LANG=C sed -i '' -e "s/%GITHUB_SECRETS_REPO%/$GITHUB_SECRETS_REPO/g" "$file"
    else
      # Linux or other
      sed -i -e "s/%USER%/$USER/g" "$file"
      sed -i -e "s/%EMAIL%/$GIT_EMAIL/g" "$file"
      sed -i -e "s/%NAME%/$GIT_NAME/g" "$file"
      sed -i -e "s/%INTERFACE%/$PRIMARY_IFACE/g" "$file"
      sed -i -e "s/%DISK%/$BOOT_DISK/g" "$file"
      sed -i -e "s/%HOST%/$HOST_NAME/g" "$file"
      sed -i -e "s/%GITHUB_USER%/$GITHUB_USER/g" "$file"
      sed -i -e "s/%GITHUB_SECRETS_REPO%/$GITHUB_SECRETS_REPO/g" "$file"
    fi
  fi
}

git_info
confirm_details

insert_secrets_input
insert_secrets_output

export -f replace_tokens
find . -type f -exec bash -c 'replace_tokens "$0"' {} \;

echo -e "$USER" >/tmp/username.txt
echo -e "${GREEN}User $USER information applied.${NC}"
