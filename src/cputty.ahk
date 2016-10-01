; Copyright (c) 2015 Daniel Prokscha
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in
; all copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
; THE SOFTWARE.

#Warn
#NoEnv
#Persistent
#SingleInstance force
#WinActivateForce

GroupAdd, WindowGroup, ahk_class FuTTY
GroupAdd, WindowGroup, ahk_class KiTTY
GroupAdd, WindowGroup, ahk_class mintty
GroupAdd, WindowGroup, ahk_class PieTTY
GroupAdd, WindowGroup, ahk_class PuTTY
GroupAdd, WindowGroup, ahk_class TuTTY
GroupAdd, WindowGroup, ahk_class TTYPLUSMAIN
GroupAdd, WindowGroup, ahk_class PUTTYCS_WND_CLASS

AltDown := 0
Cluster := [] ; key=HWND, value=Cluster #

class Keys {
  ; Identifier       := [SYSKEY, Extended, SC  , VK  ]
  static SC001       := [0     , 0       , 0x00, 0x00],
  static SC002       := [0     , 0       , 0x00, 0x00],
  static SC003       := [0     , 0       , 0x00, 0x00],
  static SC004       := [0     , 0       , 0x00, 0x00],
  static SC005       := [0     , 0       , 0x00, 0x00],
  static SC006       := [0     , 0       , 0x00, 0x00],
  static SC007       := [0     , 0       , 0x00, 0x00],
  static SC008       := [0     , 0       , 0x00, 0x00],
  static SC009       := [0     , 0       , 0x00, 0x00],
  static SC00A       := [0     , 0       , 0x00, 0x00],
  static SC00B       := [0     , 0       , 0x00, 0x00],
  static SC00C       := [0     , 0       , 0x00, 0x00],
  static SC00D       := [0     , 0       , 0x00, 0x00],
  static SC00E       := [0     , 0       , 0x00, 0x00],
  static SC00F       := [0     , 0       , 0x00, 0x00],
  static SC010       := [0     , 0       , 0x00, 0x00],
  static SC011       := [0     , 0       , 0x00, 0x00],
  static SC012       := [0     , 0       , 0x00, 0x00],
  static SC013       := [0     , 0       , 0x00, 0x00],
  static SC014       := [0     , 0       , 0x00, 0x00],
  static SC015       := [0     , 0       , 0x00, 0x00],
  static SC016       := [0     , 0       , 0x00, 0x00],
  static SC017       := [0     , 0       , 0x00, 0x00],
  static SC018       := [0     , 0       , 0x00, 0x00],
  static SC019       := [0     , 0       , 0x00, 0x00],
  static SC01A       := [0     , 0       , 0x00, 0x00],
  static SC01B       := [0     , 0       , 0x00, 0x00],
  static SC01C       := [0     , 0       , 0x00, 0x00],
  static SC01D       := [0     , 0       , 0x00, 0x11],
  static SC01E       := [0     , 0       , 0x00, 0x00],
  static SC01F       := [0     , 0       , 0x00, 0x00],
  static SC020       := [0     , 0       , 0x00, 0x00],
  static SC021       := [0     , 0       , 0x00, 0x00],
  static SC022       := [0     , 0       , 0x00, 0x00],
  static SC023       := [0     , 0       , 0x00, 0x00],
  static SC024       := [0     , 0       , 0x00, 0x00],
  static SC025       := [0     , 0       , 0x00, 0x00],
  static SC026       := [0     , 0       , 0x00, 0x00],
  static SC027       := [0     , 0       , 0x00, 0x00],
  static SC028       := [0     , 0       , 0x00, 0x00],
  static SC029       := [0     , 0       , 0x00, 0x00],
  static SC02A       := [0     , 0       , 0x00, 0x10],
  static SC02B       := [0     , 0       , 0x00, 0x00],
  static SC02C       := [0     , 0       , 0x00, 0x00],
  static SC02D       := [0     , 0       , 0x00, 0x00],
  static SC02E       := [0     , 0       , 0x00, 0x00],
  static SC02F       := [0     , 0       , 0x00, 0x00],
  static SC030       := [0     , 0       , 0x00, 0x00],
  static SC031       := [0     , 0       , 0x00, 0x00],
  static SC032       := [0     , 0       , 0x00, 0x00],
  static SC033       := [0     , 0       , 0x00, 0x00],
  static SC034       := [0     , 0       , 0x00, 0x00],
  static SC035       := [0     , 0       , 0x00, 0x00],
  static SC038       := [1     , 0       , 0x00, 0x12],
  static SC039       := [0     , 0       , 0x00, 0x00],
  static SC03A       := [0     , 0       , 0x00, 0x00],
  static SC03B       := [0     , 0       , 0x00, 0x00],
  static SC03C       := [0     , 0       , 0x00, 0x00],
  static SC03D       := [0     , 0       , 0x00, 0x00],
  static SC03E       := [0     , 0       , 0x00, 0x00],
  static SC03F       := [0     , 0       , 0x00, 0x00],
  static SC040       := [0     , 0       , 0x00, 0x00],
  static SC041       := [0     , 0       , 0x00, 0x00],
  static SC042       := [0     , 0       , 0x00, 0x00],
  static SC043       := [0     , 0       , 0x00, 0x00],
  static SC044       := [1     , 0       , 0x00, 0x00],
  static SC046       := [0     , 0       , 0x00, 0x00],
  static SC056       := [0     , 0       , 0x00, 0x00],
  static SC057       := [0     , 0       , 0x00, 0x00],
  static SC058       := [0     , 0       , 0x00, 0x00],
  static SC070       := [0     , 0       , 0x00, 0x00],
  static SC073       := [0     , 0       , 0x00, 0x00],
  static SC077       := [0     , 0       , 0x00, 0x00],
  static SC079       := [0     , 0       , 0x00, 0x00],
  static SC07B       := [0     , 0       , 0x00, 0x00],
  static SC07E       := [0     , 0       , 0x00, 0x00],
  static SC11D       := [0     , 1       , 0x00, 0x11],
  static SC136       := [0     , 0       , 0x00, 0x10],
  static SC138       := [0     , 1       , 0x00, 0x12],
  static SC145       := [0     , 1       , 0x00, 0x00],
  static SC15B       := [0     , 1       , 0x00, 0x00],
  static SC15C       := [0     , 1       , 0x00, 0x00],
  static SC15D       := [0     , 1       , 0x00, 0x00],
  static SC15E       := [0     , 1       , 0x00, 0x00],
  static SC15F       := [0     , 1       , 0x00, 0x00],
  static SC163       := [0     , 1       , 0x00, 0x00],
  static Break       := [0     , 0       , 0x45, 0x00],
  static CtrlBreak   := [0     , 1       , 0x00, 0x00],
  static Delete      := [0     , 1       , 0x00, 0x00],
  static Down        := [0     , 1       , 0x00, 0x00],
  static End         := [0     , 1       , 0x00, 0x00],
  static Home        := [0     , 1       , 0x00, 0x00],
  static Insert      := [0     , 1       , 0x00, 0x00],
  static Left        := [0     , 1       , 0x00, 0x00],
  static Numpad0     := [0     , 0       , 0x00, 0x00],
  static Numpad1     := [0     , 0       , 0x00, 0x00],
  static Numpad2     := [0     , 0       , 0x00, 0x00],
  static Numpad3     := [0     , 0       , 0x00, 0x00],
  static Numpad4     := [0     , 0       , 0x00, 0x00],
  static Numpad5     := [0     , 0       , 0x00, 0x00],
  static Numpad6     := [0     , 0       , 0x00, 0x00],
  static Numpad7     := [0     , 0       , 0x00, 0x00],
  static Numpad8     := [0     , 0       , 0x00, 0x00],
  static Numpad9     := [0     , 0       , 0x00, 0x00],
  static NumpadAdd   := [0     , 0       , 0x00, 0x00],
  static NumpadClear := [0     , 0       , 0x00, 0x00],
  static NumpadDel   := [0     , 0       , 0x00, 0x00],
  static NumpadDiv   := [0     , 1       , 0x00, 0x00],
  static NumpadDot   := [0     , 0       , 0x00, 0x00],
  static NumpadDown  := [0     , 0       , 0x00, 0x00],
  static NumpadEnd   := [0     , 0       , 0x00, 0x00],
  static NumpadEnter := [0     , 1       , 0x00, 0x00],
  static NumpadHome  := [0     , 0       , 0x00, 0x00],
  static NumpadIns   := [0     , 0       , 0x00, 0x00],
  static NumpadLeft  := [0     , 0       , 0x00, 0x00],
  static NumpadMult  := [0     , 0       , 0x00, 0x00],
  static NumpadPgDn  := [0     , 0       , 0x00, 0x00],
  static NumpadPgUp  := [0     , 0       , 0x00, 0x00],
  static NumpadRight := [0     , 0       , 0x00, 0x00],
  static NumpadSub   := [0     , 0       , 0x00, 0x00],
  static NumpadUp    := [0     , 0       , 0x00, 0x00],
  static Pause       := [0     , 0       , 0x45, 0x00],
  static PgDn        := [0     , 1       , 0x00, 0x00],
  static PgUp        := [0     , 1       , 0x00, 0x00],
  static PrintScreen := [0     , 1       , 0x00, 0x00],
  static Right       := [0     , 1       , 0x00, 0x00],
  static Up          := [0     , 1       , 0x00, 0x00]
}

