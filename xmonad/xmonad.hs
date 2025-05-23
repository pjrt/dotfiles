--
-- xmonad example config file for xmonad-0.9
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
-- NOTE: Those updating from earlier xmonad versions, who use
-- EwmhDesktops, safeSpawn, WindowGo, or the simple-status-bar
-- setup functions (dzen, xmobar) probably need to change
-- xmonad.hs, please see the notes below, or the following
-- link for more details:
--
-- http://www.haskell.org/haskellwiki/Xmonad/Notable_changes_since_0.8
--

import XMonad
import Data.Monoid
import Data.Maybe (fromJust, isNothing)
import Data.List (foldl', isInfixOf)

import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Hooks.FloatConfigureReq (fixSteamFlicker)
import XMonad.Actions.SpawnOn (spawnOn, manageSpawn)
import XMonad.Actions.GridSelect (goToSelected)
import XMonad.Util.EZConfig (mkKeymap)
import XMonad.Util.WindowProperties (Property(Resource))
import XMonad.Hooks.DynamicLog (dynamicLog, xmobarPP, statusBar)
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, ToggleStruts(..))
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.ThreeColumns (ThreeCol(..))
import System.Exit (exitWith, ExitCode(ExitSuccess))
import System.Environment (getArgs)
import XMonad.Config.Xfce
import XMonad.Actions.CopyWindow (kill1, copyToAll, copy, killAllOtherCopies)
import XMonad.Actions.CycleWS (toggleWS, toggleOrView)

import qualified XMonad.Prompt        as P
import qualified XMonad.Prompt.Window as P
import qualified XMonad.StackSet      as W
import qualified Data.Map             as M
-- import qualified Network.MQTT.Client  as Q

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- NOTE: from 0.9.1 on numlock mask is set automatically. The numlockMask
-- setting should be removed from configs.
--
-- You can safely remove this even on earlier xmonad versions unless you
-- need to set it to something other than the default mod2Mask, (e.g. OSX).
--
-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
-- myNumlockMask   = mod2Mask -- deprecated in xmonad-0.9.1
------------------------------------------------------------


-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) =
  let genKeys = M.fromList $
        -- mod-[1..9] @@ Switch to workspace N
        -- mod-shift-[1..9] @@ Move client to workspace N
        -- mod-control-shift-[1..9] @@ Copy client to workspace N
        [((m .|. modm, k), f i)
            | (i, k) <- zip (workspaces conf) [xK_1 ..]
            , (f, m) <- [(toggleOrView, 0), (windows . W.shift, shiftMask), (windows . copy, shiftMask .|. controlMask)]]
        ++
        -- mod-{a,s,d}, Switch to physical/Xinerama screens 1, 2, or 3
        -- mod-shift-{a,s,d}, Move client to screen 1, 2, or 3
        --
        [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_a, xK_s, xK_d] [0..]
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
  in M.union genKeys $ keyMappings conf

