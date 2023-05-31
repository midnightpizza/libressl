# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} != *9999* ]]; then
	QT5_KDEPATCHSET_REV=1
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~loong ~ppc ~ppc64 ~riscv ~sparc x86"
fi

QT5_MODULE="qtbase"
inherit qt5-build

DESCRIPTION="Network abstraction library for the Qt5 framework"

IUSE="connman gssapi libproxy networkmanager sctp +ssl"

DEPEND="
	=dev-qt/qtcore-${QT5_PV}*:5=
	sys-libs/zlib:=
	connman? ( =dev-qt/qtdbus-${QT5_PV}* )
	gssapi? ( virtual/krb5 )
	libproxy? ( net-libs/libproxy )
	networkmanager? ( =dev-qt/qtdbus-${QT5_PV}* )
	sctp? ( kernel_linux? ( net-misc/lksctp-tools ) )
	ssl? ( >=dev-libs/openssl-1.1.1:0= )
"
RDEPEND="${DEPEND}
	connman? ( net-misc/connman )
	networkmanager? ( net-misc/networkmanager )
"

PATCHES=(
	"${FILESDIR}/${PN}-5.15.7-libressl.patch" #562050
	"${FILESDIR}/${P}-QDnsLookup-dont-overflow-the-buffer.patch"
	"${FILESDIR}/${P}-CVE-2023-32762.patch"
	"${FILESDIR}/${P}-libproxy-0.5-pkgconfig.patch"
)

QT5_TARGET_SUBDIRS=(
	src/network
	src/plugins/bearer/generic
)

QT5_GENTOO_CONFIG=(
	libproxy:libproxy:
	ssl::SSL
	ssl::OPENSSL
	ssl:openssl-linked:LINKED_OPENSSL
)

QT5_GENTOO_PRIVATE_CONFIG=(
	:network
)

pkg_setup() {
	use connman && QT5_TARGET_SUBDIRS+=(src/plugins/bearer/connman)
	use networkmanager && QT5_TARGET_SUBDIRS+=(src/plugins/bearer/networkmanager)
}

src_configure() {
	local myconf=(
		$(usev connman -dbus-linked)
		$(qt_use gssapi feature-gssapi)
		$(qt_use libproxy)
		$(usev networkmanager -dbus-linked)
		$(qt_use sctp)
		$(usev ssl -openssl-linked)
		-no-dtls # Required for libressl
	)
	qt5-build_src_configure
}

src_install() {
	qt5-build_src_install

	# workaround for bug 652650
	if use ssl; then
		sed -e "/^#define QT_LINKED_OPENSSL/s/$/ true/" \
			-i "${D}${QT5_HEADERDIR}"/Gentoo/${PN}-qconfig.h || die
	fi
}
