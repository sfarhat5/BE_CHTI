	PRESERVE8
	THUMB   
		
	include ./Driver/DriverJeuLaser.inc
; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
;FlagCligno dq 
FlagCligno dcb 0
	
; ===============================================================================================
	
	EXPORT timer_callback; 
	
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici	

;char FlagCligno;

;void timer_callback(void)
timer_callback proc
	;if (FlagCligno==1)
	push {lr}
	ldr r2,=FlagCligno 
	ldrb r1, [r2]
	
	cmp r1, #1  
	beq active_gpio 
;{
		;FlagCligno=0;
	
		
		;GPIOB_Set(1);
	;}
	;else
	mov r0, #1 
	bl GPIOB_Clear 
	mov r1, #1 
	str r1, [r2]
	pop {pc}
	;{
active_gpio 
	mov r0, #1 
	bl GPIOB_Set 
	mov r1, #0 
	str r1, [r2]
	pop {pc}
	endp
		;FlagCligno=1;
		;GPIOB_Clear(1);
	;}
		
;}
	

		
		
	END