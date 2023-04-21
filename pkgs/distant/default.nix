{ lib, fetchFromGitHub, rustPlatform, pkgs }:

rustPlatform.buildRustPackage rec {
  pname = "distant";
  version = "v0.20.0";

  src = fetchFromGitHub {
    owner = "chipsenkbeil";
    repo = pname;
    rev = version;
    hash = "sha256-DcnleJUAeYg3GSLZljC3gO9ihiFz04dzT/ddMnypr48=";
  };

  cargoHash = "sha256-BiCVqoHtxY8F0ggj/PDRIGzzDrFCSlvG/0ns3LxIBgk=";
  env = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    OPENSSL_DIR = "${pkgs.openssl.dev}";
    OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
    RUST_BACKTRACE = 1;
  };

  doCheck = false;
  # buildFeatures = [ "full" ];
  # checkFlags = [
  # reason for disabling test
  # "--skip=*"
  # ];

  nativeBuildInputs = with pkgs; [
    rustc
    cargo
    openssl.dev
    openssl
    pkg-config
    perl
  ];
  buildInputs = with pkgs; [ rustc cargo openssl.dev openssl pkg-config perl ];
  meta = with lib; {
    description = "Libraries and tooling for working remotely.";
    homepage = "https://github.com/chipsenkbeil/distant";
    license = lib.licenses.asl20;
  };
}
