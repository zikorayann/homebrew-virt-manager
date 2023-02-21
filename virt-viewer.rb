class VirtViewer < Formula
  desc "App for virtualized guest interaction"
  homepage "https://virt-manager.org/"
  url "https://gitlab.com/virt-viewer/virt-viewer/-/archive/v11.0/virt-viewer-v11.0.tar.gz"
  sha256 "73e2f0148dd49c5ff5e8c5d0e9d9de592931895e89e2300e3de4ae96d8380a9b"

  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "atk"
  depends_on "cairo"
  depends_on "gdk-pixbuf"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "gtk-vnc"
  depends_on "hicolor-icon-theme"
  depends_on "libvirt"
  depends_on "libvirt-glib"
  depends_on "pango"
  depends_on "shared-mime-info"
  depends_on "spice-gtk"
  depends_on "spice-protocol"

  def install
    args = %W[
      --disable-silent-rules
      --disable-update-mimedb
      --with-gtk-vnc
      --with-spice-gtk
      --prefix=#{prefix}
    ]
    system "./configure", *args
    system "make", "install"
  end

  def post_install
    # manual update of mime database
    system "#{Formula["shared-mime-info"].opt_bin}/update-mime-database", "#{HOMEBREW_PREFIX}/share/mime"
    # manual icon cache update step
    system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    system "#{bin}/virt-viewer", "--version"
  end
end