for k in Keys {
  if (k != "__Class") {
    Hotkey, IfWinActive, ahk_group WindowGroup
    Hotkey, % "~*" k, ClusterKeyDown
    Hotkey, % "~*" k " up", ClusterKeyUp
    if (Keys[k][3] == 0) {
      Keys[k][3] := GetKeySC(k)
    }
    if (Keys[k][4] == 0) {
      Keys[k][4] := GetKeyVK(k)
    }
  }
}

ClusterKeyDown() {
  global AltDown
  global Cluster
  ; Omit unclustered windows
  WinGet, WinActive, ID, A
  if (Cluster[WinActive] == "") {
    Return
  }
  ; Omit Win
  if GetKeyState("LWin"){
    Return
  }
  ; Prepare post
  Identifier := RegExReplace(A_ThisHotkey, "[~*]")
  Message    := 0x100 ; WM_KEYDOWN
  ScanCode   := Keys[Identifier][3]
  VirtualKey := Keys[Identifier][4]
  LParam     := 1 | ScanCode << 16
  ; ALT down
  if (VirtualKey == 0x12) {
    AltDown := 1
  }
  ; SYSKEY pressed (ALT pressed or F10)
  if (Keys[Identifier][1] or AltDown) {
    Message := 0x104 ; WM_SYSKEYDOWN
  }
  ; ALT pressed
  if (AltDown) {
    LParam := LParam | 1 << 29
  }
  ; Extended flag
  if (Keys[Identifier][2]) {
    LParam := LParam | 1 << 24
  }
  ; Post to clustered windows
  for WinClustered, Group in Cluster {
    if (WinClustered != WinActive && Group == Cluster[WinActive]) {
      PostMessage, Message, VirtualKey, LParam, , ahk_id %WinClustered%
    }
  }
}

