# Maintainer: Maboloshi <ymc1216@gmail.com>
pkgname=miktex
pkgver=2.9.7300
pkgrel=1
pkgdesc="a distribution of the TeX/LaTeX typesetting system"
arch="x86_64"
url="https://miktex.org"
license="custom"
depends="apr apr-util bzip2 cairo expat fontconfig freetype
         fribidi gd gmp graphite2 hunspell icu
         libjpeg xz libmspack openssl pixman libpng
         popt potrace uriparser"
makedepends="apr-dev apr-util-dev bison ca-certificates cmake
             curl dpkg-dev file flex gcc jpeg-dev
             bzip2-dev cairo-dev curl-dev fribidi-dev
             gd-dev gmp-dev graphite2-dev hunspell-dev icu-dev
             mpfr-dev libmspack-dev popt-dev potrace-dev openssl-dev
             uriparser-dev zziplib-dev make libxslt xz-dev"
source="https://miktex.org/download/ctan/systems/win32/miktex/source/${pkgname}-${pkgver}.tar.xz"

prepare() {
	default_prepare
	mkdir "$srcdir"/build
}

build() {
    cd "$srcdir"/build
    cmake "$builddir" \
        -DMIKTEX_PACKAGE_REVISION=${pkgver} \
        -DMIKTEX_LINUX_DIST=alpine \
        -DMIKTEX_LINUX_DIST_VERSION=undefined \
        -DMIKTEX_LINUX_DIST_CODE_NAME=undefined \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DUSE_SYSTEM_HARFBUZZ=FALSE \
        -DUSE_SYSTEM_HARFBUZZ_ICU=FALSE \
        -DUSE_SYSTEM_LOG4CXX=FALSE \
        -DUSE_SYSTEM_POPPLER=FALSE \
        -DUSE_SYSTEM_POPPLER_QT5=FALSE \
        -DUSE_SYSTEM_ZZIP=FALSE \
        -DWITH_MAN_PAGES=FALSE \
        -DWITH_UI_QT=FALSE
    make
}

check() {
    cd "${srcdir}/build"
    make test
}

package() {
    cd "${srcdir}/build"
    DESTDIR="$pkgdir" make install
}
sha512sums="9eb94f71f68ea3586c534b38e833abf4e92c78baf73aa070db8d4acb98020207c27411305949ab55a60d8b1abe61dd1e3bcbf3f2a90e5dcc10cff31083cb4b64  miktex-2.9.7300.tar.xz"