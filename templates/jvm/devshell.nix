{ pkgs }: 

pkgs.devshell.mkShell {
  env = [
    {
      name = "ANDROID_HOME";
      value = "${pkgs.android-sdk}/share/android-sdk";
    }
    {
      name = "ANDROID_SDK_ROOT";
      value = "${pkgs.android-sdk}/share/android-sdk";
    }
    {
      name = "JAVA_HOME";
      value = pkgs.jdk11.home;
    }
    {
      name = "GRADLE_OPTS";
      value =
      "-Dorg.gradle.project.android.aapt2FromMavenOverride=${pkgs.android-sdk}/share/android-sdk/build-tools/33.0.1/aapt2";
    }
    {
      name = "PATH";
      prefix = "$HOME/.local/bin";
    }
    {
      name = "PISON_ROOT";
      value = "$HOME/git/work/pison";
    }
    {
      name = "PISON_SHARED";
      value = "$HOME/git/work/pison/shared";
    }
  ];
  imports = [ (pkgs.devshell.importTOML ./devshell.toml) ];
}
