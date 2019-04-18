# ⏰ jobcantan

CLI for punching in/out by Jobcan via Slack command.

## Installation

### homebrew

```console
$ brew update
$ brew tap msroz/jobcantan
$ brew install jobcantan
```

### git clone

```console
$ brew update && brew install crystal-lang
$ git clone git@github.com:msroz/jobcantan.git
$ cd jobcantan
$ make install
```

## Usage

```console
$ jobcantan --init
$ vim $HOME/.config/jobcantan.yml
```

```console
$ jobcantan --help

jobcantan - CLI for punching in/out in Jobcan via Slack command.

Usage: jobcantan [options] message
  -c, --config CONFIG_FILE
  -h, --help
  -v, --version
      --show-config
      --init
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/msroz/jobcantan/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [msroz](https://github.com/msroz) - creator and maintainer
