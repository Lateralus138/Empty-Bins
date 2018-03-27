# EmptyBins
## Current Release
[EmptyBins 32Bit]()
[EmptyBins 64Bit]()
[EmptyBins Project Page]()
## About
	Empty Bins is a command line utility that will scan all fixed partitions and 
hard drives for Recycle Bins ($Recycle.Bin) and empties them if populated. For 
those that aren't aware; when you delete a file (non Shift) it moves to the
recycle bin located at the root of whatever partition the file was located.
## Motivation
	For people like me that have multiple storage partitions and hard drives this
can be a slight task to empty 5 Recycle Bins (more or less) and so I wrote
EmptyBins to automate this task.
##Usage
	You can run EmptyBins in any manner you can run any other command line utility
in Windows: Windows Cmd, any scripting program that can do the same, and start from
'Run'.

E.g.:
1. emptybins 			- Run basic program
1. emptybins /info		- Run program with traytip/s info about program progress  
1. emptybins /info 5000 - Same as above, but only stays up 5 seconds
1. emptybins 5000 /info	- Params are interchangeable
## Example Code - My TrayTip() Function
```
; Below is a rough guide to my opt_array in the TrayTip function below
; You can  pass any of these word or number options in argument 3
; E.g.:
;	TrayTip("Title","Text","BIG_INFO") == TrayTip("Title","Text",33)

; 0			=	0	NULL

; 1			=	1	INFO
; 2			=	2	WARN
; 3			=	3	ERROR

; 16		=	16	NOSOUND

; 1 16		=	17	NOSOUND_INFO
; 2 16		=	18	NOSOUND_WARN
; 3 16		=	19	NOSOUND_ERROR

; 32		=	32	BIG

; 1 32		=	33	BIG_INFO
; 2 32		=	34	BIG_WARN
; 3 32		=	35	BIG_ERROR

; 16 32		=	48	NOSOUND_BIG

; 1 16 32	=	49	NOSOUND_BIG_INFO
; 2 16 32	=	50	NOSOUND_BIG_WARN
; 3 16 32	=	51	NOSOUND_BIG_ERROR

TrayTip(argV*){
	test:=argV[3]
	If test Is Not Number
		{
			opt_array:=	{	"Null":0,"INFO":1,"WARN":2,"ERROR":3
						,	"NOSOUND":16,"NOSOUND_INFO":17,"NOSOUND_WARN":18,"NOSOUND_ERROR":19
						,	"BIG":32,"BIG_INFO":33,"BIG_WARN":34,"BIG_ERROR":35
						,	"NOSOUND_BIG":48,"NOSOUND_BIG_INFO":49,"NOSOUND_BIG_WARN":50,"NOSOUND_BIG_ERROR":51}
			argV[3]:=opt_array[argV[3]]
		}
	TrayTip,% argV[1],% argV[2],,% argV[3]
	If (!argV[2] And (SubStr(A_OSVersion,1,3)="10.")){
		Menu,Tray,NoIcon
		Sleep(200)
		Menu,Tray,Icon
	}
	Return (argV[2])?1:0
}
Sleep(time:=10){
	DllCall("Sleep","UInt",time)
	Return time
}
## Installation

Portable program (Plans for installer and portable option).


## Test
I have tested on Windows 10 64 Bit

## Contributors

Ian Pride @ faithnomoread@yahoo.com - [Lateralus138] @ New Pride Services 

## License

	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

	License provided in gpl.txt