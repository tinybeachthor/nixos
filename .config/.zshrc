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
