# PHP Dev

[![License][license-image]][license-url]
![Maintenance](https://img.shields.io/maintenance/yes/2023?style=flat-square)

A lightweight base image for PHP projects development, specifically aiming at providing the right environment for devcontainers and/or CI test runners or builders.  
It can also serve as a solid base for more complex images.

## Available versions

[7.1-size-badge]: https://img.shields.io/docker/image-size/materya/phpdev/7.1?style=flat-square
[7.1-url]: https://github.com/orgs/materya/packages/container/phpdev/7.1
[7.2-size-badge]: https://img.shields.io/docker/image-size/materya/phpdev/7.2?style=flat-square
[7.2-url]: https://github.com/orgs/materya/packages/container/phpdev/7.2
[7.3-size-badge]: https://img.shields.io/docker/image-size/materya/phpdev/7.3?style=flat-square
[7.3-url]: https://github.com/orgs/materya/packages/container/phpdev/7.3
[7.4-size-badge]: https://img.shields.io/docker/image-size/materya/phpdev/7.4?style=flat-square
[7.4-url]: https://github.com/orgs/materya/packages/container/phpdev/7.4
[8.0-size-badge]: https://img.shields.io/docker/image-size/materya/phpdev/8.0?style=flat-square
[8.0-url]: https://github.com/orgs/materya/packages/container/phpdev/8.0
[8.1-size-badge]: https://img.shields.io/docker/image-size/materya/phpdev/8.1?style=flat-square
[8.1-url]: https://github.com/orgs/materya/packages/container/phpdev/8.1
[latest-size-badge]: https://img.shields.io/docker/image-size/materya/phpdev/latest?style=flat-square
[latest-url]: https://github.com/orgs/materya/packages/container/phpdev/latest

| Version | Description | Badges|
|-|-|-|
| **[7.1](https://github.com/orgs/materya/packages/container/phpdev/7.1)** | [PHP 7.1](https://www.php.net/releases/7_1_0.php) | [![Size][7.1-size-badge]][7.1-url] |
| **[7.2](https://github.com/orgs/materya/packages/container/phpdev/7.2)** | [PHP 7.2](https://www.php.net/releases/7_2_0.php) | [![Size][7.2-size-badge]][7.2-url] |
| **[7.3](https://github.com/orgs/materya/packages/container/phpdev/7.3)** | [PHP 7.3](https://www.php.net/releases/7_3_0.php) | [![Size][7.3-size-badge]][7.3-url] |
| **[7.4](https://github.com/orgs/materya/packages/container/phpdev/7.4)** | [PHP 7.4](https://www.php.net/releases/7_4_0.php) | [![Size][7.4-size-badge]][7.4-url] |
| **[8.0](https://github.com/orgs/materya/packages/container/phpdev/8.0)** | [PHP 8.0](https://www.php.net/releases/8_0_0.php) | [![Size][8.0-size-badge]][8.0-url] |
| **[8.1](https://github.com/orgs/materya/packages/container/phpdev/8.1)** | [PHP 8.1](https://www.php.net/releases/8_1_0.php) | [![Size][8.1-size-badge]][8.1-url] |
| **[latest](https://github.com/orgs/materya/packages/container/phpdev/latest)** | [PHP 8.1](https://www.php.net/releases/8_1_0.php) | [![Size][latest-size-badge]][latest-url] |

## Preinstalled Extensions

* **XDebug**: A PHP extension for debugging and profiling PHP applications.
* **PCov**: A PHP extension for code coverage analysis during testing.

## Configuration

### XDebug

#### With Env variables

You can provide env variables to customize some settings in the [default configuration](./xdebug.ini) already applied.

| Variable Name | Value Type | Default Value |
|-|-|-|
| `XDEBUG_IDE` | String | VSCODE |
| `XDEBUG_PORT` | Port number | 9003 |

##### Example

```sh
docker run -e XDEBUG_PORT=9042 materya/phpdev-8.1
```

#### Full custom configuration

Alternatively you can provide your own configuration file replacement by mounting it into the container when running it, at the location `/usr/local/etc/php/conf.d/xdebug.ini.custom`

> NOTE: You cannot mount directly onto `/usr/local/etc/php/conf.d/xdebug.ini` because some overridings are applied by the entrypoint to the default configuration file if no custom one is provided.

##### Example

```sh
docker run -v /path/to/my/xdebug.ini:/usr/local/etc/php/conf.d/xdebug.ini.custom materya/phpdev-8.1
```

## License

[GPL-3.0](LICENSE)

[license-image]: https://img.shields.io/github/license/materya/containers?style=flat-square
[license-url]: LICENSE
