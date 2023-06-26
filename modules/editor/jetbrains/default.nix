{ pkgs, ... }: {
#  imports = [ ./remote.nix ];
#
#  home.packages = with pkgs; [ jetbrains.idea-ultimate ];
#  services.idea-ultimate-remote.enable = true

  home.packages = with pkgs; [
    jdk11
  ];

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
    set NERDtree

    let mapleader = " "

    map Y y$
    map <leader>f <Action>(ReformatCode)
    map <leader>o <Action>(OptimizeImports)
    map <leader>d <Action>(Debug)
    map <leader>b <Action>(ToggleLineBreakpoint)
    map <leader>e :NERDTreeToggle<CR>

    vnoremap < <gv
    vnoremap > >gv
    vnoremap = =gv

    nmap = <Action>(EditorIncreaseFontSize)
    nmap - <Action>(EditorDecreaseFontSize)
    nmap gu <Action>(ShowUsages)
    nmap gt <Action>(GotoDeclaration)
    nmap gi <Action>(GotoImplementation)
    nmap gs <Action>(GotoSuperMethod)
    nmap gp <Action>(ParameterInfo)
    nmap gf <Action>(GotoFile)
    nmap gc <Action>(CommentByLineComment)
    nmap <TAB> <Action>(NextTab)
    nmap <S-TAB> <Action>(PreviousTab)
    nmap ge <Action>(ShowErrorDescription)
    
    nmap grn <Action>(RenameElement)
    nmap grg <Action>(Generate)
  '';
}
