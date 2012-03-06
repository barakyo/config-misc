
### config for zsh
#
# reload with 'source ~/.zshrc'

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
autoload -Uz compinit
compinit
# End of lines added by compinstall


### autoload
autoload -U colors && colors
autoload -U zmv
autoload -Uz vcs_info


### setopt
setopt correct
setopt correctall


### aliase
alias -s pdf=evince
alias ls='ls --color=auto'


### hash
hash -d django=~/projects/django/


# keys
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word


### enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "$(dircolors -b ~/.dircolors)"
fi

### utf char only in xsessions
if [ $DISPLAY ]; then 
    pchar='►'
else
    pchar='>'
fi

### zstyle
#
zmodload -i zsh/complist
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
# zstyle ':completion:*:descriptions' format "%{$fg_bold[red]%}%d%{$reset_color%}"
zstyle ':completion:*:descriptions' format "%{$fg[green]%}%d%{$reset_color%}"
zstyle ':completion:*:corrections' format "%{$fg[yellow]%}%d%{$reset_color%}"
zstyle ':completion:*:messages' format "%{$fg[red]%}%d%{$reset_color%}"
zstyle ':completion:*:warnings' format "%{$fg[red]%}%d%{$reset_color%}"
 
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.BAK|*.bak|*.o|*.aux|*.toc|*.swp|*~)"
zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns
 
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' select-prompt '%S Match %M/%P %s'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
 
zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*' matcher-list 'm:{a-zA-z}={A-Za-z}'
 
zstyle ':completion::*:-command-:*:*' tag-order '! aliases functions'
 
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'


# nice prompt in git, bzr etc
precmd() {
  psvar=()
  vcs_info
  [[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_"
}


setprompt () {

    setopt prompt_subst
    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}

    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULRBAR=${altchar[u]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}
    PR_VBAR=${altchar[x]:--}

    PROMPT='
$PR_SHIFT_IN$PR_ULCORNER$PR_HBAR$PR_HBAR$PR_HBAR$PR_HBAR$PR_HBAR$PR_HBAR$PR_ULRBAR$PR_SHIFT_OUT [%{$fg[red]%}%T%{$reset_color%}]%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%}
$PR_SHIFT_IN$PR_VBAR$PR_SHIFT_OUT
$PR_SHIFT_IN$PR_LLCORNER$PR_HBAR$PR_HBAR$PR_SHIFT_OUT$pchar %(1v.%B%1v%f.)%b%# '

}

setprompt
