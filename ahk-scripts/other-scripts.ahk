#Requires AutoHotkey v2.0
; these are some other scripts that don't fit into a full file on their own yet
; they do get daily use though, so here they are. maybe one day they'll be their own files, but for now this is fine.
!+]:: {
    Send "→"
}

!+[:: {
    Send "☐"
}

!+\:: {
    Send "☑"
}

CapsLock::Enter

^!e::Run "cmd.exe /k echo %time%"
