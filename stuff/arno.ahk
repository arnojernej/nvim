;-----------------------------------------
; Mac keyboard to Windows Key Mappings
;=========================================

; --------------------------------------------------------------
; NOTES
; --------------------------------------------------------------
; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN
;
; Debug action snippet: MsgBox You pressed Control-A while Notepad is active.

; KeyHistory

#InstallKeybdHook
#SingleInstance force
SetTitleMatchMode 2
SendMode Input

SetCapsLockState, AlwaysOff
SetNumLockState, AlwaysOn
SetScrollLockState, AlwaysOff

; --------------------------------------------------------------
; Mac-like screenshots in Windows (requires Windows 10 Snip & Sketch)
; --------------------------------------------------------------

; Capture entire screen with CMD/WIN + SHIFT + 3
;#+3::send #{PrintScreen}

; Capture portion of the screen with CMD/WIN + SHIFT + 4
#+4::#+s

F19::DllCall("LockWorkStation")

; --------------------------------------------------------------
; media/function keys all mapped to the right option key
; --------------------------------------------------------------

;RAlt & F7::SendInput {Media_Prev}
;RAlt & F8::SendInput {Media_Play_Pause}
;RAlt & F9::SendInput {Media_Next}
;F10::SendInput {Volume_Mute}
;F11::SendInput {Volume_Down}
;F12::SendInput {Volume_Up}

; swap left command/windows key with left alt
;LWin::LAlt
;LAlt::LWin ; add a semicolon in front of this line if you want to disable the windows key

; Remap Windows + Left OR Right to enable previous or next web page
; Use only if swapping left command/windows key with left alt
;Lwin & Left::Send, !{Left}
;Lwin & Right::Send, !{Right}

; Eject Key
;F20::SendInput {Insert} ; F20 doesn't show up on AHK anymore, see #3

; F13-15, standard windows mapping
; F13::SendInput {PrintScreen}
; F14::SendInput {ScrollLock}
; F15::SendInput {Pause}

; --------------------------------------------------------------
; OS X system shortcuts
; --------------------------------------------------------------

; Make Ctrl + S work with cmd (windows) key
#s::Send, ^s

; Selecting
#a::Send, ^a

; Selecting
#b::Send, !b

; Copying
#c::Send, ^c

; Pasting
#v::Send, ^v

; Cutting
#x::Send, ^x

; Opening
#o::Send ^o

; Finding
#f::Send ^f

; Undo
#z::Send ^z

; Redo
#y::Send ^y

; New tab
#t::Send ^t

; close tab
#w::Send ^w

; reload
#r::Send ^r

; Close windows (cmd + q to Alt + F4)
#q::Send !{F4}

; Remap Windows + Tab to Alt + Tab.
Lwin & Tab::AltTab

; minimize windows
#m::WinMinimize,a

+Space::Send, {F13}

; --------------------------------------------------------------
; OS X keyboard mappings for special chars
; --------------------------------------------------------------

; Map Alt + L to @
!l::SendInput {@}

; Map Alt + N to \
+!7::SendInput {\}

; Map Alt + N to ©
!g::SendInput {©}

; Map Alt + o to ø
!o::SendInput {ø}

; Map Alt + 5 to [
!5::SendInput {[}

; Map Alt + 6 to ]
!6::SendInput {]}

; Map Alt + E to €
!e::SendInput {€}

; Map Alt + - to –
!-::SendInput {–}

; Map Alt + 8 to {
!8::SendInput {{}

; Map Alt + 9 to }
!9::SendInput {}}

; Map Alt + - to ±
!+::SendInput {±}

; Map Alt + R to ®
!r::SendInput {®}

; Map Alt + N to |
!7::SendInput {|}

; Map Alt + W to ∑
!w::SendInput {∑}

; Map Alt + N to ~
!n::SendInput {~}

