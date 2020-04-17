# User configuration

# Allow case insensitive matching if no sensitive matches exist
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# <C-W> delete word or path component
my-backward-delete-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N my-backward-delete-word
bindkey '^W' my-backward-delete-word

export EXA_COLORS="\
da=38;5;240:uu=38;5;250:\
*.nix=38;5;228:*.md=31;1:\
"

# general
alias l='exa --all --git-ignore'
alias ls='exa --git-ignore'
alias ll='exa --all --long'
alias lll='exa --all --long --tree --level=2'

alias dr='direnv reload'

alias f='fg'

# git
alias m='clear && ll && echo "" && (git status 2> /dev/null; exit 0)'
alias ggr='cd $(git rev-parse --show-toplevel)'

alias gcl='git clone'

alias gs='git status'
alias gss='git show --stat'
alias glg='git log --stat --graph --relative-date --minimal'
alias grlg='git reflog'

alias ga='git add'
alias gaa='git add --all'
alias gco='git checkout'
alias gcob='git checkout -b'
alias grm='git rm -r'

alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -v --amend'
alias gcam='git commit -v -a --amend'

alias gr='git reset'
alias grh='git reset --hard'

alias gd='git diff --minimal'
alias gds='git diff --minimal --staged'
alias gda='git diff --minimal HEAD'

alias gmt='git mergetool --no-prompt'
alias gm='git merge'
alias gma='git merge --abort'
alias grb='git rebase'
alias grbm='git fetch && git rebase origin/master'
alias grbi='git rebase --interactive'
alias grbim='git fetch && git rebase --interactive origin/master'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias gcp='git cherry-pick'

alias gb='git branch'
alias gf='git fetch'
alias gp='git push --set-upstream origin $(git branch --show-current)'
alias gpf='git push --force-with-lease --set-upstream origin $(git branch --show-current)'
alias gl='git pull origin $(git branch --show-current)'
alias gptags='git push --tags';
alias gpftags='git push --force-with-lease --tags';

alias gre='git remote'
alias grea='git remote add'
alias greao='git remote add origin'
alias greau='git remote add upstream'

alias gsup='git standup'
alias ggone='git gone'

# docker
alias dlast='docker ps -l -q';
alias dll='docker container ls -a';
alias dkillall='docker container kill $(docker container ls -qa)'
alias drmall='docker container rm $(docker container ls -qa)'

alias k='kubectl'
