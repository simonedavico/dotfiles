# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Makes homebrew git win over OS X git. Revert to line above if it
# causes problems
export PATH=/usr/local/bin:$HOME/bin:$PATH
export PATH="/usr/local/opt/curl/bin:$PATH"
# add helm 2.8.2
export PATH="~/helm:$PATH"
# add up to date ruby from brew
export PATH="/usr/local/opt/ruby/bin:$PATH"
# add jetbrains CLI scripts
export PATH="/Users/sdavico/jetbrains_scripts:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=/Users/sdavico/.oh-my-zsh

# Kubernetes clusters config
export KUBECONFIG=~/.kube/config
export KUBE_EDITOR="code -w"
# export SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW=true

# corner related stuff
export LOKALISE_API_TOKEN=<nope>

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="spaceship"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Android SDK
export ANDROID_HOME=~/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

# GraalVM
export GRAALVM_HOME=$HOME/.sdkman/candidates/java/19.2.1-grl
export PATH=${PATH}:${GRAALVM_HOME}/bin

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions kubectl docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias retimg="gulp dev --deployPath=/Users/sdavico/Development/retim-trunk/retim-war/target/retim/retim/"

# Cleanup local git branches. Explanation:
# git branch -vv: show local branches with info about remote
# grep ': gone]': match gone branches
# grep -v "\*": fetch only lines not containing an asterisk (current branch)
# awk '{print $1}': extracts local branch name
# xargs -r git branch -D: delete local branches (also not fully merged, downgrade to -d to avoid)
alias gbclean="git branch -vv | grep ': gone]' | grep -v \"\*\" | awk '{print $1}' | gxargs -r git branch -D"

# use bat as a better cat
alias cat=bat

# handy command to run a busybox pod on k8s
alias kubesh="kubectl run -i --rm --tty busybox --image=busybox --restart=Never -- sh"
alias mongopod="kubectl run -i --rm --tty busybox --image=mongoclient/mongoclient --restart=Never -- sh"

# Quick launch pixel 2 AVD 
avd() {
  AVD_NAME=${1-Pixel_2_XL_API_P}
  echo "about to launch avd $AVD_NAME"
  ~/Library/Android/sdk/emulator/emulator -avd $AVD_NAME -dns-server 8.8.8.8,8.8.4.4 &
  echo "avd started"  
  sleep 30; echo "Running avd in background, about to sync date..." && adb shell su root date $(date +%m%d%H%M%Y.%S)  
}

# z script
. /usr/local/etc/profile.d/z.sh

if [[ $ITERM_SESSION_ID ]]; then
  # Display the current git repo, or directory, in iterm tabs.
  get_iterm_label() {
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      local directory
      directory=${PWD##*/}
      echo -ne "\\033];$directory\\007"
    else
      local branch
      local branchdir
      branchdir=$(basename "$(git rev-parse --show-toplevel)")
      branch=$(git branch 2>/dev/null | grep -e '\* ' | sed "s/^..\(.*\)/{\1}/")
      echo -ne "\\033];$branchdir $branch\\007"
    fi
  }
  export PROMPT_COMMAND=get_iterm_label;"${PROMPT_COMMAND}"
fi

export TERM=xterm-256color
# source "/Users/sdavico/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
source "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

#load fastlane lane names autocomplete
# . ~/.fastlane/completions/completion.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# fnm
eval "$(fnm env --multi)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sdavico/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sdavico/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sdavico/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sdavico/google-cloud-sdk/completion.zsh.inc'; fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,bold,underline"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/sdavico/.sdkman"
[[ -s "/Users/sdavico/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/sdavico/.sdkman/bin/sdkman-init.sh"
