{ lib, pkgs }:

with pkgs;
devshell.mkShell {
  env = [
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
      "-Dorg.gradle.project.android.aapt2FromMavenOverride=${android-sdk}/share/android-sdk/build-tools/33.0.2/aapt2";
    }
    {
      name = "PISON_ROOT";
      eval = "$PRJ_ROOT";
    }
    {
      name = "PISON_SHARED";
      eval = "$PRJ_ROOT/shared";
    }
    {
      name = "PATH";
      prefix = "$HOME/.local/bin";
    }
    {
      name = "CC";
      eval = "$DEVSHELL_DIR/bin/cc";
    }
    {
      name = "CXX";
      eval = "$DEVSHELL_DIR/bin/c++";
    }
  ];

  imports = [
    "${devshell.extraModulesDir}/language/c.nix"
    (devshell.importTOML ./devshell.toml) 
  ];

  language.c = let
    dependencies = [
      boost180
      fmt
      gtest
      protobuf
      spdlog
    ] ++ lib.optionals stdenv.isLinux [
      dbus
    ] ++ lib.optionals stdenv.isDarwin [
      llvmPackages_15.openmp
    ];
    compiler = if stdenv.isLinux then gcc else clang;
  in {
    compiler = compiler;
    libraries = dependencies;
    includes = dependencies;
  };
}
