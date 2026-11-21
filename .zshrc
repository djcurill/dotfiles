# Load and initialize zsh completion system
autoload -Uz compinit
compinit

# Modify PATH
export PATH=$HOME/bin:$HOME/.local/bin:$HOME/usr/local/bin:$PATH
export PATH=$PATH:$(go env GOPATH)/bin

# Doximity configuration
test -f $HOME/.doximityrc && source $HOME/.doximityrc

# Kubernetes
source <(kubectl completion zsh)

# ZSH configuration
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Bindkeys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

## Other aliases
test -f $HOME/.aliases && source $HOME/.aliases

eval "$(starship init zsh)"
