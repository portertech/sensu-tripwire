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
