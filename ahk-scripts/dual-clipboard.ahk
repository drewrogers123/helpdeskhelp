#Requires AutoHotkey v2.0

global SecondClipboard := ""

^!c:: { ; ctrl + alt + C
    global SecondClipboard
    backup := ClipboardAll()
    A_Clipboard := ""
    Send "^c"
    if ClipWait(1) {  
        SecondClipboard := ClipboardAll()
    }
    A_Clipboard := backup              
}

^!v:: { ; ctrl + alt + v
    global SecondClipboard
    if (SecondClipboard = "")
        return

    backup := ClipboardAll()
    A_Clipboard := SecondClipboard     
    Send "^v"
    Sleep 150                          
    A_Clipboard := backup
}
