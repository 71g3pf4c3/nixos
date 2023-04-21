{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "norg-fmt";
  version = "main";

  src = fetchFromGitHub {
    owner = "nvim-neorg";
    repo = pname;
    rev = version;
    hash = "sha256-vFRB3nEPwBNUnvgZ2ekst53R4Amzm9r6yaRyW7uMrD8=";
  };

  cargoHash = "sha256-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=";

  meta = with lib; {
    description = "Neorg formatter";
    homepage = "https://github.com/dimo414/bkt";
    license = licenses.mit;
    # maintainers = [ maintainers.tailhook ];
  };
}
