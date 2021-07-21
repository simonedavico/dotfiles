#!/usr/bin/env bash

# Process option selection.
# Parameters: $1 (required) - The option to process.
process_option() {
  case $1 in
    'b')
      bin/install_basics;;
    'g')
      bin/install_git;;
    'f')
      bin/install_homebrew_formulas;;
    'a')
      bin/install_apps;;
    's')
      bin/install_shell_and_dotfiles;;
    'e')
      bin/install_erlang_and_elixir;;
    'x')
      bin/setup_macos_settings;;
    'q');;
    *)
      printf "ERROR: Invalid option.\n";;
  esac
}

while true; do
  if [[ $# == 0 ]]; then
    printf "\nUsage: run OPTION\n"
    printf "Install:\n"
    printf "  [b]  Basics: brew, fnm, node \n"
    printf "  [g]  Install git and generate an SSH key for GitHub.\n"
    printf "  [f]  Homebrew Formulas.\n"
    printf "  [a]  Apps.\n"
    printf "  [s]  Shell and dotfiles.\n"
    printf "  [e]  erlang and Elixir.\n"
    printf "  [x]  Setup macOS settings.\n"
    printf "  [q]  Quit/Exit.\n\n"
    read -pr "Enter selection: " response
    printf "\n"
    process_option "$response"
  else
    process_option "$1"
  fi

  break
done