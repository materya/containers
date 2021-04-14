# MetaTrader®

[![License][license-image]][license-url]
![Maintenance](https://img.shields.io/maintenance/yes/2021?style=flat-square)

Wine headless container with prefix preinstalled with MetaTrader® and Python.

Based on [`pywine-3.8` image][base-image-url].

Wine default env configuration are :

| Env Name | Value |
|-|-|
| WINEARCH | `win64` (default) |
| WINEDEBUG | `-all` |
| WINEPREFIX | `/opt/pywine` |

## Available versions

[image-size-badge]: https://img.shields.io/docker/image-size/materya/wine-mt/latest?style=flat-square
[image-url]: https://github.com/orgs/materya/packages/container/wine-mt/latest
[![Size][image-size-badge]][image-url]

**[4](https://github.com/orgs/materya/packages/container/wine-mt/4)**,
**[5](https://github.com/orgs/materya/packages/container/wine-mt/5)**,
**[latest](https://github.com/orgs/materya/packages/container/wine-mt/latest)**

## License

This container spec source code is licensed under the [GPL-3.0](LICENSE)

It downloads and installs inside a wine prefix the MetaTrader® software which is a [MetaQuotes®](https://www.metaquotes.net) product & Trademark, all right reserved. See [MetaQuotes® Legal Information](https://www.metaquotes.net/en/legal).


[base-image-url]: https://github.com/orgs/materya/packages/container/package/pywine-3.8
[license-image]: https://img.shields.io/github/license/materya/containers?style=flat-square
[license-url]: LICENSE
