{ pkgs, lib }:
let
  merge =
    files:
    pkgs.runCommand "starship.toml"
      {
        nativeBuildInputs = [ pkgs.yq ];
      }
      ''
        tomlq -s -t 'reduce .[] as $item ({}; . * $item)' ${lib.concatStringsSep " " files} > $out
      '';
in
{
  user = merge [
    ./base.toml
    ./languages.toml
    ./user.toml
  ];
  userSsh = merge [
    ./base.toml
    ./languages.toml
    ./ssh-user.toml
  ];
  root = merge [
    ./base.toml
    ./languages.toml
    ./root.toml
  ];
  rootSsh = merge [
    ./base.toml
    ./languages.toml
    ./root.toml
    ./ssh-root.toml
  ];
}
