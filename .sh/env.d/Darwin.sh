
if [ -d "/Applications/Wireshark.app" ]; then
    ensure_path -ae "/Applications/Wireshark.app/Contents/MacOS/"
    prepend_pathlike MANPATH "/Applications/Wireshark.app/Contents/Resources/share/man"
fi
