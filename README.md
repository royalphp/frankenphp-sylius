<p align="center">
    <img src="docs/frankenphp-sylius-logo.png" alt="Starting point for Sylius eCommerce powered by FrankenPHP" width="600" />
</p>

<h1 align="center">Sylius FrankenPHP Edition by RoyalPHP</h1>

<h6 align="center">This edition is based on the Sylius Standard Edition.</h6>

## About

A [Docker](https://docker.com)-based installer and runtime for the [Sylius](http://sylius.com) eCommerce with [FrankenPHP](https://frankenphp.dev) and [Caddy](https://caddyserver.com) inside!

![CI](https://github.com/royalphp/frankenphp-sylius/workflows/CI/badge.svg)

## Versions

| Repository Branch | Repository Tag | Sylius Version | Symfony Compatibility | PHP Compatibility |
|-------------------|----------------|----------------|-----------------------|-------------------|
| `2.x`             | `0.2.*`        | `^2.0`         | `^7.2`                | `^8.3`            |
| `1.x`             | `0.1.*`        | `^1.14`        | `^6.4`                | `^8.3`            |

## Getting Started

All control is via `Makefile`, to see all available commands, run `make`. For a quick start, execute the following command:

```shell
make setup
```

Under the hood, this command executes a few other commands needed to run your project for the first time,
and you won't need this command again (unless you want to reconfigure your project).
After successful execution of this command, you can open it in the browser at the standard url: https://localhost/

By default, you are working in a development environment, so `make` commands do not require additional options,
however, if you want to deploy your project to a production server, or run any command in production,
you explicitly need to specify the `PROJECT_MODE=prod` option, which defines the appropriate settings.

## Documentation

Documentation for "Symfony Docker" is available in the [*docs/symfony-docker*](docs/symfony-docker/index.md) folder.

Documentation for "FrankenPHP" is available at [frankenphp.dev/docs](https://frankenphp.dev/docs).

Documentation for "Sylius" is available at [docs.sylius.com](http://docs.sylius.com).

## Bug Tracking

If you want to report a bug or suggest an idea, please use [GitHub issues](https://github.com/royalphp/frankenphp-sylius/issues).

## License

This theme uses [MIT License](LICENSE.md).

## Authors

The theme was originally created by [RoyalPHP](https://github.com/royalphp).
See the list of [contributors](https://github.com/royalphp/frankenphp-sylius/contributors).
