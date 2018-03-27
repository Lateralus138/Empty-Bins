; Empty all recycle bins on any partition that has a $Recycle.Bin (Windows trash)
; run from command line
; Usage: emptybins /info 
;		Run from command line or by any means you can run cmd commands.
;		/info and time in milliseconds are the only allowed parameters
;		E.g.:
;			emptybins /info 10000	- run 10 seconds; displaying traytip info and exiting
;			emptybins 20000 /info 	- same as above except for 20 seconds
;			emptybins				- run program with no info and no delay

; Init - Vars
TITLE:="EmptyBins"

; Init - Directives
#Persistent
#SingleInstance,Force
SetBatchLines,-1

; System Tray Menu
Menu,Tray,NoStandard
Menu,Tray,Add,E&xit %TITLE%,Destroy

; Run program
EmptyAllRecycle(InStr(A_Args[1],"/info")?1:InStr(A_Args[2],"/info")?1:0)
SetTimer,Destroy,% IsNum(A_Args[1])?"-" A_Args[1]:IsNum(A_Args[2])?"-" A_Args[2]:30000
Return

; Functions
#Include, empty_bins_funcs.ahk ; Of course, replace this with your direct path
			       ; and it must be a full path for compile																		  ; and full path must be given for compile
; Subs
Destroy:
	ExitApp