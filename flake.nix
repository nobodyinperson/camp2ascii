{
  description = "camp2ascii";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };
  outputs = { self, nixpkgs }: {
    packages = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        camp2ascii = pkgs.stdenv.mkDerivation rec {
          pname = "camp2ascii";
          version =
            self.sourceInfo.shortRev or self.sourceInfo.dirtyShortRev or "0.0.0";
          src = ./.;
          buildFlags = [ "EXTRA_CFLAGS=-Wno-format-security" ];
          installPhase = "install -Dm755 bin/camp2ascii -t $out/bin";
          meta = with pkgs.lib; {
            description =
              "Conversion of Campbell Scientific TOB1, TOB2 and TOB3 data files to ASCII formats";
            license = licenses.gpl3;
            platforms = platforms.all;
          };
        };
        default = camp2ascii;
      });
  };
}
