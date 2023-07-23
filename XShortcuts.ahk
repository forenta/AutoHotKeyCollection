#SingleInstance Ignore

;Collection of AutoHotKey-Scripts for Xinput (Xbox 360/Xbox One-controller)
;Get AutoHotkey v2 or higher from Chocolatey via https://www.autohotkey.com/download/
;Get xinput.ahk from https://www.autohotkey.com/board/topic/35848-xinput-xbox-360-controller-api/

#include xinput.ahk

XInput_Init()
Loop {
  Loop, 4 {
    if State := XInput_GetState(A_Index-1) {
      BACK := State.wButtons & XINPUT_GAMEPAD_BACK
      START := State.wButtons & XINPUT_GAMEPAD_START
      LSTICK := State.wButtons & XINPUT_GAMEPAD_LEFT_THUMB
      RSTICK := State.wButtons & XINPUT_GAMEPAD_RIGHT_THUMB
	  LSHOULDER := State.wButtons & XINPUT_GAMEPAD_LEFT_SHOULDER
	  RSHOULDER := State.wButtons & XINPUT_GAMEPAD_RIGHT_SHOULDER
    }
  }
	
  ;Both shoulder-buttons + left stick click -> Launch Playnite Fullscreen
  if (LSTICK && LSHOULDER && RSHOULDER)
  {
    run "%LOCALAPPDATA%\Playnite\Playnite.FullscreenApp.exe"
	    sleep 1000 ;
  }
  
  ;Back + Start -> Quit active window
  if (START && BACK)
  {
    WinClose A
        sleep 900
  }
  
  ;Back + right stick click -> send Esc
    if (BACK && RSTICK)
     {
    sleep 100
        Send, {Esc}
    }
    
    ;Back + left stick click -> mouse click in middle of the active window
    if (BACK && LSTICK)
     {
        ;Get window size and click on half position of window
        CoordMode, Click, Window
        WinGetPos, winX, winY, winWidth, winHeight, A
        X := winWidth * 0.5
        Y := winHeight * 0.5
        Click %X% %Y% 
        
        ;Hacky way to move mouse to lowerright corner
        MouseMove, 4000, 4000
    }
  
  Sleep, 100
}