zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit
compinit
bindkey -e

# ls colors
autoload colors; colors
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

function rprompt-git-current-branch {
  local name st color gitdir action
  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
  fi
  name=`git branch 2> /dev/null | grep '^\*' | cut -b 3-`
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=%F{yellow}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=%B%F{red}
  else
    color=%B%F{red}
  fi
  echo "$color$name$action%f%b"
}

nprom () {
  setopt prompt_subst
#  setopt transient_rprompt
  case ${UID} in
    0)
      PROMPT="%{$fg_bold[green]%}%m%{$fg_bold[red]%}#%{$reset_color%} "
      PROMPT2="%{$fg[magenta]%}%_%{$reset_color%}%{$fg_bold[white]%}>>%{$reset_color%} "
      ;;
    *)
      # 左側
      PROMPT="%{${fg[cyan]}%}[%n@%m]%{${reset_color}%}$ "
      # 左側(2行目以降)
      PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b"
      ;;
  esac
  # 右側
  RPROMPT="%{$fg_bold[white]%}[%~%]]%{$reset_color%} [`rprompt-git-current-branch`]"
  # コマンドミス時
  SPROMPT="%{$fg_bold[red]%}correct%{$reset_color%}: %R -> %r ? "
}
nprom

setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt list_packed
setopt auto_menu

# history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history
setopt extended_history
HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=100000
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

export EDITOR='vim'
export LANG='ja_JP.UTF-8'

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

