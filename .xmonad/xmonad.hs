import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig

-- uncomment this and set logHook to myLogHook if you want to make inactive windows translucent
--
--import XMonad.Hooks.FadeInactive
--myLogHook :: X ()
--myLogHook = fadeInactiveLogHook fadeAmount
--        where fadeAmount = 0x99999999 -- 60% rgba

main = xmonad $ defaultConfig {
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts $ layoutHook defaultConfig,
        terminal = "/home/terry/sw/sh.local/myterm"
    }
    `additionalKeysP` [
        -- use this when running in gnome
        --("M-S-q", spawn "gnome-session-save --gui --logout-dialog"),

        --("M-p", spawn "gmrun"),
        --("M-S-p", spawn "dmenu"),

        ("M-S-w", spawn "google-chrome")
    ]
