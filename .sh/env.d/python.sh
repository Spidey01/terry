#
# Python stuff.
#

PYTHONSTARTUP="${HOME}/.pythonrc"
# Assumes get_python_major_version is silent on failure.
append_pathlike PYTHONPATH "${HOME}/sw/lib/python`get_python_major_version`/site-packages"

export PYTHONSTARTUP PYTHONPATH
