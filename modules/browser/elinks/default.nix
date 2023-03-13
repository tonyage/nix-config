{ colorscheme, config, pkgs, ... }: with colorscheme; {
  home.packages = with pkgs; [
    bzip2
    elinks
    gpm
    expat
    libidn
    openssl
    pkg-config
    spidermonkey_102
    tre
    zlib
  ];
  home.file.".elinks/elinks.conf".text = ''
    set mime.extension.jpg = "image/jpeg"
    set mime.extension.jpeg = "image/jpeg"
    set mime.extension.png = "image/png"
    set mime.extension.gif = "image/gif"
    set mime.extension.bmp = "image/bmp"

    set mime.handler.image_viewer.unix.program = "imv %s"
    set mime.handler.image_viewer.unix-xwin.program = "imv %s"
    
    set mime.type.image.jpg = "image_viewer"
    set mime.type.image.jpeg = "image_viewer"
    set mime.type.image.png = "image_viewer"
    set mime.type.image.gif = "image_viewer"
    set mime.type.image.bmp = "image_viewer"
    
    set terminal_template.type = 2
    set terminal._template_.colors = 3
    set terminal._template_.transparency = 1

    set document.colors.text = "${bright.white}"
    set document.colors.background = "${normal.black}"
    set document.colors.link = "${normal.cyan}"
    set document.colors.vlink = "${normal.magenta}"
    set document.colors.image = "${normal.green}"
    set document.colors.dirs = "${normal.blue}"
    set document.colors.use_document_colors = 0
    set document.browse.links.numbering = 1
    set document.plain.compress_empty_lines = 1

    set ui.colors.color.mainmenu.normal.text = "${bright.white}"
    set ui.colors.color.mainmenu.normal.background = "${normal.black}"
    set ui.colors.color.mainmenu.hotkey.normal.text = "${normal.green}"
    set ui.colors.color.mainmenu.hotkey.normal.background = "${gradients.dark.black15}"
    set ui.colors.color.mainmenu.hotkey.selected.text = "${normal.green}"
    set ui.colors.color.mainmenu.hotkey.selected.background = "${gradients.dark.black15}"

    set ui.colors.color.menu.normal.text = "${bright.white}"
    set ui.colors.color.menu.normal.background = "${gradients.dark.black05}"
    set ui.colors.color.menu.selected.text = "${bright.white}"
    set ui.colors.color.menu.selected.background = "${gradients.dark.black15}"
    set ui.colors.color.menu.hotkey.normal.text = "${normal.green}"
    set ui.colors.color.menu.hotkey.normal.background = "${gradients.dark.black05}"
    set ui.colors.color.menu.hotkey.selected.text = "${normal.green}"
    set ui.colors.color.menu.hotkey.selected.background = "${gradients.dark.black15}"
    set ui.colors.color.menu.frame.text = "${gradients.dark.black05}"
    set ui.colors.color.menu.frame.background = "${gradients.dark.black05}"

    set ui.colors.color.dialog.generic.text = "${bright.white}"
    set ui.colors.color.dialog.generic.background = "${gradients.dark.black05}"
    set ui.colors.color.dialog.frame.text = "${bright.green}"
    set ui.colors.color.dialog.frame.background = "${gradients.dark.black05}"
    set ui.colors.color.dialog.scrollbar.text = "${bright.white}"
    set ui.colors.color.dialog.scrollbar.background = "${gradients.dark.black05}"
    set ui.colors.color.dialog.text.text = "${normal.yellow}"
    set ui.colors.color.dialog.text.background = "${gradients.dark.black05}"
    set ui.colors.color.dialog.title.background = "${gradients.dark.black05}"
    set ui.colors.color.dialog.title.text = "${bright.white}"
    set ui.colors.color.dialog.title.background = "${gradients.dark.black05}"
    set ui.colors.color.dialog.checkbox.text = "${normal.blue}"
    set ui.colors.color.dialog.checkbox.background = "${gradients.dark.black05}"
    set ui.colors.color.dialog.checkbox-selected.text = "${bright.white}"
    set ui.colors.color.dialog.checkbox-selected.background = "${gradients.dark.black05}"
    set ui.colors.color.dialog.checkbox-label.text = "${normal.orange}"
    set ui.colors.color.dialog.checkbox-label.background = "${gradients.dark.black05}"
    set ui.colors.color.dialog.button.text = "${bright.white}"
    set ui.colors.color.dialog.button.background = "${gradients.dark.black05}"
    set ui.colors.color.dialog.button-selected.text = "${normal.black}"
    set ui.colors.color.dialog.button-selected.background = "${normal.blue}"
    set ui.colors.color.dialog.button-shortcut.text = "${normal.green}"
    set ui.colors.color.dialog.button-shortcut.background = "${gradients.dark.black05}"
    set ui.colors.color.dialog.field.text = "${bright.white}"
    set ui.colors.color.dialog.field.background = "${gradients.dark.black15}"
    set ui.colors.color.dialog.field-text.text = "${bright.white}"
    set ui.colors.color.dialog.field-text.background = "${gradients.dark.black15}"
    set ui.colors.color.dialog.meter.text = "${normal.blue}"
    set ui.colors.color.dialog.meter.background = "${gradients.dark.black05}"

    set ui.colors.color.title.title-bar.text = "${bright.white}"
    set ui.colors.color.title.title-bar.background = "${normal.black}"
    set ui.colors.color.title.title-text.text = "${bright.white}"
    set ui.colors.color.title.title-text.background = "${normal.black}"

    set ui.colors.color.tabs.normal.text = "${bright.white}"
    set ui.colors.color.tabs.normal.background = "${gradients.dark.black10}"
    set ui.colors.color.tabs.unvisited.text = "${normal.blue}"
    set ui.colors.color.tabs.unvisited.background = "${gradients.dark.black10}"
    set ui.colors.color.tabs.loading.text = "${bright.magenta}"
    set ui.colors.color.tabs.loading.background = "${normal.black}"
    set ui.colors.color.tabs.selected.text = "${bright.white}"
    set ui.colors.color.tabs.selected.background = "${normal.black}"
    set ui.colors.color.tabs.separator.text = "${bright.white}"
    set ui.colors.color.tabs.separator.background = "${normal.black}"

    set ui.colors.color.searched.text = "${normal.black}"
    set ui.colors.color.searched.background = "${normal.yellow}"

    set ui.colors.color.status.status-bar.text = "${bright.magenta}"
    set ui.colors.color.status.status-bar.background = "${normal.black}"
    set ui.colors.color.status.status-text.text = "${bright.magenta}"
    set ui.colors.color.status.status-text.background = "${normal.black}"
  '';
}
