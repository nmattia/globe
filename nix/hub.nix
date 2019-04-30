# Package more recent hub, as nixpkgs 18.03's is too old for "hub api"
{ sources, stdenv, buildGoPackage, fetchFromGitHub, groff, Security ? null, utillinux }:

buildGoPackage rec {
  name = "hub";

  goPackagePath = "github.com/github/hub";

  # Only needed to build the man-pages
  excludedPackages = [ "github.com/github/hub/md2roff-bin" ];

  src = sources.hub;

  nativeBuildInputs = [ groff utillinux ];
  buildInputs = stdenv.lib.optional stdenv.isDarwin Security;

  postPatch = ''
    patchShebangs .
  '';

  postInstall = ''
    cd go/src/${goPackagePath}
    install -D etc/hub.zsh_completion "$bin/share/zsh/site-functions/_hub"
    install -D etc/hub.bash_completion.sh "$bin/share/bash-completion/completions/hub"
    install -D etc/hub.fish_completion  "$bin/share/fish/vendor_completions.d/hub.fish"
  '';

  meta = with stdenv.lib; {
    inherit (sources.hub) description homepage;
    license = licenses.mit;
    maintainers = with maintainers; [ the-kenny ];
    platforms = with platforms; unix;
  };
}
