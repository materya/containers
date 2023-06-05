# syntax=docker/dockerfile:1

# Use the official Alpine PHP image as base.
ARG PHP_VERSION=8.1
ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS phpdev

#------------------------------------------------------------------------------
# Install Composer

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

#------------------------------------------------------------------------------
# Configure PHP in development mode

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

#------------------------------------------------------------------------------
# Install Basic Packages

ARG PACKAGES="\
  make \
  su-exec \
"
RUN --mount=type=cache,mode=0755,sharing=locked,id=apk-cache,target=/var/cache/apk <<EOT
  apk update
  apk upgrade
  apk add ${PACKAGES}
EOT

#------------------------------------------------------------------------------
# Install PHP Extensions

# https://xdebug.org/docs/compat#versions
ARG XDEBUG_VERSION=3.1.6
ARG PECL_PACKAGES="\
  xdebug-${XDEBUG_VERSION} \
  pcov \
"

ARG PECL_CACHE=/tmp/pecl

RUN --mount=type=cache,mode=0755,sharing=locked,id=apk-cache,target=/var/cache/apk \
  --mount=type=cache,mode=0755,sharing=locked,id=pecl-cache-${PHP_VERSION},target=${PECL_CACHE} \
<<EOT
  set -e -x

  # Get the extension directory
  PHP_EXT_DIR=$(php-config --extension-dir)

  # Restore cache, if some
  cp -R ${PECL_CACHE}/* ${PHP_EXT_DIR} || true

  # Install build deps
  apk add --virtual .build-deps ${PHPIZE_DEPS} linux-headers

  # Install missing pecl packages
  for package in ${PECL_PACKAGES}; do
    [ -z "$(find ${PHP_EXT_DIR} -name ${package%-*}.so)" ] && pecl install ${package}
    docker-php-ext-enable ${package%-*}
  done

  # Update cache
  cp -R ${PHP_EXT_DIR}/* ${PECL_CACHE}

  # Cleanup build deps
  apk del -f .build-deps
EOT

#------------------------------------------------------------------------------
# Install default xdebug.ini

COPY ./docker/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

#------------------------------------------------------------------------------
# Create a dedicated user

ARG USER=phpdev
ENV DOCKER_USER=${USER}
ARG UID=1000
ARG GID=1000

RUN <<EOT
  addgroup -g ${GID} ${USER}
  adduser -D -s /bin/bash -u ${UID} -G ${USER} -G www-data ${USER}
EOT

WORKDIR /home/${USER}

#------------------------------------------------------------------------------
# Entrypoint

COPY ./docker/entrypoint.sh /opt/docker/
ENTRYPOINT ["/opt/docker/entrypoint.sh"]

#------------------------------------------------------------------------------
# Labels

ARG CREATED_DATE
ARG REPOSITORY
ARG REVISION
ARG URL

LABEL org.opencontainers.image.created=${CREATED_DATE}
LABEL org.opencontainers.image.authors="Richard 'Sylver' Kemp <sylver@materya.io>"
LABEL org.opencontainers.image.url=${URL}
LABEL org.opencontainers.image.documentation=${URL}/README.md
LABEL org.opencontainers.image.source=${URL}
LABEL org.opencontainers.image.version=${PHP_VERSION}
LABEL org.opencontainers.image.revision=${REVISION}
LABEL org.opencontainers.image.vendor="Materya"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
LABEL org.opencontainers.image.ref.name=${REPOSITORY}:${PHP_VERSION}
LABEL org.opencontainers.image.title="PHP ${PHP_VERSION} Development Container"
LABEL org.opencontainers.image.description="A lightweight base image for PHP projects development."
LABEL org.opencontainers.image.base.digest=${BASE_DIGEST}
LABEL org.opencontainers.image.base.name=${BASE_IMAGE}

#------------------------------------------------------------------------------
# Final command

CMD ["php", "-a"]