ClusterKeyUp() {
  global AltDown
  global Cluster
  ; Omit unclustered windows
  WinGet, WinActive, ID, A
  if (Cluster[WinActive] == "") {
    Return
  }
  ; Omit Win
  if GetKeyState("LWin"){
    Return
  }
  ; Prepare post
  Identifier := RegExReplace(A_ThisHotkey, "[~* up]")
  Message    := 0x101 ; WM_KEYUP
  ScanCode   := Keys[Identifier][3]
  VirtualKey := Keys[Identifier][4]
  LParam     := 1 | ScanCode << 16
  LParam     := LParam | 1 << 30
  LParam     := LParam | 1 << 31
  ; SYSKEY pressed (ALT, ALT pressed or F10)
  if (Keys[Identifier][1] or AltDown) {
    Message := 0x105 ; WM_SYSKEYUP
  }
  ; ALT up
  if (VirtualKey == 0x12) {
    AltDown := 0
  }
  ; ALT pressed
  if (AltDown) {
    LParam := LParam | 1 << 29
  }
  ; Extended flag
  if (Keys[Identifier][2]) {
    LParam := LParam | 1 << 24
  }
  ; Post to clustered windows
  for WinClustered, Group in Cluster {
    if (WinClustered != WinActive && Group == Cluster[WinActive]) {
      PostMessage, Message, VirtualKey, LParam, , ahk_id %WinClustered%
    }
  }
}

