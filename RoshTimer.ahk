#Requires AutoHotkey v2

#HotIf WinActive("ahk_exe dota2.exe") ; Only trigger if Dota 2 is the active window

::;;rs::
{
    ; Delete the space that triggered the hotstring
    ; Send("{BS}") 

    ; Create an InputHook object to capture the next 5 characters
    ih := InputHook("V L5") ; V = visible, L5 = limit to 5 characters
    ih.Start() ; Start capturing input
    ih.Wait() ; Wait until input is captured

    ; Get the typed input
    typedTime := ih.Input

    ; Check if input matches MM:SS (under 100 minutes) or MMMSS (over 100 minutes)
    if RegExMatch(typedTime, "^\d{2}:\d{2}$") ; MM:SS format
    {
        ; Extract minutes and seconds
        minutes := SubStr(typedTime, 1, 2)
        seconds := SubStr(typedTime, 4, 2)
    }
    else if RegExMatch(typedTime, "^\d{3}\d{2}$") ; MMMSS format (over 100 minutes)
    {
        ; Extract minutes and seconds for over 100 minutes (no colon)
        minutes := SubStr(typedTime, 1, 3)
        seconds := SubStr(typedTime, 4, 2)
    }
    else
    {
        return ; Exit if format is invalid
    }

    ; Convert the extracted parts to integers
    minutes := minutes + 0
    seconds := seconds + 0

    ; Add 5, 8, and 11 minutes to the current time
    minutesA := minutes + 5
    minutesB := minutes + 8
    minutesC := minutes + 11


    aegisExpire := Format("{:02}:{:02}", minutesA, seconds)
    earlySpawn := Format("{:02}:{:02}", minutesB, seconds)
    lateSpawn := Format("{:02}:{:02}", minutesC, seconds)
    

    ; Send the result back to the input field
    Send(" Aegis: " aegisExpire " Early: " earlySpawn " Late: " lateSpawn)
    return
}

#HotIf ; Disable the HotIf condition after the hotstring


