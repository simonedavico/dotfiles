# dotfiles

Simple scripts to automate most of the setup for a new macOS installation.
The scripts are idempotent and can be run safely more than once.
## Install

* Clone the repository;
* Make `run.sh` and scripts in `lib/` executables;
* Run `run.sh`: 

```sh
./run.sh 2>&1 | tee ~/setup.log
```

Optionally, review the log:

```sh
less ~/setup.log
```

## What it sets up

* Basics: XCode CLI utils, Homebrew, `fnm` and Node.js;
* Git: update git with latest from Homebrew, setup git config, generate an SSH key;
* Tools: a bunch of tools via Homebrew;
* Apps: a bunch of apps via Homebrew Cask and `mas`;
* Erlang/Elixir: `erlang` and `Elixir` installs via `asdf`;
* Shell: setup `oh-my-zsh` with `powerline10k` theme and Fira Code Mono; setup `skhd` and `yabai`;
* Settings: set a bunch of useful macOS settings.
