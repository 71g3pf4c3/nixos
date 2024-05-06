{ config, pkgs, unstable, lib, inputs, ... }: {
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 34560000;
    maxCacheTtl = 34560000;
    enableSshSupport = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-qt;
  };
}
