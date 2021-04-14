ARG BASE_IMAGE

FROM ${BASE_IMAGE}

USER root

ENV DEBIAN_FRONTEND noninteractive
ENV WINEDEBUG fixme-all
ENV WINEPREFIX /opt/pywine

ARG APT_FLAGS="-y -qq --no-install-recommends --no-install-suggests"
ARG CORE_PACKAGES="\
  cabextract \
  procps \
"
ARG USER=cloud
ARG WORKDIR=/install

RUN mkdir -p /tmp/.X11-unix \
  && chmod 1777 /tmp/.X11-unix \
  && chown root /tmp/.X11-unix

RUN apt-get update ${APT_FLAGS} \
  && apt-get install ${APT_FLAGS} ${CORE_PACKAGES} \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash ${USER}
RUN mkdir -p ${WINEPREFIX} \
  && chown -R ${USER}:${USER} ${WINEPREFIX}
USER ${USER}

WORKDIR ${WORKDIR}

RUN winetricks win10

ADD scripts/initdll.sh .
RUN sh ./initdll.sh \
  && rm initdll.sh

ARG PY_VERSION
ARG PY_INSTALL_URL="https://www.python.org/ftp/python/${PY_VERSION}/python-${PY_VERSION}-amd64.exe"
RUN curl -sL ${PY_INSTALL_URL} | install /dev/stdin python.exe \
  && xvfb-run sh -c "\
    wine ./python.exe /quiet Include_doc=0 InstallAllUsers=1 PrependPath=1; \
    wineserver -w" \
  && rm python.exe
RUN xvfb-run sh -c "\
  wine python -m pip install --upgrade pip; \
  wineserver -w"

USER root
COPY ./scripts/entrypoint.sh /opt/entrypoint
RUN chmod a+x /opt/entrypoint
ENTRYPOINT ["/opt/entrypoint"]
WORKDIR /home/${USER}
RUN rm -rf ${WORKDIR}
ENV WINEDEBUG -all
USER ${USER}

ARG CREATED_DATE
ARG REFNAME
ARG REPOSITORY

LABEL org.opencontainers.image.authors="Richard 'Sylver' Kemp <sylver@materya.io>"
LABEL org.opencontainers.image.created=${CREATED_DATE}
LABEL org.opencontainers.image.description="Image containing a wine headless prefix with Python ${PY_VERSION} installed."
LABEL org.opencontainers.image.documentation="${REPOSITORY}/specs/pywine"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
LABEL org.opencontainers.image.ref.name=${REFNAME}
LABEL org.opencontainers.image.revision=
LABEL org.opencontainers.image.source=${REPOSITORY}
LABEL org.opencontainers.image.title="Headless Wine prefix for Python."
LABEL org.opencontainers.image.url="${REPOSITORY}/specs/pywine"
LABEL org.opencontainers.image.vendor="Materya"
LABEL org.opencontainers.image.version=${PY_VERSION}

CMD ["/bin/bash"]
