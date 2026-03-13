
# Add homebrew environment variables and update PATH, etc.
[ -r /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -d "/Applications/Wireshark.app" ]; then
    ensure_path -ae "/Applications/Wireshark.app/Contents/MacOS/"
    # N.B. not using prepend_pathlike because the : is needed to keep the
    # default search path functional when there is no MANPATH.
    MANPATH="/Applications/Wireshark.app/Contents/Resources/share/man:${MANPATH}"
fi
