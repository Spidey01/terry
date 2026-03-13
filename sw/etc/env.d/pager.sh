
# set my pager
PAGER="`find_in_normpath less`"
# default options to less
#
# -F: quit if one screen.
# -i: ignore case in search unless starts with capital.
# -J: display status column at left edge.
# -q: quiet: prefer visual bell to terminal bell.
# -R: allow escapes for ANSI colors / OSC hyperlink references.
# -X: disable termcap init/deinit strings, like if they clear screen.
#
LESS='-FiJqR'  # default options to less
export PAGER LESS
