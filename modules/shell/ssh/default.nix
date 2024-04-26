{
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    controlMaster = "no";
    controlPath = "none";

    matchBlocks = {
      "personal" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/personal";
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/work";
      };
      "magneto" = {
        hostname = "192.168.0.63";
        user = "build";
        identityFile = "~/.ssh/magneto";
      };
      "tmate" = {
        hostname = "sfo2.tmate.io";
        identityFile = "~/.ssh/tmate";
      };
    };
  };
}
