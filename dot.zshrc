zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit
compinit
bindkey -e

# ls colors
autoload colors; colors
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

nprom () {
  setopt prompt_subst
#  setopt transient_rprompt
  case ${UID} in
    0)
      PROMPT="%{$fg_bold[green]%}%m%{$fg_bold[red]%}#%{$reset_color%} "
      PROMPT2="%{$fg[magenta]%}%_%{$reset_color%}%{$fg_bold[white]%}>>%{$reset_color%} "
      ;;
    *)
      PROMPT="%{${fg[cyan]}%}[%n@%m]%{${reset_color}%} # "
      PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b "
      ;;
  esac
  RPROMPT="%{$fg_bold[white]%}[%~%]]%{$reset_color%}"
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

alias v='vim'
alias g="git"

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

