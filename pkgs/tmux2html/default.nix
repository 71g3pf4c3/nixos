{ lib, fetchPypi, buildPythonPackage }:
buildPythonPackage rec {
  pname = "tmux2html";
  version = "0.1.11";
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-0aozmQ4Eb5zL4rtNHSFjEynfObUkYlid1PgMDVmRkwY=";
  };
  doCheck = false;
}
