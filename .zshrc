# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH:$HOME/Library/Python/4.8/bin:$HOME/opt/homebrew/bin/
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/Users/pedro/Library/Python/3.9/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export EDITOR="vim"

# Path to your oh-my-zsh installation.
export ZSH="/Users/pedro/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="geoffgarside"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(asdf git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias srspec="spring rspec"
alias sstop="spring stop"
alias be="bundle exec"
alias ber="bundle exec rails"
alias berspec="bundle exec rspec"
alias k="kubectl"
alias rpi="ssh birds@192.168.0.89"
alias livedesk="/Applications/Livebook.app/Contents/MacOS/Livebook"
alias mikrus="ssh root@2a01:4f9:4a:27c1::288"
alias cleardns="sudo killall -HUP mDNSResponder"
alias ssh-openclaw="ssh claw@100.101.51.112"

# Git aliases
alias gph="git push origin HEAD"
alias gphf="git push origin HEAD --force-with-lease"
alias rgph="bundle exec rubocop --parallel && gph"
alias gpl="git pull origin"
alias gmg="git merge --no-ff"
alias gco="git co"
alias gbrclean="git br | grep -v 'master\|main' | xargs git br -D"
# That's for elefant only
alias gelefant="git cherry-pick 25da2974"

alias playh="npx playwright test --headed --project=chromium --project=chromium-har --reporter=line"
alias playl="npx playwright test --project=chromium --project=chromium-har --reporter=line"

aws-sso() {
  echo "Initiating AWS SSO..."
  tmp_out=$(mktemp)
  aws sso login --no-browser > "$tmp_out" 2>&1 &
  login_pid=$!
  trap 'rm -f "$tmp_out"; kill $login_pid 2>/dev/null; trap - INT TERM; return 130' INT TERM

  local retries=10
  while [ $retries -gt 0 ]; do
    url=$(grep -o 'https://[^ ]*' "$tmp_out" | head -n 1)
    code=$(grep -A 2 "enter the code:" "$tmp_out" | tail -n 1 | xargs)
    [ -n "$url" ] && [ -n "$code" ] && break
    sleep 0.5
    retries=$((retries - 1))
  done

  if [ -n "$url" ] && [ -n "$code" ]; then
    local final_url="${url}?user_code=${code}"
    echo "Opening Island..."
    open -a "Island" "$final_url"
    wait $login_pid
  else
    echo "Error: Capture failed."
    kill $login_pid
  fi
  rm -f "$tmp_out"
  trap - INT TERM
}

unsetopt share_history

eval "$(direnv hook zsh)"

export ERL_AFLAGS="-kernel shell_history enabled"

# bun completions
[ -s "/Users/pedro/.bun/_bun" ] && source "/Users/pedro/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Added by Windsurf
export PATH="/Users/pedro/.codeium/windsurf/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/pedro/.lmstudio/bin"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh --disable-up-arrow)"

# pnpm
export PNPM_HOME="/Users/pedro/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
ulimit -n 65536
ulimit -n 65536
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
