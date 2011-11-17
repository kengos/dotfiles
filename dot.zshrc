# Git function
typeset -ga chpwd_functions
typeset -ga preexec_functions
function _set_rprompt_git() {
  local git_branch st color
  git_branch="${$(git symbolic-ref HEAD 2> /dev/null)#refs/heads/}"
  if [ $? != '0' ]; then
    RPROMPT="%{$fg_bold[white]%}[%~%]]%{${reset_color%}"
  else
    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
      color=%F{green}
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
      color=%F{yellow}
    elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
      color=%B%F{blue}
    else
      color=%B%F{red}
    fi
    RPROMPT="%{$fg_bold[white]%}[%~%]] [%{$color%}${git_branch}%{${reset_color}%}]"
  fi
}
chpwd_functions+=_set_rprompt_git
preexec_functions+=_set_rprompt_git
#function rprompt-git-current-branch {
#  local name st color
#  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
#    return
#  fi
#  name=`git branch 2> /dev/null | grep '^\*' | cut -b 3-`
#  if [[ -z $name ]]; then
#    return
#  fi
#
#  st=`git status 2> /dev/null`
#  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
#    color=%F{green}
#  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
#    color=%F{yellow}
#  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
#    color=%B%F{red}
#  else
#    color=%B%F{red}
#  fi
#  echo "[%{$color%}%{$name%}%{$reset_color%}]"
#}

# PROMPT function
function nprom () {
  case ${UID} in
    0)
      PROMPT="%{$fg_bold[green]%}%m%{$fg_bold[red]%}#%{$reset_color%} "
      PROMPT2="%{$fg[magenta]%}%_%{$reset_color%}%{$fg_bold[white]%}>>%{$reset_color%} "
      ;;
    *)
      # 左側
      PROMPT="%{${fg[cyan]}%}[%n@%m]%{${reset_color}%}$ "
      # 左側(2行目以降)
      PROMPT2="%B%{${fg[blue]}%}%_$%{${reset_color}%}%b"
      ;;
  esac
  #RPROMPT="%{$fg_bold[white]%}[%~%]]`rprompt-git-current-branch`"
  # コマンドミス時
  SPROMPT="%{$fg_bold[red]%}correct%{$reset_color%}: %R -> %r ? "
}

################################################################

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit
compinit
bindkey -e

# ls colors
autoload colors; colors
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export EDITOR='vim'
export LANG='ja_JP.UTF-8'

# option
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt list_packed
setopt auto_menu
setopt prompt_subst
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history
setopt extended_history
# history
HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=100000
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# prompt setting
nprom

# Alias Settings
alias v='vim'
alias g="git"
alias gb="git branch"

# ls options
case "${OSTYPE}" in
  freebsd*|darwin*)
    alias ls='ls -G'
    ;;
  linux*)
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    ;;
esac

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias tf='tail -f'
alias psa='ps aux'
alias reload='source ~/.zshrc'
alias be="bundle exec"
alias bo="bundle open"

if [ -e ~/.zshrc_specific ]; then
  source ~/.zshrc_specific
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

