ACLOCAL_AMFLAGS = -I build-aux

AM_CFLAGS = \
	-I$(top_srcdir)/include $(OPENMP_CFLAGS) \
	-fvisibility=hidden \
	-fopenmp=libomp \
	-std=c99 \
	-std=gnu99 \
	-DBLAKE3_NO_AVX512 \
	-DBLAKE3_NO_SSE41 \
	-DBLAKE3_NO_SSE2 \
	-DBLAKE3_NO_AVX2

EXTRA_DIST = LICENSE 3rdparty/libsais-LICENSE README.md

pkgconfig_DATA = qbdiff.pc

include_HEADERS = include/libqbdiff.h
noinst_HEADERS = include/libqbdiff_private.h include/libsais.h include/libsais64.h include/blake3.h include/blake3_impl.h

lib_LTLIBRARIES = libqbdiff.la
libqbdiff_la_SOURCES = src/libqbdiff.c \
	src/libsais.c src/libsais64.c \
	src/blake3_dispatch.c src/blake3_portable.c src/blake3.c

libqbdiff_la_LDFLAGS = -no-undefined -version-info 0:0:0

bin_PROGRAMS = qbdiff qbpatch
qbdiff_CFLAGS = $(AM_CFLAGS)
qbdiff_SOURCES = src/qbdiff.c
qbpatch_CFLAGS = $(AM_CFLAGS)
qbpatch_SOURCES = src/qbpatch.c
qbdiff_LDADD = libqbdiff.la
qbpatch_LDADD = libqbdiff.la

dist_man_MANS = man/qbdiff.1 man/qbpatch.1

CLEANFILES = $(bin_PROGRAMS)

# AM_DEFAULT_VERBOSITY = 1

# End standard generic autotools stuff

# Begin developer convenience targets

.PHONY: format
format: $(qbdiff_SOURCES) $(qbpatch_SOURCES) $(libqbdiff_la_SOURCES) $(include_HEADERS) $(noinst_HEADERS)
	clang-format -i $^

.PHONY: cloc
cloc: $(qbdiff_SOURCES) $(qbpatch_SOURCES) $(libqbdiff_la_SOURCES) $(include_HEADERS) $(noinst_HEADERS)
	cloc $^
