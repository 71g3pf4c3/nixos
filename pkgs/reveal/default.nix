{ mkYarnPackage, fetchFromGitHub, buildNodeJs }:

buildNodeJs {
  name = "reveal";
  enableNpm = true;
  version = "4.5.0";
  src = fetchFromGitHub {
    owner = "hakimel";
    repo = "reveal.js";
    rev = "4.5.0";
    hash = "sha256-9Q7aWgjAV37iJp6oYDz45e8J+RKwKY1Uvgg/BXwf5nQ=";
  };
  # packageResolutions = {
  #   pug = "^3.0.2";
  #   pug-runtime = "^3.0.1";
  # };
  # buildPhase = ''
  #   export HOME=$(mktemp -d)
  #   yarn --offline build
  # '';
}
