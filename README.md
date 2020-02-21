# Sensu Tripwire

## Table of Contents
- [Overview](#overview)
- [Usage examples](#usage-examples)
- [Configuration](#configuration)
  - [Asset registration](#asset-registration)
- [Building Tripwire assets](#building-tripwire-assets)
- [Contributing](#contributing)

## Overview

Sensu Tripwire is a collection of [Sensu Assets][10], packaging up Tripwire OSS (version 2.4.3.7), making it easy to deploy an intrusion detection system (IDS) to systems running the Sensu monitoring Agent.

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

Example run.

```
check-tripwire.rb --binary tripwire.sh --config-file /tmp/tw/tw.cfg
```

Register the required assets.

```
sensuctl asset add portertech/sensu-tripwire
sensuctl asset add sensu/sensu-ruby-runtime
sensuctl asset add sensu-plugins/sensu-plugins-tripwire
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
