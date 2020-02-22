# Sensu Tripwire

[![Bonsai Asset
Badge](https://img.shields.io/badge/Sensu%20Tripwire-Download%20Me-brightgreen.svg?colorB=89C967&logo=sensu)](https://bonsai.sensu.io/assets/portertech/sensu-tripwire)

## Table of Contents
- [Overview](#overview)
- [Usage examples](#usage-examples)
- [Configuration](#configuration)
  - [Asset registration](#asset-registration)
- [Building Tripwire assets](#building-tripwire-assets)
- [Contributing](#contributing)

## Overview

Sensu Tripwire is a collection of [Sensu Assets][10], packaging up
[Tripwire OSS](https://github.com/Tripwire/tripwire-open-source)
(version 2.4.3.7), making it easy to deploy an intrusion detection
system (IDS) to systems running the Sensu monitoring Agent.

The Tripwire assets are currently compiled for amd64 systems, on
Alpine Linux (3.9.5), CentOS (6 and 7), and Debian (Stretch). The
included wrapper shell scripts are opinionated and include Tripwire
policy that may be less than ideal for your systems. If you run into
issues using the assets, please [open a GitHub
issue](https://github.com/portertech/sensu-tripwire/issues/new)!

## Usage examples

Initialize a Tripwire database.

```
tripwire-init.sh
```

Run a full system check (and initialize the database if missing).

```
tripwire-check.sh
```

Run a Tripwire check on a specific web application.

```
tripwire-check.sh /var/www/*
```

## Configuration

### Asset registration

```
sensuctl asset add portertech/sensu-tripwire
```

If you're using an earlier version of sensuctl, you can find the asset on the [Bonsai Asset Index](https://bonsai.sensu.io/assets/portertech/sensu-tripwire).


## Building Tripwire Assets

Docker is required to build the Tripwire assets.

From the local path of the sensu-tripwire repository:

```
./build.sh
```

## Additional notes

This project can be used in combination with the
[sensu-plugins-tripwire
project](https://github.com/sensu-plugins/sensu-plugins-tripwire).

Help (as of version 1.2.0).

```
Usage: check-tripwire.rb (options)
    -b, --binary path/to/tripwire    tripwire binary to use, in case you hide yours
    -f path/to/configfile,           Configuration to use for the check
        --config-file
    -c, --critical critical severity Tripwire severity greater than this is a critical error
    -d path_or_url_to_database. if an http url is supplied the database will be retrieved prior to the check,
        --database                   Database to use for the check
    -P, --password PASSWORD          Password to unlock the keyfile
    -s, --site-key path/to/sitekey   Site key used to decrypt the database that will be used in the validation
    -w, --warn warning severity      Tripwire severity greater than this is warning
```

Register the required assets.

```
sensuctl asset add portertech/sensu-tripwire
sensuctl asset add sensu/sensu-ruby-runtime
sensuctl asset add sensu-plugins/sensu-plugins-tripwire
```

Example Sensu check configuration.

``` yaml
type: CheckConfig
api_version: core/v2
metadata:
  name: tripwire
spec:
  command: check-tripwire.rb --binary tripwire.sh --config-file /tmp/tw/tw.cfg
  interval: 30
  runtime_assets:
  - portertech/sensu-tripwire
  - sensu-plugins/sensu-plugins-tripwire
  - sensu/sensu-ruby-runtime
  subscriptions:
  - linux
  publish: true
```

## Contributing

For more information about contributing to this plugin, see [Contributing][1].

[1]: https://github.com/sensu/sensu-go/blob/master/CONTRIBUTING.md
[2]: https://github.com/sensu-community/sensu-plugin-sdk
[3]: https://github.com/sensu-plugins/community/blob/master/PLUGIN_STYLEGUIDE.md
[4]: https://github.com/sensu-community/check-plugin-template/blob/master/.github/workflows/release.yml
[5]: https://github.com/sensu-community/check-plugin-template/actions
[6]: https://docs.sensu.io/sensu-go/latest/reference/checks/
[7]: https://github.com/sensu-community/check-plugin-template/blob/master/main.go
[8]: https://bonsai.sensu.io/
[9]: https://github.com/sensu-community/sensu-plugin-tool
[10]: https://docs.sensu.io/sensu-go/latest/reference/assets/
