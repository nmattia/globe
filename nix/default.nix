{}:
with rec
{ sources = import ./sources.nix;
  pkgs = import sources.nixpkgs {};
  napalm = import sources.napalm { inherit pkgs; };
  netlify-cli = napalm.buildPackage sources.netlify-cli {};
};

pkgs // { inherit netlify-cli; }