-- Special keys defined here:
-- https://hackage.haskell.org/package/xmonad-contrib-0.16/docs/XMonad-Util-EZConfig.html#v:mkKeymap
keyMappings conf = mkKeymap conf $
  [
    -- launch a terminal
      "M-S-<Return>" → spawn $ XMonad.terminal conf

    -- launch dmenu
    -- , "M-p" → spawn "exe=`dmenu_path | yeganesh` && eval \"exec $exe\""
    , "M-p" → spawn "xfce4-appfinder"

        -- close focused window
    , "M-S-c" → kill1
    , "M-v" → windows copyToAll
    , "M-S-v" → killAllOtherCopies

    , "M-C-6" → toggleWS

     -- Rotate through the available layout algorithms
    , "M-<Space>" → sendMessage NextLayout

    --  Reset the layouts on the current workspace to default
    , "M-S-<Space>" → setLayout $ XMonad.layoutHook conf

    -- Resize viewed windows to the correct size
    , "M-n" → refresh

    -- Move focus to the next window
    , "M-<Tab>" → windows focusDownSkipFloat

    -- Move focus to the previous window
    , "M-S-<Tab>" → windows focusUpSkipFloat

    -- Move focus to the next window
    , "M-j" → windows focusDownSkipFloat

    -- Move focus to the previous window
    , "M-k" → windows focusUpSkipFloat

    -- Move focus to the master window
    , "M-m" → windows W.focusMaster

    -- Swap the focused window and the master window
    , "M-<Return>" → windows W.swapMaster

    -- Swap the focused window with the next window
    , "M-S-j" → windows W.swapDown

    -- Swap the focused window with the previous window
    , "M-S-k" → windows W.swapUp

    -- Shrink the master area
    , "M-h" → sendMessage Shrink

    -- Expand the master area
    , "M-l" → sendMessage Expand

    -- Push window back into tiling
    , "M-t" → withFocused $ windows . W.sink

    -- Increment the number of windows in the master area
    , "M-," → sendMessage (IncMasterN 1)

    -- Deincrement the number of windows in the master area
    , "M-." → sendMessage (IncMasterN (-1))

    , "M-g" → goToSelected def

    -- Quit xmonad
    -- , "M-S-q" → io (exitWith ExitSuccess)
    , "M-S-q" → spawn "xfce4-session-logout"
    , "M-C-S-q" → spawn "shutdown 0"

    -- Restart xmonad
    , "M-q" → spawn "xmonad --recompile; xmonad --restart"

    -- Lock screen
    -- , "M-C-l" → spawn "xlock -mode blank"

    -- Random bash scripts
    -- Move stuff from the primary selection to the X selection
    , "M-b" → spawn "xsel -op | xsel -ib"

      -- Media Control
    , "<XF86AudioMute>" → spawn "amixer set Master toggle"
    , "<XF86AudioLowerVolume>" → spawn "amixer -q sset Master 5%-"
    , "<XF86AudioRaiseVolume>" → spawn "amixer -q sset Master 5%+"
    , "<XF86AudioPlay>" → spawn "playerctl -p firefox play-pause"
    , "M-<F5>" → spawn "playerctl -p firefox play-pause"
    , "<XF86AudioStop>" → spawn "playerctl -p firefox stop"
    , "<XF86AudioNext>" → spawn "playerctl -p firefox next"
    , "M-<F8>" → spawn "playerctl -p firefox next"
    , "<XF86AudioPrev>" → spawn "playerctl -p firefox previous"
    , "M-<F7>" → spawn "playerctl -p firefox previous"

    -- -- Brightness control
    -- , "<XF86MonBrightnessDown>" → spawn "xbacklight - 10"
    -- , "<XF86MonBrightnessUp>"   → spawn "xbacklight + 10"

    -- Take a screen shot (different modes) based on a sequence.
    , "M-; i s" → spawn "flameshot gui"
    -- , "M-; i s" → spawn "scrot '/tmp/shots_select_%Y-%m-%d-%H-%M-%S.png' -s -d 1 --exec 'xclip -selection clipboard -t image/png < $f'"
    -- , "M-; i w" → spawn "scrot '/tmp/shots_window_%Y-%m-%d-%H-%M-%S.png' -s -d 1 --exec 'xclip -selection clipboard -t image/png < $f'"
    -- , "M-; i a" → spawn "scrot '/tmp/shots_screen_%Y-%m-%d-%H-%M-%S.png' -s -d 1 --exec 'xclip -selection clipboard -t image/png < $f'"

    , "M-; e e" → spawn "echo pedro.rodriguez@disneystreaming.com | xsel -ib"

    -- Search for window and move to it
    , "M-/" → P.windowPrompt def P.Goto P.allWindows

    , "M-S-b" → sendMessage ToggleStruts
    , "M-; x p" → spawn "captureXProp"
    , "M-i" → spawn "/opt/enpass/Enpass showassistant"
  ]

focusUpSkipFloat s = skipFloating s W.focusUp
focusDownSkipFloat s = skipFloating s W.focusDown

skipFloating :: (Eq a, Ord a) => W.StackSet i l a s sd -> (W.StackSet i l a s sd -> W.StackSet i l a s sd) -> W.StackSet i l a s sd
skipFloating stacks f
    | isNothing curr = stacks -- short circuit if there is no currently focused window
    | otherwise = skipFloatingR stacks curr f
  where curr = W.peek stacks

