FROM debian:buster-slim

USER root

ENV DEBIAN_FRONTEND noninteractive

ARG APT_FLAGS="-y -qq --no-install-recommends --no-install-suggests"
ARG CORE_PACKAGES="\
  ca-certificates \
  curl \
  xauth \
  xvfb \
"
RUN apt-get update ${APT_FLAGS} \
  && apt-get install ${APT_FLAGS} ${CORE_PACKAGES} \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY apt /etc/apt

ARG WINE_BRANCH
ARG WINE_VERSION
ARG WINE_PACKAGES="\
  libfaudio0 \
  winbind \
  winehq-${WINE_BRANCH}=${WINE_VERSION} \
"
RUN dpkg --add-architecture i386 \
  && apt-get update ${APT_FLAGS} \
  && apt-get install ${APT_FLAGS} ${WINE_PACKAGES} \
  && apt-get autoremove ${APT_FLAGS} \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ARG WINETRICKS_URL="https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
RUN curl -sL ${WINETRICKS_URL} | install /dev/stdin /usr/local/bin/winetricks

ARG CREATED_DATE
ARG REFNAME
ARG REPOSITORY

LABEL org.opencontainers.image.authors="Richard 'Sylver' Kemp <sylver@materya.io>"
LABEL org.opencontainers.image.created=${CREATED_DATE}
LABEL org.opencontainers.image.description="Image containing a minimal Wine ${WINE_BRANCH} environment based on debian buster-slim. Headless with Xvfb."
LABEL org.opencontainers.image.documentation="${REPOSITORY}/specs/wine"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
LABEL org.opencontainers.image.ref.name=${REFNAME}
LABEL org.opencontainers.image.revision=
LABEL org.opencontainers.image.source=${REPOSITORY}
LABEL org.opencontainers.image.title="Wine ${WINE_BRANCH} Headless Base Container"
LABEL org.opencontainers.image.url="${REPOSITORY}/specs/wine"
LABEL org.opencontainers.image.vendor="Materya"
LABEL org.opencontainers.image.version=${WINE_VERSION}

CMD ["/bin/bash"]
