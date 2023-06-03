# Datascience

As its name stands, an out-of-the-box ready environment for datascience projects in python, including all the mandatory libs & toolkits to do just that.

## Available versions

| Version | Description |
|-|-|
| **[3.8-alpine](https://github.com/orgs/materya/packages/container/datascience/3.8-alpine)** | DEPRECATED - See [Side Note About Alpine & Python Images](#side-note-about-alpine-python-images) |
| **[3.8-buster-slim](https://github.com/orgs/materya/packages/container/datascience/3.8-buster-slim)** | Recommended Image |

## Python Packages

* **matplotlib**: plotting library for Python and its numerical mathematics extension NumPy
* **nltk**: suite of libraries and programs for symbolic and statistical natural language processing for Engl**ish
* **numpy**: support for large, multi-dimensional arrays and matrices
* **pandas**: library providing high-performance, easy-to-use data structures and data analysis tools
* **scikit-learn**: machine learning library integrates with NumPy and SciPy
* **scipy**: library used for scientific computing and technical computing
* **ta-lib**: the well known essential Technical Analysis library

## Side Note About Alpine & Python Images

> [When used for] Python, Alpine Linux will quite often:
>
> 1. Make your builds much slower.
> 2. Make your images bigger.
> 3. Waste your time.
> 4. On occasion, introduce obscure runtime bugs.

See this [pertinent article](https://pythonspeed.com/articles/alpine-docker-python/) on the matter.
