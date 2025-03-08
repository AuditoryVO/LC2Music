;LC2Music-Flute bounds(0, 0, 0, 0)
;Adrián García Riber
;2021
<Cabbage>
form caption("LC2Music") size(650, 450), colour(50, 50, 50), pluginID("LC2Music")
vslider bounds(10, 22, 30, 113), channel("level"), text("Level"), range(0, 1, 0.5, 1, 0.001) 
vslider bounds(0, 134, 24, 106), channel("A"), text("A"), range(0.1, 1, 0.030, 1, 0.001) ;0,179 reverse violin
vslider bounds(24, 134, 26, 106), channel("R"), text("R"), range(0, 1, 0.030, 1, 0.001) ; 0,066 reverseviolin
hslider bounds(54, 416, 122, 29) channel("Send") range(0, 2, 1.3, 1, 0.001) 


image bounds(54, 12, 570, 400), channel("bkgrnd"), , corners(10)

image bounds(54, 12, 570, 400) identchannel("Image") corners(10) file("Init.png") 

;image bounds(111, 60, 1, 303) identchannel("Timeline") colour(255, 0, 0, 255) outlinethickness(0) 




</Cabbage>
<CsoundSynthesizer>
<CsOptions>
;-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
-odac
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 48000
ksmps =128
nchnls = 2
0dbfs = 1


;maxalloc 1, 2
;maxalloc 2, 2
;maxalloc 3, 1


gks init 0
gkplay init 0
gkfrec init 0
gifrec init 0

;gkTimeline init 111
;gki	init 0



instr 1

;giosc1 OSCinit 9999 ;x
;giosc3 OSCinit 9997 ;length
;giosc5 OSCinit 9995 ;index
giosc2 OSCinit 9998 ;y
giosc4 OSCinit 9996 ;"s" speed-tempo
giosc6 OSCinit 9994 ;"p" play/stop

;kl init 0
;ks init 100
;kTime init 0
;kcount init 0


;kans OSClisten giosc3, "/length", "f", kl
;kans OSClisten giosc5, "/i", "f", gki
kans1 OSClisten giosc6, "/p", "f", gkplay
kans2 OSClisten giosc4, "/s", "f", gks
;kans OSClisten giosc1, "/x", "f", kTime


if gkplay!=0 && gks!=0 then

    kans3 OSClisten giosc2, "/y", "f", gkfrec
    printk2 gkfrec
    ktrig metro (1)				;trigger 0.25 times a second= 1/tempo
    scoreline {{				
                i 3  0  10
                }}, ktrig
    ktrig=0



;    fout "Spectra_rec.wav", 12, (aosc*kFader/30) ;write to soundfile

endif


endin



instr 2 ;Changing images


if gks!=0 then
	
	Scurve sprintfk "file(%s)", "Spectra.png"
	chnset Scurve, "Image"
	giImage imageload "Spectra.png"

elseif gks==0 then
    Scurve sprintfk "file(%s)", "Init.png"
	chnset Scurve, "Image"	
	imagefree giImage
			
endif
endin

instr 3 ; Synth 1

gkFader chnget "level"
giAtt chnget "A"
giRel chnget "R"
kSend chnget "Send"
;-----------------------------------------------------------SYNTH 1
    kAmp=0.16

    iShape=2
    iDuty=0.3
    iAttack=8*0.5*giAtt
    iRelease=(4-iAttack)*2*giRel

    aVCO	vco2	kAmp,	gkfrec, iShape, iDuty
    kEnvFrec expseg 100*2, iAttack, 100*20, iRelease, 100
    aVCF	moogladder aVCO, kEnvFrec, .2
    kEnv     expseg 0.1, iAttack, 1, iRelease, 0.01

    
    
    
;-----------------------------------------------------------OUTS    
    outs aVCF*kEnv*gkFader, aVCF*kEnv*gkFader

gasendL= aVCF*kEnv*kSend	
gasendR= aVCF*kEnv*kSend


endin



instr 6

gaRevLf, gaRevRf		reverbsc	gasendL,gasendR,0.85,10000
gaRevLr, gaRevRr		reverbsc	gasendL,gasendR,0.85,10000
		
		out	gaRevLf*gkFader,gaRevRf*gkFader
		clear		gasendL, gasendR
endin





</CsInstruments>
<CsScore>
f 1 0 1024 10 1
;f 2 0 1024 10 1
;f 3 0 1024 10 1
;f 4 0 1024 10 1
;f 5 0 1024 10 1

i 1 0 3600*24*7
i 2 0 3600*24*7
;i 3 0 3600*24*7

i 6 0 3600*24*7
e

</CsScore>
</CsoundSynthesizer>
