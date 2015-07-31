import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W;
import XMonad.Util.EZConfig

-- uncomment this and set logHook to myLogHook if you want to make inactive windows translucent
--
-- import XMonad.Hooks.FadeInactive
-- myLogHook :: X ()
-- myLogHook = fadeInactiveLogHook fadeAmount
--         where fadeAmount = 0x999999999 -- 60% rgba


myManageHooks = composeAll
    [
    -- stuff for full screen as recommended by the wiki. Doesn't seem to be needed.
    isFullscreen --> (doF W.focusDown <+> doFullFloat) 
    -- for keeping space for a panel. See layoutHook with avoidStruts.
    , manageDocks
    , manageHook defaultConfig
    ]

-- smartBorders: don't stuff boards on e.g. full screen window.
-- avoidStruts: for making the panel work.
myLayoutHooks = noBorders $ avoidStruts $ layoutHook defaultConfig

-- Fixes some full screen apps, namely Google Chrome.
myHandleEventHooks = handleEventHook defaultConfig <+> fullscreenEventHook

main = xmonad $ ewmh defaultConfig { modMask = mod4Mask
        , handleEventHook = myHandleEventHooks
        , manageHook = myManageHooks 
        , layoutHook = myLayoutHooks
        -- , logHook = myLogHook

        -- set terminal for mond-shift-enter
        , terminal = "x-terminal-emulator"
    }
    `additionalKeysP` [
        -- use this when running in gnome
        --("M-S-q", spawn "gnome-session-save --gui --logout-dialog"),

        -- This overwrites with 'move client to physical screen  1'
        -- ("M-S-w", spawn "google-chrome"),
        --
        -- Retired..
        -- ("M-S-o", spawn "opera"),

        -- triggle screen saver. "Lock" when set as I normally have it.
        ("M-S-l", spawn "xscreensaver-command -activate")
    ]

-- API notes
--      XMonad.ManageHook :: http://xmonad.org/xmonad-docs/xmonad/XMonad-ManageHook.html
--          <+> Monoid m => m -> m -> m
--              compose two Manage hook from right to left.
--          composeAll :: Monoid m => [m] -> m
--              compose the list of ManageHook's
--          --> :: (Monad m, Monoid a) => m Bool -> m a -> m a
--              p --> x. If p returns True then execute the ManageHook
--      XMonad.Hooks.ManageDocks :: http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Hooks-ManageDocks.html
