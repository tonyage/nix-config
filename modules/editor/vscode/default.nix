{ colorscheme, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages
      (pkgs: with pkgs; [
        zlib
        rustup
        pkg-config
        openssl.dev
      ]);
  };
}
