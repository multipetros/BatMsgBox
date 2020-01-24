; BatMsgBox v1.0
; A cli tool, for display message boxes and receive user answers, usefull for batch scripting
; Copyright (c) 2020, Petros Kyladitis <petros.kyladitis@gmail.com>
;
; This is free software distributed under the FreeBSD license, for details see at 'license.txt'

Import "kernel32.lib"
  GetConsoleWindow() ; Returns console WHND
EndImport

#PRG_SWT_TITLE  = "-t" ; title
#PRG_SWT_MSG    = "-m" ; message
#PRG_SWT_BTN    = "-b" ; buttons
#PRG_SWT_ICON   = "-i" ; icon
#PRG_SWT_DEFBT  = "-d" ; defaul button
#PRG_SWT_RETURN = "-r" ; return mode

#PRG_RET_MODE_ERR = 0
#PRG_RET_MODE_NUM = 1
#PRG_RET_MODE_STR = 2

#MB_CANCELTRYCONTINUE = 6 ; Win98/2K+ API addition

Global message.s    = #Empty$
Global title.s      = #Empty$
Global button.l     = #MB_OK
Global icon.l       = 0
Global defButton.l  = #MB_DEFBUTTON1
Global returnMode.b = #PRG_RET_MODE_ERR

Global NewMap buttons.l()
buttons("o") = #MB_OK                                ; OK
buttons("oc") = #MB_OKCANCEL                         ; OK and Cancel
buttons("rc") = #MB_RETRYCANCEL                      ; Retry and Cancel
buttons("yn") = #MB_YESNO                            ; Yes and No
buttons("ync") = #MB_YESNOCANCEL                     ; Yes, No, and Cancel
buttons("ari") = #MB_ABORTRETRYIGNORE                ; Abort, Retry, and Ignore
buttons("ctc") = #MB_CANCELTRYCONTINUE               ; Cancel, Try Again, Continue
; long versions
buttons("ok") = #MB_OK                               ; OK
buttons("okcancel") = #MB_OKCANCEL                   ; OK and Cancel
buttons("retryccancel") = #MB_RETRYCANCEL            ; Retry and Cancel
buttons("yesno") = #MB_YESNO                         ; Yes and No
buttons("yesnocancel") = #MB_YESNOCANCEL             ; Yes, No, and Cancel
buttons("abotretryignore") = #MB_ABORTRETRYIGNORE    ; Abort, Retry, and Ignore
buttons("canceltrycontinue") = #MB_CANCELTRYCONTINUE ; Cancel, Try Again, Continue

Global NewMap icons.l()
icons("e") = #MB_ICONEXCLAMATION           ; exclamation-point icon 
icons("q") = #MB_ICONQUESTION              ; question-mark icon 
icons("w") = #MB_ICONWARNING               ; stop-sign icon 
icons("i") = #MB_ICONINFORMATION           ; lowercase letter i in a circle icon
; long versions
icons("exclamation") = #MB_ICONEXCLAMATION ; exclamation-point icon 
icons("question") = #MB_ICONQUESTION       ; question-mark icon 
icons("warning") = #MB_ICONWARNING         ; stop-sign icon 
icons("info") = #MB_ICONINFORMATION        ; lowercase letter i in a circle icon

Global NewMap defButtons.l()
defButtons("1") = #MB_DEFBUTTON1
defButtons("2") = #MB_DEFBUTTON2
defButtons("3") = #MB_DEFBUTTON3

Global NewMap returnSwitches.b()
returnSwitches("s") = #PRG_RET_MODE_STR
returnSwitches("n") = #PRG_RET_MODE_NUM
returnSwitches("e") = #PRG_RET_MODE_ERR
; long versions
returnSwitches("str") = #PRG_RET_MODE_STR
returnSwitches("num") = #PRG_RET_MODE_NUM
returnSwitches("err") = #PRG_RET_MODE_ERR

Global NewMap returnCodes.s()
returnCodes("1")  = "OK"
returnCodes("2")  = "CANCEL"
returnCodes("3")  = "ABORT"
returnCodes("4")  = "RETRY"
returnCodes("5")  = "IGNORE"
returnCodes("6")  = "YES"
returnCodes("7")  = "NO"
returnCodes("10") = "TRYAGAIN" 
returnCodes("11") = "CONTINUE"

Procedure.b LoadParams()
  paramsNum.l = CountProgramParameters()
  param.s = ProgramParameter()
  ; if exceed params boundaries or is odd return error
  If param = #Empty$ Or paramsNum > 12 Or paramsNum < 1 Or paramsNum & 1
    ProcedureReturn 0
  Else
    While param <> #Empty$
      Select param
        Case #PRG_SWT_TITLE
          title = ProgramParameter()
        Case #PRG_SWT_MSG
          message = ProgramParameter()
        Case #PRG_SWT_BTN
          button = buttons(LCase(ProgramParameter()))
        Case #PRG_SWT_ICON
          icon = icons(LCase(ProgramParameter()))
        Case #PRG_SWT_DEFBT
          defButton = defButtons(ProgramParameter())
        Case #PRG_SWT_RETURN
          returnMode = returnSwitches(LCase(ProgramParameter()))
        Default
          ProcedureReturn 0
      EndSelect
      param = ProgramParameter()
    Wend
    ProcedureReturn 1
  EndIf
