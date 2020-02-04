{ stdenv, fetchurl, bash, steam-run }:

stdenv.mkDerivation rec {
  version = "2.14.0";
  pname = "ipmiview";

  src = fetchurl {
    url = "http://archive.intr/s6-overlay/ipmiview/IPMIView_2.14.0_build.180213_bundleJRE_Linux_x64.tar.gz";
    sha256 = "0jjy62kw2jblgb830dqffyjqcfgnlap73f9qby83lv2p5kn0qs11";
  };

  installPhase = ''
    mkdir -p $out/{bin,share/ipmiview}
    cp --recursive ./ $out/share/ipmiview

    cat > ipmiview <<EOF
    #!${bash}/bin/bash
    ${steam-run}/bin/steam-run $out/share/ipmiview/IPMIView20
    EOF
    install -D ipmiview $out/bin
  '';
}
