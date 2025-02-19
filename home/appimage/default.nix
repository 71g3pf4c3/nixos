{
  lib,
  pkgs,
  appimageTools,
  fetchurl,
  ...
}:
let
  ktalk = pkgs.appimageTools.wrapType2 {
    version = "3.0.0";
    pname = "ktalk";

    src = pkgs.fetchurl {
      url = "https://st.ktalk.host/ktalk-app/linux/ktalk3.0.0x86_64.AppImage";
      hash = "sha256-SngWAEYF5rK5iOc/38A0C0LwZCrpLn38knyCPROxZ2k=";
    };

    appimageContents = pkgs.appimageTools.extractType1;

    extraInstallCommands = ''
      mkdir -p $out/share/applications
      cat <<INI > $out/share/applications/ktalk.desktop
      [Desktop Entry]
      Terminal=false
      Name=Ktalk
      Exec=$out/bin/ktalk
      Type=Application
      INI

    '';

    # substituteInPlace $out/share/applications/ktalk.desktop \
    #   --replace-fail 'Exec=AppRun' 'Exec=/bin/ktalk'
  };
in
{
  home.packages = [
    ktalk
  ];
}
