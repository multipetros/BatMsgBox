# BatMsgBox
## v1.0
Copyright (c) 2020, Petros Kyladitis  

## Description
A cli tool, for display message boxes and receive user answers, usefull for batch scripting

## Requirements
This program is designed for all versions MS Windows, without dependencies, using Windows API.

## Usage
`msgbox [-m message] [-t title] [-b buttons] [-i icon]
               [-d Default button] [-r Return mode]`

The **button `(-b)`** switches are:  

| Short switch | Long switch         | Description                      |  
| :----------: | ------------------- | -------------------------------- |  
| `o`          | `ok`                |  for OK _(default)_              |
| `oc`         | `okcancel`          |  for OK And Cancel               |
| `rc`         | `retryccancel`      |  for Retry And Cancel            |
| `yn`         | `yesno`             |  for Yes And No                  |
| `ync`        | `yesnocancel`       |  for Yes, No, And Cancel         |
| `ari`        | `abotretryignore`   |  for Abort, Retry, And Ignore    |
| `ctc`        | `canceltrycontinue` |  for Cancel, Try Again, Continue |

The **icon `(-i)`** switches are:  

| Short switch | Long switch   | Description                             |  
| :----------: | ------------- | --------------------------------------- |
|`e`           | `exclamation` | for exclamation-point icon              |
|`q`           | `question`    | for question-mark icon                  |
|`w`           | `warning`     | for stop-sign icon                      |
|`i`           | `info`        | for lowercase letter i in a circle icon |

The **default selected button `(-d)`** switches are:  

| Switch | Description                              |  
| :----: | ---------------------------------------- |
| `1`    | The first button is selected _(default)_ |
| `2`    | The second button is selected            |
| `3`    | The third button is selected             |

The **return mode `(-r)`** switches are:  

| Short switch | Long switch         | description                                          |  
| :----------: | ------------------- | ---------------------------------------------------- |
| `s`          | `str`               | for print string user's answer output.               |
| `n`          | `num`               | for print numeric (button id) user's answer output.  |
| `e`          | `err`               | for Return the button id As exit code _(default)_.   |

_Exit code is accessible  from the **%errorlevel%** variable. Usefull for batch scripting, etc.:_  
` > msgbox -m "My Message" -t "My Title" -b o`  
` > set myvar=%errorlevel% `  
` > echo %myvar% `

Exit or Output Codes & Strings:  

| Code | String     | Description                        |
| :--: | ---------- | ---------------------------------- |
| `1`  | `OK`       | The OK button was selected.        |
| `2`  | `CANCEL`   | The Cancel button was selected.    |
| `3`  | `ABORT`    | The Abort button was selected.     |
| `4`  | `RETRY`    | The Retry button was selected.     |
| `5`  | `IGNORE`   | The Ignore button was selected.    |
| `6`  | `YES`      | The Yes button was selected.       |
| `7`  | `NO`       | The No button was selected.        |
| `11` | `CONTINUE` | The Continue button was selected.  |
| `10` | `TRYAGAIN` | The Try Again button was selected. |

## Download
 * [Portable in zip archive](https://github.com/multipetros/BatMsgBox/releases/download/v1.0/batmsgbox-1.0.zip)  

## Change Log
### v1.0
 * Initial release  
 
## License
This is free software distributed under the FreeBSD license, for details see at [license.txt](https://github.com/multipetros/BatMsgBox/blob/master/license.txt)  

## Donations
If you think that this program is helpful for you and you are willing to support the developer, feel free to  make a donation through [PayPal](https://www.paypal.me/PKyladitis).  

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/PKyladitis)

