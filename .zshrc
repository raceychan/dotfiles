# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#==================alias===================
alias bat="batcat"
alias fd="fdfind"
alias vim="nvim"
unalias j 2> /dev/null
#==================alias===================

#==================Constant===================
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

 #vi mode and bind vim keys in tab complete menue
export KEYTIMEOUT=1
# Path
export PATH=$HOME/anaconda3/bin:$PATH
# True Color
export COLORTERM=24bit

export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview-window=:hidden
--preview '([[ -f {} ]] && (batcat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='~ ' --pointer='▶' --marker='✓'
--bind 'ctrl-a:select-all'
--bind 'ctrl-d:toggle-preview'
--bind 'ctrl-o:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-g:execute(code {+})'
--select-1
--exit-0
"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--height=60% --layout=reverse --border --preview 'echo {}' --preview-window down:3:hidden:wrap --bind 'ctrl-d:toggle-preview' --select-1 --exit-0"
export FZF_ALT_C_OPTS="--preview 'tree -C {}' | head 200'" #show directories only

#==================Constant===================


#==================AutoLoad====================

# Set up the prompt
autoload -Uz promptinit
#enable key binding
zmodload -i zsh/complist
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
# AutoJump
autoload -U compinit && compinit -u
# Set up the prompt
promptinit
prompt adam1
setopt histignorealldups sharehistory

#==================Functions====================

# Change cursor shape for different modes 
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[1 q"
}

zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# hotkey for ranger 
rangercd () {
    tmp="$(mktemp)"
    ranger --choosedir="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}


_fzf_compgen_path() {
     fdfind --hidden --follow --exclude ".git" --exclude ".ipynb_checkpoints" . "$1"
}

_fzf_compgen_dir() {
     fdfind --type d --hidden --follow --exclude ".git" --exclude ".ipynb_checkpoints" . "$1"
}

_fzf_comprun() {
     local command=$1
     shift

     case "$command" in
      cd)            fzf "$@" --preview 'tree -C {} | head -200' ;;
      export|unset)  fzf "$@" --preview "eval 'echo \$'{}" ;;
      ssh)  	     fzf "$@" --preview 'dig {}' ;;
      *)   	     fzf "$@" ;;
    esac
}

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle      -N     fzf-history-widget-accept

#==================Functions====================


#==================KeyBindings====================

# vi mode and bind vim keys in tab complete menue
bindkey -v
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char 
bindkey -s '^o' 'rangercd\n'
bindkey '^e' edit-command-line
bindkey '^ ' autosuggest-accept
bindkey  '^X^R' fzf-history-widget-accept

#==================KeyBindings====================


#==================Source===================

eval $(thefuck --alias)
eval "$(dircolors -b)"

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# SyntaxHighligting
source $HOME/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# AutoSuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Nord Theme
source ~/.zsh/zsh-dircolors-nord/zsh-dircolors-nord.zsh
# Powerlevel10k theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# AutoJump
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#==================Source===================


# >>> conda initialize >>>

__conda_setup="$('/home/raceychan/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/raceychan/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/raceychan/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/raceychan/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# <<< conda initialize <<<