; Map Alt + 3 to #
;!3::SendInput {#}



; --------------------------------------------------------------
; Custom mappings for special chars
; --------------------------------------------------------------

;#ö::SendInput {[}
;#ä::SendInput {]}

;^ö::SendInput {{}
;^ä::SendInput {}}


#1::Send !1
#2::Send !2
#3::Send !3
#4::Send !4
#5::Send !5

; --------------------------------------------------------------
; Application specific
; --------------------------------------------------------------

; Google Chrome
#IfWinActive, ahk_class Chrome_WidgetWin_1

; Show Web Developer Tools with cmd + alt + i
#!i::Send {F12}

; Show source code with cmd + alt + u
#!u::Send ^u

#IfWinActive

; Capslock::Esc
; Capslock::Ctrl

;*CapsLock::
;    Send {Blind}{Ctrl Down}
;    cDown := A_TickCount
;Return
;
;*CapsLock up::
;    If ((A_TickCount-cDown)<300)  ; Modify press time as needed (milliseconds)
;        Send {Blind}{Ctrl Up}{Esc}
;    Else
;        Send {Blind}{Ctrl Up}
;Return

;CapsLock::Ctrl
;~CapsLock Up::
;{
;    if (A_PriorKey = "CapsLock" and A_TimeSincePriorHotkey < 100)
;    {
;        Send, {Esc}
;    }
;    return
;}

CapsLock::Ctrl
    ;Send, {Ctrl Down}
;   KeyWait, Capslock
;   Send, {Ctrl Up}
;   return
~CapsLock Up::
    if (A_PriorKey = "CapsLock") {
        Send, {Esc}
    }
    Send, {Ctrl Up}
return

#Space::#s

;#a:: Send {ASC 0228}
;#o:: Send {ASC 0246}
;#u:: Send {ASC 0252}
;#s:: Send {ASC 0223}

;#+a:: Send {ASC 0196}
;#+o:: Send {ASC 0214}
;#+u:: Send {ASC 0220}

get_active_mon_dim() {
    dim := {width:0, height:0}                              ; Object to return with width and height
    SysGet, count, MonitorCount                             ; Get number of monitors
    WinGetActiveStats, title, width, height, x, y           ; Get active window's x/y/width/height
    x := x + width / 2                                      ; Calculate the middle x of the window
    y := y + height / 2                                     ; Calculate the middle y of the window
    Loop, % count {                                         ; Loop through each monitor
        SysGet, mon, Monitor, % A_Index                     ;  Get this monitor's bounds
        if (x >= monLeft) && (x <= monRight)                ;  if x falls between the left and right
        && (y <= monBottom) && (y >= monTop)                ;  and y falls between top and bottom
            dim.width := Abs(monRight - monLeft)            ;   Use the bounds to calculate the width
            ,dim.height := Abs(monTop - monBottom)          ;   and the height
    } Until (dim.width > 0)                                 ; Break when a width is found
    return dim                                              ; Return the dimension object
}

; #!Right::
;     mon := get_active_mon_dim()
;     ; MsgBox, % "mon.width: " mon.width "`nmon.height: " mon.height
;     WinGetPos, x, y, width, height, A
;     ; SysGet, monitorWidth, 78
;     ; MsgBox % monitorWidth
;     ; SysGet, monitorHeight, 78
;     newWidth := mon.width * .8
;     ; newHeight := A_ScreenHeight - 50
;     newHeight := mon.height - 46
;     newX := mon.width - newWidth
;     newY := 0
;     WinMove, A, , %newX%, %newY%, %newWidth%, %newHeight%
; return

; #!Left::
;     mon := get_active_mon_dim()
;     WinGetPos, x, y, width, height, A
;     ; SysGet, monitorWidth, 96
;     ; SysGet, monitorHeight, 78
;     newWidth := mon.width * .8
;     newHeight := mon.height - 46
;     newX := 0
;     newY := 0
;     WinMove, A, , %newX%, %newY%, %newWidth%, %newHeight%
; return

;remap #!Right to win+ctrl+alt+right
; #^Right:: send {LWin down}{LCtrl down}{Right}{LWin up}{LCtrl up}
#!Right:: send {LWin down}{LCtrl down}{LAlt down}{Right}{LWin up}{LCtrl up}{LAlt up}
#!Left:: send {LWin down}{LCtrl down}{LAlt down}{Left}{LWin up}{LCtrl up}{LAlt up}


;TMUX
Tab & c::Send, ^b{c}
Tab & n::Send, ^b{n}
Tab & p::Send, ^b{p}
Tab & l::Send, ^b{l}
Tab & w::Send, ^b{w}
Tab & 1::Send, ^b{1}
Tab & 2::Send, ^b{2}
Tab & 3::Send, ^b{3}
Tab & 4::Send, ^b{4}
Tab & 5::Send, ^b{5}
Tab & 6::Send, ^b{6}
Tab & 7::Send, ^b{7}
Tab & 8::Send, ^b{8}
Tab & 9::Send, ^b{9}
Tab & 0::Send, ^b{0}
Tab & -::Send, ^b{-}
Tab & =::Send, ^b{=}
Tab::Tab

; minimize active window
#Down::WinMinimize, A
; maximize active window
#Up::WinMaximize, A
