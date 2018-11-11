;Windows shortcuts
;https://support.microsoft.com/en-us/help/12445/windows-keyboard-shortcuts
;
;Ctrl+W will send Alt+F4, close windows as on Linux, 
^q::Send !{F4}
return
;Ctrl+F12 open SnippingTool, for screen copy
^F12::Run, SnippingTool.exe
return
;F9 open search 
F9::
Send, #s
return


;https://www.autohotkey.com/docs/scripts/EasyWindowDrag_(KDE).htm
; Easy Window Dragging -- KDE style (requires XP/2k/NT) -- by Jonny
; This script makes it much easier to move or resize a window: 1) Hold down
; the ALT key and LEFT-click anywhere inside a window to drag it to a new
; location; 2) Hold down ALT and RIGHT-click-drag anywhere inside a window
; to easily resize it; 3) Press ALT twice, but before releasing it the second
; time, left-click to minimize the window under the mouse cursor, right-click
; to maximize it, or middle-click to close it.

; This script was inspired by and built on many like it
; in the forum. Thanks go out to ck, thinkstorm, Chris,
; and aurelian for a job well done.

If (A_AhkVersion < "1.0.39.00")
{
    MsgBox,20,,This script may not work properly with your version of AutoHotkey. Continue?
    IfMsgBox,No
    ExitApp
}

; This is the setting that runs smoothest on my
; system. Depending on your video card and cpu
; power, you may want to raise or lower this value.
SetWinDelay, 0

CoordMode,Mouse
return

!RButton::
; Get the initial mouse position and window id, and
; abort if the window is maximized.
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
    return
; Get the initial window position and size.
WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
; Define the window region the mouse is currently in.
; The four regions are Up and Left, Up and Right, Down and Left, Down and Right.
If (KDE_X1 < KDE_WinX1 + KDE_WinW / 2)
    KDE_WinLeft := 1
Else
    KDE_WinLeft := -1
If (KDE_Y1 < KDE_WinY1 + KDE_WinH / 2)
    KDE_WinUp := 1
Else
    KDE_WinUp := -1
Loop
{
    GetKeyState,KDE_Button,RButton,P ; Break if button has been released.
    If KDE_Button = U
        break
    MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
    ; Get the current window position and size.
    WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
    KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
    KDE_Y2 -= KDE_Y1
    ; Then, act according to the defined region.
    WinMove,ahk_id %KDE_id%,, KDE_WinX1 + (KDE_WinLeft+1)/2*KDE_X2  ; X of resized window
                            , KDE_WinY1 +   (KDE_WinUp+1)/2*KDE_Y2  ; Y of resized window
                            , KDE_WinW  -     KDE_WinLeft  *KDE_X2  ; W of resized window
                            , KDE_WinH  -       KDE_WinUp  *KDE_Y2  ; H of resized window
    KDE_X1 := (KDE_X2 + KDE_X1) ; Reset the initial position for the next iteration.
    KDE_Y1 := (KDE_Y2 + KDE_Y1)
}
return