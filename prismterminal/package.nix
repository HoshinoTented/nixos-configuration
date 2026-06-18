{
  lib,
  stdenv,
  autoPatchelfHook,
  # Patch libraries
  openssl,
  systemdLibs,
  gtk3,
  gdk-pixbuf,
  cairo,
  glib,
  dbus,
  webkitgtk_4_1,
  libsoup_3,
  gcc,
  glibc,
}:

# patchelf --print-needed ./prismaterminal-tauri
# libssl.so.3
# libcrypto.so.3
# libudev.so.1
# libgdk-3.so.0
# libgdk_pixbuf-2.0.so.0
# libcairo.so.2
# libgobject-2.0.so.0
# libglib-2.0.so.0
# libdbus-1.so.3
# libwebkit2gtk-4.1.so.0
# libgtk-3.so.0
# libsoup-3.0.so.0
# libgio-2.0.so.0
# libjavascriptcoregtk-4.1.so.0
# libgcc_s.so.1
# libm.so.6
# libc.so.6

let
  binName = "prismterminal-tauri";
  version = "1.1.10";
in

stdenv.mkDerivation {
  pname = "prismterminal";
  inherit version;
  
  # TODO: trying to download fresh binary
  src = with lib.fileset; toSource {
    root = ./.;
    fileset = unions [ ./bin ./share ];
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [
    openssl
    systemdLibs
    gtk3
    gdk-pixbuf
    cairo
    glib
    dbus
    webkitgtk_4_1
    libsoup_3
    gcc
    glibc
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 ./bin/${binName} $out/bin/${binName}
    find ./share -type f -exec sh -c 'FILE="$1"; install -Dm755 "$FILE" $out/"$FILE"' sh {} \;

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://kagamistudio.com/";
    description = "The next generation of meowpad configurator";
    platforms = platforms.linux;
    license = licenses.unfreeRedistributable;
  };
}