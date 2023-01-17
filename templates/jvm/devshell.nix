{ pkgs }:

with pkgs;

devshell.mkShell {
  env = [
    {
      name = "ANDROID_HOME";
      value = "${android-sdk}/share/android-sdk";
    }
    {
      name = "ANDROID_SDK_ROOT";
      value = "${android-sdk}/share/android-sdk";
    }
    {
      name = "JAVA_HOME";
      value = jdk11.home;
    }
    {
      name = "GRADLE_OPTS";
      value =
      "-Dorg.gradle.project.android.aapt2FromMavenOverride=${android-sdk}/share/android-sdk/build-tools/33.0.0/aapt2";
    }
  ];
  imports = [ (devshell.importTOML ./devshell.toml) ];
}
