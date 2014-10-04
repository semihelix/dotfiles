-- Imports.
import XMonad
-- Action
import XMonad.Actions.CycleRecentWS     -- Tab through WS
import XMonad.Actions.Promote           -- Promote similar to DWM
-- Layouts
import XMonad.Layout.NoBorders          -- No borders for single window
import XMonad.Layout.PerWorkspace       -- Configure layout per WS
import XMonad.Layout.Grid               --
-- Status bar
import XMonad.Hooks.DynamicLog          -- Enable logging to statusbar
import XMonad.Hooks.InsertPosition      -- Insert new win below master
import XMonad.Hooks.ManageDocks         -- Dzen space
import XMonad.Util.Run                  -- for spawnPipe and hPutStrLn
-- Enable binding keys
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import System.Exit

main = do

    status <- spawnPipe myDzenStatus
    conky  <- spawnPipe myDzenConky

    xmonad $ defaultConfig
      { terminal            = "urxvt"
      , focusFollowsMouse   = False
      , clickJustFocuses    = True
      , workspaces          = myWorkspaces
      , startupHook         = myStartupHook
      , manageHook          = myManageHook <+> insertPosition Below Newer <+> manageDocks
      , layoutHook          = myLayoutHook
      , logHook             = myLogHook status
      , keys                = myKeys
      , modMask             = mod4Mask
      , normalBorderColor   = "#aaaaaa"
      , focusedBorderColor  = "sienna"
      , borderWidth         = 2
      }

-- Dirs
myBitmapsDir = "/home/antman/dotfiles/dzen2/"
wrapBitmap bitmap = "^i(" ++ myBitmapsDir ++ bitmap ++ ")"

-- Workspaces
myWorkspaces    = [
                     wrapBitmap "term.xbm"
                  ,  wrapBitmap "www.xbm"
                  ,  wrapBitmap "bug_01.xbm"
                  ,  wrapBitmap "dish.xbm"
                  ,  wrapBitmap "media.xbm"
                  ,  wrapBitmap "mail.xbm"
                  ]

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace program workspace = do
                                       spawn program
                                       windows $ W.greedyView workspace

-- Startup
myStartupHook = do
    spawn  "urxvt -name WS1 -e attach-t.sh system"
    spawn  "urxvt -name WS3 -e attach-t.sh editor"
    spawn  "urxvt -name WS4 -e attach-t.sh chat1"
    spawn  "urxvt -name WS4 -e attach-t.sh chat2"
    spawn  "urxvt -name WS5 -e ncmpcpp"
    spawn  "urxvt -name WS5 -e ranger"
    spawn  "claws-mail"
    spawn  "firefox"
    spawn  "viber"

--- Window rules
myManageHook = composeAll
   [
     className =? "Firefox"     --> doShift (wrapBitmap "www.xbm")
   , className =? "ViberPC"     --> doShift (wrapBitmap "dish.xbm")
   , className =? "Claws-mail"  --> doShift (wrapBitmap "mail.xbm")
   , resource  =? "WS1"         --> doShift (wrapBitmap "term.xbm")
   , resource  =? "WS2"         --> doShift (wrapBitmap "www.xbm")
   , resource  =? "WS3"         --> doShift (wrapBitmap "bug_01.xbm")
   , resource  =? "WS4"         --> doShift (wrapBitmap "dish.xbm")
   , resource  =? "WS5"         --> doShift (wrapBitmap "media.xbm")
   , resource  =? "WS6"         --> doShift (wrapBitmap "mail.xbm")
   , resource  =? "MASTER"      --> doF (W.swapMaster)
   ]

-- Layoyt hook
myLayoutHook = onWorkspace (wrapBitmap "dish.xbm") myLayoutChat $
               onWorkspace (wrapBitmap "media.xbm") myLayoutMedia $
               myLayout

myLayout = avoidStruts(smartBorders(tiled ||| Mirror tiled ||| Grid ||| Full))
     where
         tiled = Tall 1 (3/100) (1/2)

myLayoutChat = avoidStruts(smartBorders(Mirror tiled ||| Grid ||| Full))
     where
         tiled = Tall 1 (3/100) (1/2)

myLayoutMedia = smartBorders(Full ||| Mirror tiled)
     where
         tiled = Tall 1 (3/100) (1/2)

-- Loghook
myLogHook h = dynamicLogWithPP $ myDzenPP { ppOutput = hPutStrLn h }

-- Soawn dzeb & conky
myDzenStatus = "dzen2 -w '750' -ta 'l'" ++ myDzenStyle
myDzenConky  = "conky | dzen2 -x '750' -w '850' -ta 'r'" ++ myDzenStyle

-- Bar style 24px high and colors
myDzenStyle  = " -h '24' -y '0' -fg '#777777' -bg '#222222' -fn terminus -e 'onstart=lower'"

-- Very plain formatting, non-empty workspaces are highlighted,
-- urgent workspaces (e.g. active IM window) are highlighted in red
myDzenPP  = dzenPP
    { ppCurrent         = dzenColor "chocolate" "" . wrap " " " "
    , ppHidden          = dzenColor "#dddddd"   "" . wrap " " " "
    , ppHiddenNoWindows = dzenColor "#777777"   "" . wrap " " " "
    , ppUrgent          = dzenColor "#ff0000"   "" . wrap " " " "
    , ppSep             = "   "
    , ppTitle           = dzenColor "#ffffff"   "" . wrap " " " "
    , ppLayout          = dzenColor "chocolate" "" .
                           (\x -> case x of
                              "Tall"             ->      wrapBitmap "layout_tall.xbm"
                              "Mirror Tall"      ->      wrapBitmap "layout_mirror_tall.xbm"
                              "Full"             ->      wrapBitmap "layout_full.xbm"
                              "Grid"             ->      wrapBitmap "grid.xbm"
                              "Cross"            ->      wrapBitmap "test.xbm"
                              _                  ->      x
                           )
    }

-- Key bindings. Add, modify or remove key bindings here.
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. controlMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch a tmux terminal
    , ((modm .|. shiftMask, xK_Return     ), spawn "urxvt -e tmux")

    -- launch a attached tmux terminal
    , ((modm .|. shiftMask, xK_BackSpace     ), spawn "urxvt -e tmux a")

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run -fn -*-terminus-medium-r-*-*-16-*-*-*-*-*-*-* -nb '#222222' -nf grey84 -sb chocolate  -sf '#222222'")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the last used workspace
    , ((modm, xK_Tab), cycleRecentWS [xK_Tab] xK_Tab xK_Tab)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), promote)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    , ((modm,               xK_f     ), withFocused float)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), killAndExit)

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Volume
    , ((0, 0x1008FF11                ), spawn "amixer set Master 2-")
    , ((0, 0x1008FF13                ), spawn "amixer set Master 2+")
    , ((0, 0x1008FF12                ), spawn "amixer set Master toggle")

    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    where
        killAndExit =
            (spawn "killall dzen2") <+>
            (io (exitWith ExitSuccess))

-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
