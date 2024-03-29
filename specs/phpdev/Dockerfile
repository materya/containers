# syntax=docker/dockerfile:1

# Use the official Alpine PHP image as base.
ARG PHP_MINOR_VERSION=8.1
ARG BASE_IMAGE=library/php:${PHP_MINOR_VERSION}-cli-alpine
FROM ${BASE_IMAGE} AS phpdev

ARG PHP_MINOR_VERSION

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
ENV XDEBUG_VERSION=${XDEBUG_VERSION}
ARG PECL_PACKAGES="\
  xdebug-${XDEBUG_VERSION} \
  pcov \
"

ARG PECL_CACHE=/tmp/pecl

RUN --mount=type=cache,mode=0755,sharing=locked,id=apk-cache,target=/var/cache/apk \
  --mount=type=cache,mode=0755,sharing=locked,id=pecl-cache-${PHP_MINOR_VERSION},target=${PECL_CACHE} \
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
# Create a dedicated user

ARG USER=phpdev
ARG UID=1000
ARG GID=1000

RUN <<EOT
  addgroup -g ${GID} ${USER}
  adduser -D -s /bin/ash -u ${UID} -G ${USER} -G www-data ${USER}
  touch /var/log/xdebug.log && chown ${USER}:www-data /var/log/xdebug.log
EOT

WORKDIR /home/${USER}

# Export user's related variables to the env for use by other containers
ENV CONTAINER_USER_NAME=${USER}
ENV CONTAINER_USER_UID=${UID}
ENV CONTAINER_USER_GID=${GID}

#------------------------------------------------------------------------------
# Entrypoint

COPY ./docker/* /opt/docker/
ENTRYPOINT ["/opt/docker/entrypoint.sh"]

#------------------------------------------------------------------------------
# Labels

ARG BASE_DIGEST
ARG BASE_IMAGE
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
LABEL org.opencontainers.image.ref.name=${REPOSITORY}:${PHP_MINOR_VERSION}
LABEL org.opencontainers.image.title="PHP ${PHP_MINOR_VERSION} Development Container"
LABEL org.opencontainers.image.description="A lightweight base image for PHP projects development."
LABEL org.opencontainers.image.base.digest=${BASE_DIGEST}
LABEL org.opencontainers.image.base.name=${BASE_IMAGE}

#------------------------------------------------------------------------------
# Final command

CMD ["php", "-a"]
