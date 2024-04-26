{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dart-code.dart-code
      dart-code.flutter

      github.copilot
      github.copilot-chat

      golang.go

      ms-vscode.cmake-tools
      ms-vscode.cpptools

      ms-python.python
      ms-python.vscode-pylance

      rust-lang.rust-analyzer

      twxs.cmake
      vscodevim.vim
    ];
  };
}
