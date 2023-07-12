# Copyright 2017-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.1

EAPI=8

CRATES="
	aho-corasick-0.7.18
	ansi_term-0.12.1
	anyhow-1.0.58
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	block-buffer-0.7.3
	block-padding-0.1.5
	bstr-0.2.17
	byte-tools-0.3.1
	byteorder-1.4.3
	camino-1.0.9
	cargo-lock-8.0.2
	cargo-platform-0.1.2
	cargo_metadata-0.15.0
	cc-1.0.73
	cfg-if-1.0.0
	clap-2.34.0
	crates-index-0.18.8
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.10
	crossbeam-utils-0.8.11
	cvss-2.0.0
	digest-0.8.1
	either-1.7.0
	fake-simd-0.1.2
	fnv-1.0.7
	form_urlencoded-1.0.1
	fs-err-2.7.0
	generic-array-0.12.4
	getrandom-0.2.7
	git2-0.14.4
	globset-0.4.9
	globwalk-0.8.1
	heck-0.3.3
	hermit-abi-0.1.19
	hex-0.4.3
	home-0.5.3
	humantime-2.1.0
	humantime-serde-1.1.1
	idna-0.2.3
	ignore-0.4.18
	itertools-0.10.3
	itoa-1.0.2
	jobserver-0.1.24
	lazy_static-1.4.0
	libc-0.2.126
	libgit2-sys-0.13.4+1.4.2
	libssh2-sys-0.2.23
	libz-sys-1.1.8
	log-0.4.17
	maplit-1.0.2
	matches-0.1.9
	memchr-2.5.0
	memoffset-0.6.5
	num_cpus-1.13.1
	num_threads-0.1.6
	once_cell-1.13.0
	opaque-debug-0.2.3
	openssl-probe-0.1.5
	openssl-sys-0.9.75
	percent-encoding-2.1.0
	pest-2.1.3
	pest_derive-2.1.0
	pest_generator-2.1.3
	pest_meta-2.1.3
	phf-0.11.0
	phf_generator-0.11.0
	phf_macros-0.11.0
	phf_shared-0.11.0
	pkg-config-0.3.25
	platforms-3.0.1
	ppv-lite86-0.2.16
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.42
	quote-1.0.20
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.3
	rayon-1.5.3
	rayon-core-1.9.3
	regex-1.6.0
	regex-syntax-0.6.27
	rustc-hash-1.1.0
	rustsec-0.26.0
	ryu-1.0.10
	same-file-1.0.6
	scopeguard-1.1.0
	semver-1.0.12
	serde-1.0.140
	serde_derive-1.0.140
	serde_json-1.0.82
	sha-1-0.8.2
	siphasher-0.3.10
	smartstring-1.0.1
	static_assertions-1.1.0
	strsim-0.8.0
	structopt-0.3.26
	structopt-derive-0.4.18
	syn-1.0.98
	tera-1.16.0
	textwrap-0.11.0
	thiserror-1.0.31
	thiserror-impl-1.0.31
	thread_local-1.1.4
	time-0.3.11
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	toml-0.5.9
	typenum-1.15.0
	ucd-trie-0.1.4
	unic-char-property-0.9.0
	unic-char-range-0.9.0
	unic-common-0.9.0
	unic-segment-0.9.0
	unic-ucd-segment-0.9.0
	unic-ucd-version-0.9.0
	unicode-bidi-0.3.8
	unicode-ident-1.0.2
	unicode-normalization-0.1.21
	unicode-segmentation-1.9.0
	unicode-width-0.1.9
	url-2.2.2
	vcpkg-0.2.15
	vec_map-0.8.2
	version_check-0.9.4
	walkdir-2.3.2
	wasi-0.11.0+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="Generates an ebuild for a package using the in-tree eclasses."
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/gentoo/cargo-ebuild"
SRC_URI="https://gitweb.gentoo.org/proj/${PN}.git/snapshot/${P}.tar.bz2
	$(cargo_crate_uris)"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64"

DEPEND="
	dev-libs/openssl:0=
	net-libs/libssh2:=
"

RDEPEND="
	${DEPEND}
	virtual/rust
"

QA_FLAGS_IGNORED="usr/bin/cargo-ebuild"

src_prepare() {
	default
	pushd "${ECARGO_HOME}"/gentoo > /dev/null || die
	eapply "${FILESDIR}/${P}-libressl.patch"
	popd > /dev/null || die
}

src_configure() {
	export LIBGIT2_SYS_USE_PKG_CONFIG=1 LIBSSH2_SYS_USE_PKG_CONFIG=1 PKG_CONFIG_ALLOW_CROSS=1
	cargo_src_configure
}

src_install() {
	cargo_src_install
	einstalldocs
}
