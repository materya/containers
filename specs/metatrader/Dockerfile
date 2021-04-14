ARG BASE_IMAGE

FROM ${BASE_IMAGE}

USER root
RUN mv /opt/pywine /opt/mtwine
USER cloud

ENV DEBIAN_FRONTEND noninteractive
ENV WINEDEBUG fixme-all
ENV WINEPREFIX /opt/mtwine

ARG APT_FLAGS="-y -qq --no-install-recommends --no-install-suggests"
ARG WORKDIR=/install

WORKDIR ${WORKDIR}

ARG MT_VERSION
ARG MT_SETUP_URL="https://download.mql5.com/cdn/web/metaquotes.software.corp/mt${MT_VERSION}/mt${MT_VERSION}setup.exe"
RUN curl -sL ${MT_SETUP_URL} | install /dev/stdin mtsetup.exe \
  && xvfb-run sh -c "\
    wine ./mtsetup.exe /auto; \
    wineserver -w" \
  && rm mtsetup.exe
RUN xvfb-run sh -c "\
  wine pip install MetaTrader; \
  wineserver -w"

ENV WINEDEBUG -all

ARG CREATED_DATE
ARG REFNAME
ARG REPOSITORY

LABEL org.opencontainers.image.authors="Richard 'Sylver' Kemp <sylver@materya.io>"
LABEL org.opencontainers.image.created=${CREATED_DATE}
LABEL org.opencontainers.image.description="Image containing a wine headless prefix with MetaTrader® ${MT_VERSION} installed."
LABEL org.opencontainers.image.documentation="${REPOSITORY}/specs/metatrader"
LABEL org.opencontainers.image.licenses="https://www.metaquotes.net/en/legal"
LABEL org.opencontainers.image.ref.name=${REFNAME}
LABEL org.opencontainers.image.revision=
LABEL org.opencontainers.image.source=${REPOSITORY}
LABEL org.opencontainers.image.title="Headless Wine for MetaTrader®"
LABEL org.opencontainers.image.url="${REPOSITORY}/specs/metatrader"
LABEL org.opencontainers.image.vendor="Materya"
LABEL org.opencontainers.image.version=${MT_VERSION}

CMD ["/bin/bash"]
