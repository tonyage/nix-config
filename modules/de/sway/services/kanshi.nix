{ pkgs, ... }:
let
  lg-1 = "LG Electronics 27GN950 101NTFAC5283";
  dell-1 = "Dell Inc. Dell AW2721D #GTIYMxgwABpO";
  dell-2 = "Dell Inc. Dell AW2721D #GTIYMxgwAAda";
in
{
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
            scale = 1.50;
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
      main = {
        outputs = [
          {
            criteria = "${lg-1}";
            mode = "3840x2160@144Hz";
            scale = 1.50;
            status = "enable";
            position = "0,0";
            transform = "normal";
          }
          {
            criteria = "${dell-1}";
            mode = "2560x1440@240Hz";
            scale = 1.00;
            status = "enable";
            position = "0,0";
            transform = "normal";
          }
          {
            criteria = "${dell-2}";
            mode = "2560x1440@240Hz";
            scale = 1.00;
            status = "enable";
            position = "2560,0";
            transform = "normal";
          }
        ];
      };
    };
  };
}
