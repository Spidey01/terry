import XMonad
import XMonad.Config.Gnome
import XMonad.Util.EZConfig

--main = xmonad $ defaultConfig {
main = xmonad $ gnomeConfig {
        --modMask = mod4Mask,
        terminal = "/home/terry/sw/sh.local/myterm"
    }
    `additionalKeysP` [
        ("M-S-q", spawn "gnome-session-save --gui --logout-dialog"),
        --("M-p", spawn "gmrun"),
        ("M-S-w", spawn "google-chrome")
    ]
