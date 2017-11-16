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
import Data.List (foldl', isInfixOf)
import Data.Default (def)

import XMonad.Actions.SpawnOn (spawnOn)
import XMonad.Actions.GridSelect (goToSelected)
import XMonad.Util.EZConfig (additionalKeysP, mkKeymap)
import XMonad.Util.WindowProperties (Property(Resource))
import XMonad.Hooks.DynamicLog (dynamicLog, xmobarPP, statusBar)
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook)
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.ThreeColumns (ThreeCol(..))
import System.Exit (exitWith, ExitCode(ExitSuccess))
import System.Environment (getArgs)

import qualified XMonad.Prompt        as P
import qualified XMonad.Prompt.Window as P
import qualified XMonad.StackSet      as W
import qualified Data.Map             as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvtc"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

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
        -- mod-[1..9], Switch to workspace N
        -- mod-shift-[1..9], Move client to workspace N
        --
        [ ((m .|. modm, k), windows $ f i)
            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
        ++
        -- mod-{a,s,d}, Switch to physical/Xinerama screens 1, 2, or 3
        -- mod-shift-{a,s,d}, Move client to screen 1, 2, or 3
        --
        [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_a, xK_s, xK_d] [0..]
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
  in M.union genKeys $ keyMappings conf

keyMappings conf = mkKeymap conf
  [
    -- launch a terminal
      "M-S-<Return>" → spawn $ XMonad.terminal conf

    -- launch dmenu
    , "M-p" → spawn "exe=`dmenu_path | yeganesh` && eval \"exec $exe\""

        -- close focused window
    , "M-S-c" → kill

     -- Rotate through the available layout algorithms
    , "M-<Space>" → sendMessage NextLayout

    --  Reset the layouts on the current workspace to default
    , "M-S-<Space>" → setLayout $ XMonad.layoutHook conf

    -- Resize viewed windows to the correct size
    , "M-n" → refresh

    -- Move focus to the next window
    , "M-<Tab>" → windows W.focusDown

    -- Move focus to the previous window
    , "M-S-<Tab>" → windows W.focusUp

    -- Move focus to the next window
    , "M-j" → windows W.focusDown

    -- Move focus to the previous window
    , "M-k" → windows W.focusUp

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
    , "M-S-q" → io (exitWith ExitSuccess)

    -- Restart xmonad
    , "M-q" → spawn "xmonad --recompile; xmonad --restart"

    -- Lock screen
    , "M-C-l" → spawn "xlock -mode blank"

    -- Random bash scripts
    -- Move stuff from the primary selection to the X selection
    , "M-b" → spawn "xsel -op | xsel -ib"

      -- Volume Control
    , "<XF86AudioMute>" → spawn "pulseaudio-ctl-p mute"
    , "<XF86AudioLowerVolume>" → spawn "pulseaudio-ctl-p down"
    , "<XF86AudioRaiseVolume>" → spawn "pulseaudio-ctl-p up"

    -- Brightness control
    , "<XF86MonBrightnessDown>" → spawn "xbacklight - 10"
    , "<XF86MonBrightnessUp>"   → spawn "xbacklight + 10"

    -- Take a screen shot (different modes) based on a sequence.
    , "M-; i s" → spawn "scrot 'select_%Y-%m-%d-%H-%M-%S.png' -s -d 1 --exec 'mv $f ~/images/shots/'"
    , "M-; i w" → spawn "scrot 'window_%Y-%m-%d-%H-%M-%S.png' -u -d 1 --exec 'mv $f ~/images/shots/'"
    , "M-; i a" → spawn "scrot 'screen_%Y-%m-%d-%H-%M-%S.png' -d 1 --exec 'mv $f ~/images/shots/'"

    -- Remove all other windows from view
    , "M-; o n" → windows only

    -- Search for window and move to it
    , "M-/" → P.windowPromptGoto def

  ]

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
myLayout = tiled ||| Mirror tiled ||| full

-- | Multiple layouts
full = noBorders Full
tiled = Tall nmaster delta ratio
  where
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 2/3
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

threeCol = avoidStruts $ ThreeColMid nmaster delta ratio ||| full
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
hangoutsAppId = "crx_nckgahadagoaajjgafhacjanaoiihapd"
myManageHook = composeAll
    [ className =? "MPlayer"         --> doFloat
    , className =? "Gimp"            --> doFloat
    , title     ~? "Zoom Meeting ID" --> doFloat
    , resource  =? hangoutsAppId     --> doFloat
    , resource  =? "desktop_window"  --> doIgnore
    , resource  =? "kdesktop"        --> doIgnore ]

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
myEventHook = docksEventHook

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
myStartupHook = setWMName "LG3D"

myBar = "xmobar"

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask .|. shiftMask, xK_b)

myPP = xmobarPP
------------------------------------------------------------------------
-- Run xmonad with the settings you specify. No need to modify this.
main = do
  xmonad =<< statusBar myBar myPP toggleStrutsKey defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
defaults = def {
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
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
