# PHP Dev

[![License][license-image]][license-url]
![Maintenance](https://img.shields.io/maintenance/yes/2023?style=flat-square)

A lightweight base image for PHP projects development, specifically aiming at providing the right environment for devcontainers and/or CI test runners or builders.  
It can also serve as a solid base for more complex images.

## Available versions

| Version | Description |
|-|-|
| **[7.1](https://github.com/orgs/materya/packages/container/phpdev)** | [PHP 7.1](https://www.php.net/releases/7_1_0.php) |
| **[7.2](https://github.com/orgs/materya/packages/container/phpdev)** | [PHP 7.2](https://www.php.net/releases/7_2_0.php) |
| **[7.3](https://github.com/orgs/materya/packages/container/phpdev)** | [PHP 7.3](https://www.php.net/releases/7_3_0.php) |
| **[7.4](https://github.com/orgs/materya/packages/container/phpdev)** | [PHP 7.4](https://www.php.net/releases/7_4_0.php) |
| **[8.0](https://github.com/orgs/materya/packages/container/phpdev)** | [PHP 8.0](https://www.php.net/releases/8_0_0.php) |
| **[8.1](https://github.com/orgs/materya/packages/container/phpdev)** | [PHP 8.1](https://www.php.net/releases/8_1_0.php) |
| **[8.2](https://github.com/orgs/materya/packages/container/phpdev)** | [PHP 8.2](https://www.php.net/releases/8_2_0.php) |
| **[latest](https://github.com/orgs/materya/packages/container/phpdev/latest)** | [PHP 8.2](https://www.php.net/releases/8_2_0.php) |

## Preinstalled Extensions

* **XDebug**: A PHP extension for debugging and profiling PHP applications.
* **PCov**: A PHP extension for code coverage analysis during testing.

## Exposed Env variables

| Variable Name | Value | Detail |
|-|-|-|
| `CONTAINER_USER_NAME` | `phpdev` | The user running the container |
| `CONTAINER_USER_UID` | `1000` | The user id of the user running the container |
| `CONTAINER_USER_GID` | `1000` | The group id of the user running the container |

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
