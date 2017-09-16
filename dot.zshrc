export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig
export EDITOR=atom
eval "$(direnv hook zsh)"

# Git function
function _set_git_branch() {
  local git_branch st color
    git_branch="${$(git symbolic-ref HEAD 2> /dev/null)#refs/heads/}"
    if [ $? != '0' ]; then
      return
    fi
    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
      color=%F{green}
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
      color=%F{yellow}
    elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
      color=%F{blue}
    else
      color=%F{red}
    fi
    echo " - [%{$color%}${git_branch}%f]"
  }

  function _set_left_prompt(){
    PROMPT=$'[%n] - [%F{magenta}%~%f%1(v| %F{green}%1v%f|)]`_set_git_branch`\n$ '
  }

  function _set_prompt() {
    _set_left_prompt
    # 左側(2行目以降)
    PROMPT2="%B%{${fg[blue]}%}%_$%{${reset_color}%}%b "
    # 右側
    #RPROMPT=""
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
  export LS_COLORS='di=41:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
  export EDITOR='vim'
  export LANG='ja_JP.UTF-8'

# option
  setopt auto_pushd
  setopt pushd_ignore_dups
  setopt correct
  setopt list_packed
  setopt auto_menu
  setopt equals
  setopt print_eight_bit
  setopt no_beep
  setopt prompt_subst
  setopt prompt_percent
  setopt transient_rprompt

#
## history settings
#
  HISTFILE=$HOME/.zsh-history
  HISTSIZE=100000
  SAVEHIST=100000
## history
  setopt share_history
  setopt hist_ignore_dups
  setopt hist_ignore_space
  setopt hist_reduce_blanks
  setopt hist_ignore_all_dups
  setopt pushd_ignore_dups
  function history-all { history -E 1 }
## history search
  autoload history-search-end
  zle -N history-beginning-search-backward-end history-search-end
  zle -N history-beginning-search-forward-end history-search-end
  bindkey "^P" history-beginning-search-backward-end
  bindkey "^N" history-beginning-search-forward-end
  bindkey '^R' history-incremental-pattern-search-backward

# prompt setting
  typeset -ga chpwd_functions
  chpwd_functions+=_set_left_prompt
  _set_prompt

# Alias Settings
  alias v='vim'
  alias g="git"
  alias gb="git branch"
  alias gs="git status"
  alias gg="git grep -H --heading --break"

# ls options
  case "${OSTYPE}" in
    darwin*)
      alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
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

# --------------------------------------------------------
# *env
# --------------------------------------------------------
export PATH="/usr/local/sbin:$HOME/.rbenv/bin:$HOME/.ndenv/bin:$HOME:/.pyenv/bin:$HOME:/.goenv/bin:$PATH:"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which ndenv > /dev/null; then eval "$(ndenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which goenv > /dev/null; then eval "$(goenv init -)"; fi

# --------------------------------------------------------
# local settings
# --------------------------------------------------------
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
