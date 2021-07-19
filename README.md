# dotfiles

## Install

Download the script:

```sh
curl --remote-name https://raw.githubusercontent.com/simonedavico/dotfiles/master/setup.sh
```

Review the script (avoid running scripts you haven't read!):

```sh
less mac
```

Execute the downloaded script:

```sh
sh mac 2>&1 <email_address> | tee ~/setup.log
```

**N.B:** `email_address` will be configured as email address for the `git` client.

Optionally, review the log:

```sh
less ~/setup.log
```

## What it sets up

TODO: write this down
