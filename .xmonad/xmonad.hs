import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig

-- uncomment this and set logHook to myLogHook if you want to make inactive windows translucent
--
--import XMonad.Hooks.FadeInactive
--myLogHook :: X ()
--myLogHook = fadeInactiveLogHook fadeAmount
--        where fadeAmount = 0x99999999 -- 60% rgba

main = xmonad $ ewmh defaultConfig {
        modMask = mod4Mask,
        --handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook,
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts $ layoutHook defaultConfig,
        terminal = "xterm"
    }
    `additionalKeysP` [
        -- use this when running in gnome
        --("M-S-q", spawn "gnome-session-save --gui --logout-dialog"),

        ("M-S-w", spawn "google-chrome"),
        ("M-S-o", spawn "opera"),

	-- triggle screen saver. "Lock" when set as I normally have it.
	("M-S-l", spawn "xscreensaver-command -activate")
    ]