; get window under mouse
ClusterMouse() {
  global Cluster
  MouseGetPos, , , WinActive
  if (Cluster[WinActive] == "") {
    Return
  }
  for WinClustered, Group in Cluster {
    if (WinActive != WinClustered && Cluster[WinActive] == Group) {
      ControlClick, , ahk_id %WinClustered%, , RIGHT
    }
  }
}

; force paste to all windows
ClusterPaste() {
  global Cluster
  WinGet, WinActive, ID, A
  if (Cluster[WinActive]=="") {
    Return
  }
  for win, grp in Cluster {
    if (grp == Cluster[WinActive]) {
      ControlClick, , ahk_id %win%, , RIGHT
    }
  }
}

AddToCluster(Group := 0) {
  global AltDown
  global Cluster
  WinGet, WinActive, ID, A
  Cluster[WinActive] := Group
  AltDown := 0
}

AllToCluster() {
  global Cluster
  WinGet AllWindows, List, ahk_group WindowGroup
  Loop %AllWindows% {
    Cluster[AllWindows%A_Index%] := 0
  }
}

FocusCluster(Group := 0) {
  global Cluster
  for WinClustered in Cluster {
    if (Cluster[WinClustered] == Group) {
      WinActivate ahk_id %WinClustered%
    }
  }
}

RemoveFromCluster() {
  global AltDown
  global Cluster
  WinGet, WinActive, ID, A
  Cluster.Remove(WinActive, "")
  AltDown := 0
}

StopClustering() {
  global AltDown
  global Cluster
  WinGet, WinActive, ID, A
  if (Cluster.MaxIndex() == "") {
    MsgBox, 36, cPuTTY, Do you really want to close cPuTTY?
    IfMsgBox, Yes
      ExitApp
  }
  AltDown := 0
  if (Cluster[WinActive] != "") {
    SplashTextOn, 300, 70, cPuTTY, % "Clearing group " . Cluster[WinActive]

    Tmp := []
    for WinClustered, Group in Cluster {
      if (Group != Cluster[WinActive]) {
        Tmp[WinClustered] := Group
      }
    }
    Cluster := Tmp

    Sleep, 1000
    SplashTextOff
    Return
  }
  Cluster := []
}

; How many monitors to use for tiling
TileCluster(usemons := 1) {
    ; number of putty windows in all Clusters
    global Cluster
    for win in Cluster {
      IfWinExist, ahk_id %win%
        total++
    }
    if (total<1)
      return

    WM_ENTERSIZEMOVE=0x0231
    WM_EXITSIZEMOVE=0x0232
    ; number of screens to tile on
    SysGet, monitors, 80 ;SM_CMONITORS
    if (usemons > monitors)
      usemons := monitors

    iMax:=1
    iMin:=1
    Loop, %usemons% {
        ; windows per this screen
        if (A_Index = usemons)
            num := total
        else {
            num := Ceil(total/(usemons - A_Index + 1))
            total -= num
        }
        rows := Floor(Sqrt(num))
        cols := Ceil(num/rows)

        if (usemons = 1) {
            SysGet, prim, MonitorPrimary
            SysGet, mwa, MonitorWorkArea, %prim%
        }
        else
            SysGet, mwa, MonitorWorkArea, %A_Index%

        ; reduced borders for Win10
        if % substr(a_osversion, 1, 2) = 10
          if ((mwaBottom - mwaTop)>1400) {
            brd=12
          } else {
            brd=4
          }
        else
          brd=0

        puttyWidth := (mwaRight - mwaLeft)/cols + 2*brd
        puttyHeight := (mwaBottom - mwaTop)/rows + brd
        yPos := mwaTop
        xPos := mwaLeft - brd
        yCount:=0
        i:=1
        iMax+=num
        ;MsgBox %A_Index% monitor %xPos%:%yPos% start, %num% windows, %cols%x%rows%, %iMin%-%iMax%
        for win in Cluster {
            if (i>=iMin and i<iMax and WinExist("ahk_id " win)) {
                WinActivate ahk_id %win%
                SendMessage, WM_ENTERSIZEMOVE
                WinMove, ahk_id %win% , , xPos, yPos, puttyWidth, puttyHeight
                SendMessage, WM_EXITSIZEMOVE
                yCount++
                yPos := yPos + puttyHeight - brd
                if (yCount >= rows) {
                    xPos := xPos + puttyWidth - 2*brd
                    yPos := mwaTop
                    yCount := 0
                }
            }
            IfWinExist, ahk_id %win%
              i++
        }
        iMin:=iMax
    }
}

