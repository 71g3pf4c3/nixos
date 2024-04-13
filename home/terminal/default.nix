{
  config,
  pkgs,
  unstable,
  lib,
  inputs,
  ...
}:
let
  #Returns a list of "dir/filename" for all files in a dir
  filesIn = dir: (map (fname: dir + "/${fname}") (builtins.attrNames (builtins.readDir dir)));
in
{
  imports = (filesIn ./programs) ++ (filesIn ./services);
}
