
# Python stuff
#
if in_path -e python; then
    PYTHONSTARTUP="${HOME}/.pythonrc"
    [ ! -f "$PYTHONSTARTUP" ] && touch "$PYTHONSTARTUP"
    PYTHONPATH="${HOME}/sw/lib/python`get_python_major_version`/site-packages:$PYTHONPATH"
    export PYTHONSTARTUP PYTHONPATH
fi