AutoType(){
  static txt := ""
  global Cluster
  if (txt) {
    WinGet, WinActive, ID, A
    if (Cluster[WinActive] == "" or A_IsSuspended) {
      Send, {Raw}%txt%
      Send, {enter}
      Return
    }
    SetKeyDelay, -1, 10
    for win, grp in Cluster {
      if (Cluster[WinActive] == grp) {
        ControlSendRaw, , %txt%, ahk_id %win%
        ControlSend, , {enter}, ahk_id %win%
      }
    }
  }
  else
    InputBox, txt, cPuTTY auto type, , hide, 200, 100
}

SetTimer, TimerJobs, 1000
TimerJobs() {
  global Cluster, WindowGroup
  WinGet wnds, List, ahk_group WindowGroup

  if !wnds {
    if Cluster.Length()
      Cluster:=[]
    Return
  }

  ; Clean up closed windows from Cluster array
  for win in Cluster {
    found := 0
    Loop %wnds% {
      if (win == wnds%A_Index%) {
        found := 1
      }
    }
    if !found
      Cluster.Delete(win)
  }

  ; Check each window
  WinGet, WinActive, ID, A
  GrpActive := Cluster[WinActive]
  Loop %wnds% {
    win := % wnds%A_Index%
    WinGetTitle, Title, ahk_id %win%
    ; No group assigned (new window opened or script just restarted)
    if !Cluster.HasKey(win) {
      if !RegExMatch(Title, "([05-9])(:|>) .*", match, 1) {
        ; No current group found. Assign to group 0
        Cluster[win] := 0
      } else {
        ; Previous group found.  Assign it to previous group
        Cluster[win] := match1
      }
    }
    ; Fix titles
    grp := Cluster[win]
    mark := (grp == GrpActive) ? "> " : ": "
    if RegExMatch(Title, "[05-9](:|>) (.*)", match, 1)
      Title := match2
    else if (A_IsSuspended)
      Continue
    if (A_IsSuspended)
      WinSetTitle, ahk_id %win%, , % Title
    else
      WinSetTitle, ahk_id %win%, , % grp . mark . Title
  }
}

SetIcon() {
  if A_IsCompiled
    Menu, Tray, Icon, %A_ScriptFullPath%
  else
    Menu, Tray, Icon, %A_ScriptDir%\cputty.ico
  Menu, Tray, Tip, PuTTY Enabled
}
SetIcon()

; Hotkeys
!g:: ; ALT+g - Reload script
  Suspend, Permit
  Reload
Return

^!PgUp:: ; CTRL+ALT+PgUp - Unpause
  Suspend, off
  SetIcon()
Return

^!PgDn:: ; CTRL+ALT+PgDn - Pause
  Menu, Tray, Icon, ,,1 ; freeze
  Suspend, on
  Menu, Tray, Icon, %A_WinDir%\system32\shell32.dll, 48
  Menu, Tray, Tip, PuTTY Paused
Return

#w:: ; Win+W autotype password
  Suspend, Permit
  AutoType()
Return

$<^<!SC002::TileCluster(1)
$<^<!SC003::TileCluster(2)
$<^<!SC004::TileCluster(3)
$<^<!SC005::TileCluster(4)
$<^<!SC006::FocusCluster(5)
$<^<!SC007::FocusCluster(6)
$<^<!SC008::FocusCluster(7)
$<^<!SC009::FocusCluster(8)
$<^<!SC00A::FocusCluster(9)
$<^<!SC00B::FocusCluster(0)
$<^<!Home::FocusCluster(0)
$<^<!End::StopClustering()
~RButton::ClusterMouse()

#IfWinActive ahk_group WindowGroup
$<^<!SC002::TileCluster(1)
$<^<!SC003::TileCluster(2)
$<^<!SC004::TileCluster(3)
$<^<!SC005::TileCluster(4)
$<^<!SC006::AddToCluster(5)
$<^<!SC007::AddToCluster(6)
$<^<!SC008::AddToCluster(7)
$<^<!SC009::AddToCluster(8)
$<^<!SC00A::AddToCluster(9)
$<^<!SC00B::AddToCluster(0)
~RButton::ClusterMouse()
$+Insert::ClusterPaste()
#IfWinActive