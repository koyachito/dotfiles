#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR=nvim
export VISUAL=nvim

eval "$(zoxide init bash)"

# Created by `pipx` on 2026-07-11 01:22:37
export PATH="$PATH:/home/koyachito/.local/bin"