skipFloatingR :: (Eq a, Ord a) => W.StackSet i l a s sd -> (Maybe a) -> (W.StackSet i l a s sd -> W.StackSet i l a s sd) -> W.StackSet i l a s sd
skipFloatingR stacks startWindow f
    | isNothing nextWindow = stacks -- next window is nothing return current stack set
    | nextWindow == startWindow = newStacks -- if next window is the starting window then return the new stack set
    | M.notMember (fromJust nextWindow) (W.floating stacks) = newStacks -- if next window is not a floating window return the new stack set
    | otherwise = skipFloatingR newStacks startWindow f -- the next window is a floating window so keep recursing (looking)
  where newStacks = f stacks
        nextWindow = W.peek newStacks

-- | Alias for (,) for easier/prettier key mapping
infixr 0 →
(→) :: a -> b -> (a, b)
(→) = (,)

mouseLeft = button1
mouseRight = button3
mouseWheelButton = button2
mouseWheelUp = button4
mouseWheelDown = button5

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, mouseLeft), (\w -> focus w >> mouseMoveWindow w
                                         >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, mouseRight), (\w -> focus w >> mouseResizeWindow w
                                          >> windows W.shiftMaster))

    -- mod-button3, Set the window to master
    , ((modm, mouseWheelButton), \w -> focus w >> windows W.focusMaster)

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    , ((modm, mouseWheelUp), const $ windows W.focusUp)
    , ((modm, mouseWheelDown), const $ windows W.focusDown)
    ]

------------------------------------------------------------------------
-- Extras
-- | Remove all windows except the focused one.
only :: W.StackSet i l a s sd -> W.StackSet i l a s sd
only = W.modify' $ \c -> case c of
          W.Stack f _ _ -> W.Stack f [] []

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Mirror tiled ||| Full

-- | Multiple layouts
tiled = Tall nmaster delta ratio
  where
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 2/3
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

threeCol = ThreeColMid nmaster delta ratio ||| Full
  where
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
zoom = [
      isChat --> move <+> doFloat
    , isMain --> move <+> doFloat
    , isLicensedZoom --> move <+> doFloat
    , isZoom --> move <+> doFloat
    ]
  where
    isLicensedZoom = title =? "Zoom - Licensed Account"
    isZoom = className =? "zoom"
    isMain = title =? "Zoom Meeting"
    isChat = title =? "Chat"
    move   = doShift "4"
myManageHook = composeAll all
  where
    all = zoom ++ discord ++ misc
    role = stringProperty "WM_WINDOW_ROLE"
    discord =
      [ className =? "discord"          --> doShift "9" ]
    misc =
      [ className =? "MPlayer"          --> doFloat
      , className =? "Gimp"             --> doFloat
      , role      =? "PictureInPicture" --> doFloat
      , resource  =? "desktop_window"   --> doIgnore
      , resource  =? "kdesktop"         --> doIgnore ]

-- | Checks if the query contains `x`
(~?) :: Query String -> String -> Query Bool
q ~? x = fmap (x `isInfixOf`) q

------------------------------------------------------------------------
-- Event handling

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
myEventHook = docksEventHook <+> fullscreenEventHook <+> fixSteamFlicker

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
myLogHook = dynamicLog

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
myStartupHook = do
    setWMName "LG3D"
    spawnOn "2" "firefox"
    spawnOn "3" "slack --password-store=basic"
    spawnOn "8" "telegram-desktop"
    spawnOn "9" "discord --password-store=basic"

myBar = "xmobar"
-- myBar = "i3status | xmobar -o -t '%StdinReader%' -c '[Run StdinReader]'"

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask .|. shiftMask, xK_b)

myPP = xmobarPP
------------------------------------------------------------------------
-- Run xmonad with the settings you specify. No need to modify this.
main = do
  xmonad =<< statusBar myBar myPP toggleStrutsKey defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
defaults = ewmh def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = smartBorders $ avoidStruts myLayout,
        manageHook         = manageSpawn <+> myManageHook <+> manageHook def,
        handleEventHook    = handleEventHook def <+> myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
