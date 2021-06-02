	PRESERVE8
	THUMB   
		
	import Son 
	import LongueurSon 
	import PeriodeSonMicroSec
; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite

SortieSon DCW 0
Index DCD 0 
	
	EXPORT SortieSon 	
	
; ===============================================================================================
	
	EXPORT CallbackSon; 
	EXPORT StartSon 
	
	INCLUDE ./Driver/DriverJeuLaser.inc
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici	

CallbackSon proc 
	push{lr,r4}
	ldr r1, =Index
	ldr r0,=LongueurSon 
	ldr r3, [r1]
	ldr r2, [r0]
	; if index(index <5512) then
	cmp r3,r2
	bhs then 

els 
	;SonBrut = Son[Index]
	; 16 bit
	ldr r2, =Son 
	ldr r4, =SortieSon 
	ldrsh r0, [r2, r3, lsl #1] 
	add r3, #1 
	str r3,  [r1]
	;SortieSon=mise_a_echelle(SonBrut) 
	;SonBrut += 32768
	add r0, #32768
	;SortieSon=SonBrut
	mov r3, #92
	udiv r0, r3 
	strh r0, [r4]
	bl PWM_Set_Value_TIM3_Ch3
	b finsi 
then 
	bl StartSon 
finsi 
	pop {pc,r4}
	endp
StartSon proc 
	ldr r0, =Index 
	mov r1, #0 
	str r1, [r0] 
	bx lr 
	endp 
	
	END

	

		
	bx lr 
	endp 	
	END	