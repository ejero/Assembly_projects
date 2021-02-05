@ define the Arm architecture
.cpu cortex-a53
.fpu neon-fp-armv8

@ define constants / global variables
.data
.text
.align 2
.global checkPrimeNumber
.type checkPrimeNumber, %function

checkPrimeNumber:
	push {fp, lr}		@ save lr and fp
		
	add fp, sp, #4		@ setting fp to point to where lr is
	sub sp, sp, #16
			
	str r0, [fp, #-16]	@ {n -16} storing r0 and makeing space for int j, n, #2, flag = 1 
	
	mov r3, #1		@ int flag = 1
	str r3, [fp, #-12]	
	
	mov r3, #2		@ int j = 2
	str r3, [fp, #-8]
	
	ldr r3, [fp, #-16]	@ taking r0 from stack (n)
	mov r2, #2		@  2

loop:
	cmp r3, r2
	ble endprogram 		@ when j < n/2
	
lessthan:	

	
	@ -----> modulo < ------ 	
	udiv r1, r3, r2		@ use r3 to store remainder
	mul r1, r1, r2
	sub r1, r3, r1
	cmp r1, #0		@ if j == 0
	bne	plusplusJ	@ branch to ++j if j < n/2
	mov r3, #0
	str r3, [fp, #-12]	@ flag = 0
	b endprogram
	
	
plusplusJ:
		
	add r2, r2, #1		@ ++j
	b loop	

endprogram:
	ldr r3, [fp, #-12]	@ flag = 0
	mov r0, r3 		@ r0 = flag
	sub sp, fp, #4
	pop {fp, pc}
	
	
	
