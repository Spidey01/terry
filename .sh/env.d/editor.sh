
#
# set my default editor, if not found then go in on order of preference.
#
EDITOR="`find_in_normpath vim nvi vi mg ed | head -n 1`"
VISUAL="$EDITOR"
export EDITOR VISUAL
