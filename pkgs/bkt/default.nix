{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "bkt";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "dimo414";
    repo = pname;
    rev = version;
    hash = "sha256-NgNXuTpI1EzgmxKRsqzxTOlQi75BHCcbjFnouhnfDDM=";
  };

  cargoHash = "sha256-PvcKviyXtiHQCHgJLGR2Mr+mPpTd06eKWQ5h6eGdl40=";

  meta = with lib; {
    description =
      "A subprocess caching utility written in Rust, inspired by bash-cache.";
    homepage = "https://github.com/dimo414/bkt";
    license = licenses.mit;
    # maintainers = [ maintainers.tailhook ];
  };
}
