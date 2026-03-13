#
# The FreeBSD system seems to have been made by people that have an "Hey
# we've been using this command prompt for the past 30 years, let's
# make it comfortable!" approach...  Thus it needs it's own set of
# aliases.
#

alias   ls='ls -FGHh'
alias   ll='ls -lahHo'
alias   la='ls -aFGh'

alias   bc='bc -q'

# OpenBSD calls Exuberant Ctags 'ectags', allow both
alias   ectags=exctags

# system specific alias for displaying temps
alias   temperature='sysctl hw.acpi.thermal | egrep "tz.*\.temperature"'
alias   battery='acpiconf -i 0'
