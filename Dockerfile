FROM amd64/debian:bookworm-slim AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    autoconf \
    automake \
    clang \
    liblzma-dev \
    libomp-dev \
    libtool \
    m4 \
    make \
    pkg-config \
    git \
    wget \
    unzip

WORKDIR /app
RUN wget -q https://github.com/akorda/qbdiff/archive/refs/heads/main.zip \
    && unzip main.zip -d /app

WORKDIR /app/qbdiff-main
RUN autoreconf --install \
    && ./configure \
    && make \
    && make install

FROM amd64/debian:bookworm-slim AS runtime-base
RUN apt-get update && apt-get install -y --no-install-recommends \
    libomp5=1:14.0-55.7~deb12u1 \
    && rm -rf /var/lib/apt/lists/*

FROM runtime-base AS app-common
COPY --from=build /app/qbdiff-main/.libs /app/.libs
COPY --from=build /usr/local/lib/libqbdiff.so /usr/local/lib/libqbdiff.so
RUN ldconfig

FROM app-common AS qbdiff
COPY --from=build /app/qbdiff-main/qbdiff /app/qbdiff
WORKDIR /app
ENTRYPOINT ["./qbdiff"]

FROM app-common AS qbpatch
COPY --from=build /app/qbdiff-main/qbpatch /app/qbpatch
WORKDIR /app
ENTRYPOINT ["./qbpatch"]