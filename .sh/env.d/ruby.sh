
# Pick up programs/modules from Ruby gems
#
if in_path -e ruby; then
    RUBYLIB="$HOME/.gem/ruby/`get_ruby_major_version`/lib:$RUBYLIB"; export RUBYLIB
    prepend_path "$HOME/.gem/ruby/`get_ruby_major_version`/bin"
fi
