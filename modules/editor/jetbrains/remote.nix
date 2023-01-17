{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.idea-ultimate-remote;
  
  name = "idea-ultimate-remote";
      
  mkStartScript = name: pkgs.writeShellScript "${name}.sh" ''
    set -euo pipefail
    PATH=${makeBinPath (with pkgs; [ coreutils findutils inotify-tools patchelf gnused ])}
    bin_dir=~/.cache/JetBrains/RemoteDev/dist/

    mkdir -p ~/.cache/JetBrains/RemoteDev/dist/ 

    get_file_size() {
      fname="$1"
      echo $(ls -l $fname | cut -d ' ' -f5)
    }
    munge_size_hack() {
      fname="$1"
      size="$2"
      strip $fname
      truncate --size=$size $fname
    }

    patch_fs_notifier() {
      interpreter=$(echo ${pkgs.glibc.out}/lib/ld-linux*.so.2)
      fs_notifier=$1; 
      
      if [ -z "$in" ]; then 
        read fs_notifier; 
      fi

      target_size=$(get_file_size $fs_notifier)
      patchelf --set-interpreter "$interpreter" $fs_notifier
      munge_size_hack $fs_notifier $target_size
    }

    find "$bin_dir" -mindepth 5 -maxdepth 5 -name launcher.sh -exec sed -i -e 's#LD_LINUX=/lib64/ld-linux-x86-64.so.2#LD_LINUX=${pkgs.glibc.out}/lib/ld-linux-x86-64.so.2#g' {} \;
    find "$bin_dir" -mindepth 3 -maxdepth 3 -name fsnotifier -exec patch_fs_notifier {} \;
    find "$bin_dir" -mindepth 3 -maxdepth 3 -name fsnotifier64 -exec patch_fs_notifier {} \;

    while IFS=: read -r out event; do
      case "$out" in
        */remote-dev-server/bin) 
          sed -i 's#LD_LINUX=/lib64/ld-linux-x86-64.so.2#LD_LINUX=${pkgs.glibc.out}/lib/ld-linux-x86-64.so.2#g' "$out/launcher.sh"

          if [[ "${pkgs.stdenv.hostPlatform.system}" == "x86_64-linux" && -e $out/fsnotifier64 ]]; then
            patch_fs_notifier $out/fsnotifier64 
          else
            patch_fs_notifier $out/fsnotifier 
          fi
        ;;
      esac
    done < <(inotifywait -r -m -q -e CREATE --include '^.*ideaIU[-[:digit:]\.]+(/plugins)?(/remote-dev-server)?(/bin)?$' --format '%w%f:%e' "$bin_dir")
  '';
in {
  options = {
    services.idea-ultimate-remote = {
      enable = mkEnableOption "idea-ultimate-remote";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = [ ];
      
      systemd.user.services.${name} = {
        Unit = {
          Description = "Automatically fix the IDEA Ultimate used by the remote SSH extension";
        };
    
        Service = {
          # When a monitored directory is deleted, it will stop being monitored.
          # Even if it is later recreated it will not restart monitoring it.
          # Unfortunately the monitor does not kill itself when it stops monitoring,
          # so rather than creating our own restart mechanism, we leverage systemd to do this for us.
          Restart = "always";
          RestartSec = 0;
          ExecStart = "${mkStartScript name}";
        };
    
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    })
  ];
}

