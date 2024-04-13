{ config, pkgs, unstable, lib, inputs, ... }: {
  imports = [./programs ./services];
}
