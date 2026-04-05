#Requires AutoHotkey v2.0
; both hotkeys in this script depend on this function to format the clipboard content properly
SetHtmlClipboard(html) {
    body := "<!--StartFragment-->" . html . "<!--EndFragment-->"
    full := "<!DOCTYPE html><html><body>" . body . "</body></html>"

    headerTemplate := "Version:0.9`r`nStartHTML:{1}`r`nEndHTML:{2}`r`nStartFragment:{3}`r`nEndFragment:{4}`r`n"
    headerLen  := StrLen(Format(headerTemplate, "00000000", "00000000", "00000000", "00000000"))
    startFrag  := headerLen + InStr(full, "<!--StartFragment-->") + StrLen("<!--StartFragment-->") - 1
    endFrag    := headerLen + InStr(full, "<!--EndFragment-->") - 1

    header := Format(headerTemplate,
        Format("{:08d}", headerLen),
        Format("{:08d}", headerLen + StrLen(full)),
        Format("{:08d}", startFrag),
        Format("{:08d}", endFrag))

    clip := header . full

    fmt := DllCall("RegisterClipboardFormat", "Str", "HTML Format", "UInt")

    size := StrPut(clip, "UTF-8")
    hMem := DllCall("GlobalAlloc", "UInt", 0x0042, "Ptr", size, "Ptr")  ; GMEM_MOVEABLE | GMEM_ZEROINIT
    pMem := DllCall("GlobalLock", "Ptr", hMem, "Ptr")
    StrPut(clip, pMem, size, "UTF-8")
    DllCall("GlobalUnlock", "Ptr", hMem)

    DllCall("OpenClipboard", "Ptr", 0)
    DllCall("EmptyClipboard")
    DllCall("SetClipboardData", "UInt", fmt, "Ptr", hMem)
    DllCall("CloseClipboard")
}

; this is for quickly posting log in instruction in connectwise notes
^+L:: {
    g := Gui("+AlwaysOnTop", "Log In Info")
    g.SetFont("s10", "Segoe UI")
    g.Add("Text",, "Login URL:")
    b1 := g.Add("Edit", "w250")
    g.Add("Text",, "Credential URL:")
    b2 := g.Add("Edit", "w250")
    g.Add("Button", "Default", "OK").OnEvent("Click", (*) => SubmitLogin(g, b1, b2))
    g.Show()
}

SubmitLogin(g, b1, b2) {
    v1 := b1.Value, v2 := b2.Value
    g.Destroy()
    for v in [&v1, &v2]
        if (%v% != "" && !RegExMatch(%v%, "^https?://"))
            %v% := "https://" . %v%
    SetHtmlClipboard('Log in <a href="' v1 '">here</a> with <a href="' v2 '">these credentials</a>')
    Sleep(100), Send("^v")
}

; this is for quickly posting any hyperlink with custom display text in connectwise notes
^+K:: {
    g := Gui("+AlwaysOnTop", "Insert Link")
    g.SetFont("s10", "Segoe UI")
    g.Add("Text",, "Display Text:")
    b1 := g.Add("Edit", "w250")
    g.Add("Text",, "URL:")
    b2 := g.Add("Edit", "w250")
    g.Add("Button", "Default", "OK").OnEvent("Click", (*) => SubmitLink(g, b1, b2))
    g.Show()
}

SubmitLink(g, b1, b2) {
    v1 := b1.Value, v2 := b2.Value
    g.Destroy()
    if (v2 != "" && !RegExMatch(v2, "^https?://"))
        v2 := "https://" . v2
    SetHtmlClipboard('<a href="' v2 '">' v1 '</a>')
    Sleep(100), Send("^v")
}



