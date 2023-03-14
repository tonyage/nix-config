{ pkgs, ... }: {
  imports = [ ./remote.nix ];

  home.packages = with pkgs; [ jetbrains.idea-ultimate ];
  services.idea-ultimate-remote.enable = true;
  home.file.".ideavimrc".text = ''
    set argtextobj
    set clipboard=unnamedplus,unnamed,ideaput
    set commentary
    set highlightedyank
    set hlsearch
    set ideajoin
    set ideaput
    set ideastatusicon
    set ideawrite=all
    set ignorecase
    set incsearch
    set numberline
    set relativenumber
    set showmode
    set showcmd
    set smartcase
    set sneak
    set surround
    set wrapscan

    let mapleader = " "

    map Y y$
    map <C-l> <Action>(GotoNextSplitter)
    map <C-h> <Action>(GotoPreviousSplitter)

    nnoremap <leader>f <Action>(ReformatCode)
    nnoremap <leader>o <Action>(OptimizeImports)
    nnoremap <leader>d <Action>(Debug)
    nnoremap <leader>b <Action>(ToggleLineBreakpoint)
    nnoremap gt <Action>(GotoDeclaration)
    nnoremap gb <Action>(Back)

    vnoremap < <gv
    vnoremap > >gv
    vnoremap = =gv

    nmap = <Action>(EditorIncreaseFontSize)
    nmap - <Action>(EditorDecreaseFontSize)
    nmap gu <Action>(ShowUsages)
    nmap gi <Action>(GotoImplementation)
    nmap gs <Action>(GotoSuperMethod)
    nmap gp <Action>(ParameterInfo)
    nmap <TAB> <Action>(NextTab)
    nmap <S-TAB> <Action>(PreviousTab)
    map ge <Action>(ShowErrorDescription)
    
    nmap grr <Action>(RenameElement)
    nmap grg <Action>(Generate)
  '';
}
