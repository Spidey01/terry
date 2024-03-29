#
# Bourne shell aliases for Linux systems
#

alias 	ls='ls --color=auto -hp'
alias 	ll='ls --color=auto -lahp'
alias 	la='ls --color=auto -ahp'

alias   ectags=/usr/bin/ctags-exuberant
alias	exctags=/usr/bin/ctags-exuberant
alias   bc='bc -q'

# Debian and Ubuntu at least call their ack package 'ack-grep' to avoid
# collision with some other program called ack, that I'll likely never even
# need to hear exists.
#
if find_in_normpath ack-grep >/dev/null; then
	alias   ack='ack-grep'
fi
