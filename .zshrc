source ~/.bash_aliases

# --------------------------------------------------------------------------------------------------
# -- Environment
# --------------------------------------------------------------------------------------------------
export KEYTIMEOUT=1                                         # Reduce latency when changing mode
export TERM="xterm-256color"                                # Needed for proper color support

# --------------------------------------------------------------------------------------------------
# -- Settings
# - http://zsh.sourceforge.net/Guide/zshguide02.html
# --------------------------------------------------------------------------------------------------
setopt NO_NOMATCH
setopt LOCAL_OPTIONS
setopt PROMPT_SUBST
setopt NO_BEEP
setopt AUTOCD

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zhist

setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# --------------------------------------------------------------------------------------------------
# -- vi bindings
# - https://dougblack.io/words/zsh-vi-mode.html
# - http://stratus3d.com/blog/2017/10/26/better-vi-mode-in-zshell
# --------------------------------------------------------------------------------------------------

bindkey -v

# History seraching
bindkey -M vicmd '^R' history-incremental-pattern-search-backward
bindkey -M vicmd '^F' history-incremental-pattern-search-forward
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-search
bindkey "^[OB" down-line-or-search
bindkey -M vicmd "k" up-line-or-search
bindkey -M vicmd "j" down-line-or-search

# Backspace to delete a character
bindkey "^?" backward-delete-char

# --------------------------------------------------------------------------------------------------
# -- completions
# --------------------------------------------------------------------------------------------------

autoload -U compinit && compinit
# Install via `brew install zsh-completions`
[[ -d /usr/local/share/zsh-completions ]] && fpath=(/usr/local/share/zsh-completions $fpath)

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# --------------------------------------------------------------------------------------------------
# -- Prompt
# --------------------------------------------------------------------------------------------------

autoload -U colors
colors

# Show [NORMAL] indicator when in vi mode
function vi_mode_prompt() {
  VIM_PROMPT="%{$fg_bold[blue]%} [% NORMAL]% %{$reset_color%} "
  echo "${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}"
}

function rprompt() {
  echo "$(vi_mode_prompt)%~"
}

function zle-line-init zle-keymap-select {
  RPS1='$(rprompt)'
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export RPS1='$(rprompt)'

# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git hg
#zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:*' stagedstr "%F{green}●%f" # default 'S'
#zstyle ':vcs_info:*' unstagedstr "%F{red}●%f" # default 'U'
#zstyle ':vcs_info:*' use-simple true
#zstyle ':vcs_info:git+set-message:*' hooks git-untracked
#zstyle ':vcs_info:git*:*' formats '[%b%m%c%u] ' # default ' (%s)-[%b]%c%u-'
#zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] ' # default ' (%s)-[%b|%a]%c%u-'
#zstyle ':vcs_info:hg*:*' formats '[%m%b] '
#zstyle ':vcs_info:hg*:*' actionformats '[%b|%a%m] '
#zstyle ':vcs_info:hg*:*' branchformat '%b'
#zstyle ':vcs_info:hg*:*' get-bookmarks true
#zstyle ':vcs_info:hg*:*' get-revision true
#zstyle ':vcs_info:hg*:*' get-mq false
#zstyle ':vcs_info:hg*+gen-hg-bookmark-string:*' hooks hg-bookmarks
#zstyle ':vcs_info:hg*+set-message:*' hooks hg-message

#function +vi-hg-bookmarks() {
  #emulate -L zsh
  #if [[ -n "${hook_com[hg-active-bookmark]}" ]]; then
    #hook_com[hg-bookmark-string]="${(Mj:,:)@}"
    #ret=1
  #fi
#}

#function +vi-hg-message() {
  #emulate -L zsh

  ## Suppress hg branch display if we can display a bookmark instead.
  #if [[ -n "${hook_com[misc]}" ]]; then
    #hook_com[branch]=''
  #fi
  #return 0
#}

#function +vi-git-untracked() {
  #emulate -L zsh
  #if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
    #hook_com[unstaged]+="%F{blue}●%f"
  #fi
#}

# Anonymous function to avoid leaking NBSP variable.
function () {
  if [[ -n "$TMUX" ]]; then
    local LVL=$(($SHLVL - 1))
  else
    local LVL=$SHLVL
  fi
  if [[ $EUID -eq 0 ]]; then
    local SUFFIX=$(printf '#%.0s' {1..$LVL})
  else
    local SUFFIX=$(printf '\$%.0s' {1..$LVL})
  fi
  #if [[ -n "$TMUX" ]]; then
    ## Note use a non-breaking space at the end of the prompt because we can use it as
    ## a find pattern to jump back in tmux.
    #local NBSP=' '
    #export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%1~%F{yellow}%B%(1j.*.)%(?..!)%b%f%F{red}%B${SUFFIX}%b%f${NBSP}"
    #export ZLE_RPROMPT_INDENT=0
  #else
    # Don't bother with ZLE_RPROMPT_INDENT here, because it ends up eating the
    # space after PS1.
    export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%1~%F{yellow}%B%(1j.*.)%(?..!)%b%f%F{red}%B${SUFFIX}%b%f "
  #fi
}

#RPROMPT_BASE="\${vcs_info_msg_0_}%F{blue}%~%f"
#export RPROMPT=$RPROMPT_BASE
#export SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "
