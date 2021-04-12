# PyWine

Wine headless container with a ready to use prefix with Python.

Based on [`wine-stable` image](base-image-url).

Wine default env configuration are :

| Env Name | Value |
|-|-|
| WINEARCH | `win64` (default) |
| WINEDEBUG | `-all` |
| WINEPREFIX | `/opt/pywine` |

## Available versions

### Python 3.6

**[3.6.13](https://github.com/orgs/materya/packages/container/pywine-3.6/3.6.13)**,
**[latest](https://github.com/orgs/materya/packages/container/pywine-3.6/latest)**

### Python 3.7

**[3.7.10](https://github.com/orgs/materya/packages/container/pywine-3.7/3.7.10)**,
**[latest](https://github.com/orgs/materya/packages/container/pywine-3.7/latest)**

### Python 3.8

**[3.8.9](https://github.com/orgs/materya/packages/container/pywine-3.8/3.8.9)**,
**[latest](https://github.com/orgs/materya/packages/container/pywine-3.8/latest)**

### Python 3.9

**[3.9.4](https://github.com/orgs/materya/packages/container/pywine-3.9/3.9.4)**,
**[latest](https://github.com/orgs/materya/packages/container/pywine-3.9/latest)**


## License

[GPL-3.0](LICENSE)

[base-image-url]: https://github.com/orgs/materya/packages/container/package/wine-stable
