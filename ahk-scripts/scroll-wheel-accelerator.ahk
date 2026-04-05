#Requires AutoHotkey v2.0

; this is a simple scroll wheel accelerator. hold the ` key and scroll to scroll faster. 
; you can adjust the multiplier by changing the loop count.

vkC0 & WheelUp:: {
    Loop 10
        SendInput "{WheelUp}"
}

vkC0 & WheelDown:: {
    Loop 10
        SendInput "{WheelDown}"
}
