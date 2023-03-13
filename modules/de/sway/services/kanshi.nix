{ pkgs, ... }:
let 
  lg-1 = "LG Electronics 27GN950 101NTFAC5283";
in {
  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.20;
            status = "enable";
          }
        ];
      };
      docked = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.20;
            status = "enable";
          }
          {
            criteria = "${lg-1}";
            mode = "3840x2160@94.981Hz";
            scale = 1.20;
            status = "enable";
            position = "0,0";
            transform = "normal";
          }
        ];
      };
    };
  };
}
