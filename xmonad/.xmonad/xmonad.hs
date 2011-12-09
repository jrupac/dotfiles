import XMonad
import XMonad.Config.Gnome
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.CycleWS
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Util.Run(spawnPipe)
import System.IO
import qualified XMonad.StackSet as W
import qualified XMonad.Actions.FlexibleResize as Flex
import qualified Data.Map as M

-- {{
-- Default Terminal
-- }}
myTerminal = "urxvt -letsp 0"

-- {{
-- Workspace Options
-- }}
myWorkspaces = 
    ["1:chrome"
    , "2:dev"
    , "3:dev"
    {-, "4:im"-}
    {-, "5:music"-}
    {-, "6:gimp" -}
    {-, "7:scratch"-}
    {-, "8:scratch"-}
    {-, "9:ff"] -}
    , "4:scratch"
    , "5:ff"] 

-- {{
-- Keyboard Options
-- }}
myKeys = 
    [ ((mod1Mask .|. controlMask, xK_l), spawn "slimlock")
    , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
    , ((mod4Mask, xK_u), focusUrgent)
    , ((0, 0x1008ff11), spawn "amixer sset Master,0 10%-") -- Lower Volume
    , ((0, 0x1008ff13), spawn "amixer sset Master,0 10%+") -- Raise Volume
    , ((0, 0x1008ff12), spawn "amixer sset Master,0 toggle")  -- Mute Volume
    , ((mod4Mask, xK_Right), nextWS)
    , ((mod4Mask, xK_Left), prevWS)
    , ((mod4Mask .|. shiftMask, xK_Right), shiftToNext >> nextWS)
    , ((mod4Mask .|. shiftMask, xK_Left), shiftToPrev >> prevWS)
    , ((0, xK_Print), spawn "scrot")
    , ((mod4Mask, xK_s), spawn "rxvt-unicode -e 'python /home/ajay/Documents/sandbox/py-command/src/main.py' -t 'py-control'")
    , ((mod4Mask, xK_a), spawn "synapse")
    ]

-- {{
-- Mouse Options
-- }}
myMouseHook x = 
    [ ((mod4Mask, button2), (\w -> focus w >> Flex.mouseResizeWindow w))
    ]

newMouse x = M.union (mouseBindings defaultConfig x) (M.fromList (myMouseHook x))

-- {{
-- Window Hooks 
-- }}
myManageHook = composeAll
    [ (role =? "gimp-toolbox" <||> role =? "gimp-image-window") --> (ask >>= doF . W.sink)
    , className =? "Gimp"      --> doFloat
    , className =? "Pidgin"    --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "trayer" --> doIgnore
    ] 
    <+> 
    composeOne [ isDialog -?> doCenterFloat
                , title =? "Software Update" -?> doCenterFloat
                , title =? "Eclipse" -?> doCenterFloat
                , title =? "Eclipse SDK" -?> doCenterFloat
                , title =? "py-control" -?> doCenterFloat]
    where 
        role = stringProperty "WM_WINDOW_ROLE"

-- {{
-- Xmobar Output
-- }}
myLogHook xmproc = dynamicLogWithPP xmobarPP
    { ppOutput = hPutStrLn xmproc
    , ppTitle = xmobarColor "lightblue" "" . shorten 70
    , ppHiddenNoWindows = xmobarColor "grey20" "" 
    , ppUrgent = xmobarColor "yellow" "red" . xmobarStrip
    , ppHidden = xmobarColor "grey50" ""
    , ppCurrent = xmobarColor "#ff6600" ""
    , ppLayout = xmobarColor "white" "" . wrap "« " " »"
    }

-- {{
-- Layout Options
-- }}
myLayout = spacing 3 $ tiled ||| Grid ||| Mirror tiled ||| Full ||| simplestFloat
    where
        tiled   = Tall nmaster delta ratio
        nmaster = 1
        ratio   = 1/2
        delta   = 3/100

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook defaultConfig
        { manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig 
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , workspaces = myWorkspaces
        , logHook =  myLogHook xmproc
        , layoutHook = avoidStruts  $  smartBorders $ myLayout
        , startupHook = setWMName "LG3D"
        , terminal = myTerminal
        , mouseBindings = newMouse
        , focusedBorderColor = "gray40"
        , normalBorderColor = "gray15"
        , borderWidth = 2
        } `additionalKeys` myKeys
