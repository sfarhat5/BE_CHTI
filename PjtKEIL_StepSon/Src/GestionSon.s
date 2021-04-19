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

	
; ===============================================================================================
	
	EXPORT CallbackSon; 

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		

CallbackSon proc 
;	kik
;	lil

	ldr r3, =Son 
	
	ldrh r4, [

		
	bx lr 
	endp 	
	END	