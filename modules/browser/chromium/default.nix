{
  programs.chromium = {
    enable = true;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock-origin
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # darkreader
    ];
  };
}
