Debug(title:="Debug Pause",msg:=0,type:=64,exit:=0){
	MsgBox,% ((Mod(type,16)=0) Or (type>64))?type:64,%title%,%msg%
	If exit
		ExitApp
}
EmptyAllRecycle(info:=0){
	DriveGet,_list,List,FIXED
	Loop,Parse,_list
		{
			drive:=A_LoopField ":\"
			ttt:="Drive " drive " Recycle Bin Info"
			tttxp:="Recycle Bin for drive " drive " was "
			c:=0
			Loop,Files,%drive%$Recycle.Bin\*,R
				If (A_LoopFileName!="desktop.ini")
					c++
			If c {
				FileRecycleEmpty,%drive%
				TrayTip(ttt,info?tttxp "emptied.":"","BIG_WARN")
			} Else TrayTip(ttt,info?tttxp "not full and did not need to be emptied.":"","INFO")
		}
}
IsNum(n){
	Return n+0
}

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