{}:
with rec
{ sources = import ./sources.nix;
  pkgs = import sources.nixpkgs {};
  napalm = import sources.napalm { inherit pkgs; };
  netlify-cli = napalm.buildPackage sources.netlify-cli {};
  github-deploy = pkgs.callPackage sources.github-deploy {};
  hub = pkgs.callPackage ./hub.nix { inherit sources; } ;
};

pkgs // { inherit netlify-cli hub github-deploy; }