EndProcedure

Procedure ShowHelp()
  PrintN("BatMsgBox v1.0 - Display message boxes and receive user answers")
  PrintN("Copyright (c) 2020, Petros Kyladitis")
  PrintN(#CRLF$ + "Usage: msgbox [-m message] [-t title] [-b buttons] [-i icon]")
  PrintN("              [-d Default button] [-r Return mode]")
  PrintN(#CRLF$ + "The button (-b) switches are:")
  PrintN(#DQUOTE$ +"o" + #DQUOTE$ + "   or " + #DQUOTE$ + "ok" + #DQUOTE$ + "                for OK (Default)")
  PrintN(#DQUOTE$ +"oc" + #DQUOTE$ + "  or " + #DQUOTE$ + "okcancel" + #DQUOTE$ + "          for OK And Cancel")
  PrintN(#DQUOTE$ +"rc" + #DQUOTE$ + "  or " + #DQUOTE$ + "retryccancel" + #DQUOTE$ + "      for Retry And Cancel")
  PrintN(#DQUOTE$ +"yn" + #DQUOTE$ + "  or " + #DQUOTE$ + "yesno" + #DQUOTE$ + "             for Yes And No")
  PrintN(#DQUOTE$ +"ync" + #DQUOTE$ + " or " + #DQUOTE$ + "yesnocancel" + #DQUOTE$ + "       for Yes, No, And Cancel")
  PrintN(#DQUOTE$ +"ari" + #DQUOTE$ + " or " + #DQUOTE$ + "abotretryignore" + #DQUOTE$ + "   for Abort, Retry, And Ignore")
  PrintN(#DQUOTE$ +"ctc" + #DQUOTE$ + " or " + #DQUOTE$ + "canceltrycontinue" + #DQUOTE$ + " for Cancel, Try Again, Continue")
  PrintN(#CRLF$ + "The icon (-i) switches are:")
  PrintN(#DQUOTE$ +"e" + #DQUOTE$ + " or " + #DQUOTE$ + "exclamation" + #DQUOTE$ + " for exclamation-point icon")
  PrintN(#DQUOTE$ +"q" + #DQUOTE$ + " or " + #DQUOTE$ + "question" + #DQUOTE$ + "    for question-mark icon")
  PrintN(#DQUOTE$ +"w" + #DQUOTE$ + " or " + #DQUOTE$ + "warning" + #DQUOTE$ + "     for stop-sign icon")
  PrintN(#DQUOTE$ +"i" + #DQUOTE$ + " or " + #DQUOTE$ + "info" + #DQUOTE$ + "        for lowercase letter i in a circle icon")
  PrintN(#CRLF$ + "The default (-d) selected button switches are: 1, 2, or 3")
  PrintN(#CRLF$ + "The return (-r) mode switches are:")
  PrintN(#DQUOTE$ +"s" + #DQUOTE$ + " or " + #DQUOTE$ + "str" + #DQUOTE$ + " for print string user's answer output")
  PrintN(#DQUOTE$ +"n" + #DQUOTE$ + " or " + #DQUOTE$ + "num" + #DQUOTE$ + " for print numeric (button id) user's answer output")
  PrintN(#DQUOTE$ +"e" + #DQUOTE$ + " or " + #DQUOTE$ + "err" + #DQUOTE$ + " for Return the button id As exit code (Default), accessible")
  PrintN("from the %errorlevel% variable. Usefull for batch scripting, etc.:")
  PrintN("> msgbox -m " + #DQUOTE$ + "My Message" + #DQUOTE$ + " -t " + #DQUOTE$ + "My Title" + #DQUOTE$ + " -b o" )
  PrintN("> set myvar=%errorlevel%" + #CRLF$ + "> echo %myvar%")
  PrintN(#CRLF$ + "Exit or Output Codes & Strings:")
  PrintN("1  OK       The OK button was selected.")
  PrintN("2  CANCEL   The Cancel button was selected.")
  PrintN("3  ABORT    The Abort button was selected.")
  PrintN("4  RETRY    The Retry button was selected.")
  PrintN("5  IGNORE   The Ignore button was selected.")
  PrintN("6  YES      The Yes button was selected.")
  PrintN("7  NO       The No button was selected.")
  PrintN("11 CONTINUE The Continue button was selected.")
  PrintN("10 TRYAGAIN The Try Again button was selected.")
EndProcedure

exitCode.l = 0
If OpenConsole()
  If LoadParams()
    msgReply.l = MessageBox_(GetConsoleWindow(), message, title, button + icon + defButton)
    Select returnMode
        Case #PRG_RET_MODE_NUM
          Print(Str(msgReply))
        Case #PRG_RET_MODE_STR
          Print(returnCodes(Str(msgReply)))
        Default
          exitCode = msgReply
    EndSelect
  Else
    ShowHelp()
  EndIf
  CloseConsole()
EndIf

ExitProcess_(exitCode)
; IDE Options = PureBasic 5.70 LTS (Windows - x86)
; ExecutableFormat = Console
; CursorPosition = 137
; FirstLine = 126
; Folding = -
; EnableXP
; Executable = msgbox.exe