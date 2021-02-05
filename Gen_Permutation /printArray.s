.cpu cortex-a53
.fpu neon-fp-armv8


.data
outp:	.asciz "%d " 

.text
.align 2
.global printArray
.type printArray, %function


printArray:
	push {fp, lr}
	add fp, sp, #4 

	@ r0 = array at index 0
	@ r1 = number of elements
	
	mov r10, r0
	mov r9, r1
	
	mov r8, #0 @ r8 =  i for the counter
	

printArrayLoop: 	
	@ for(r8 = 0, r8 < r9, r8++)
	cmp r8, r9 @ r8 vs r9

	bge done_printarrayLoop
	
	mov r2 , #4
	mul r2, r2, r8 @ r2 = 4 * i
	
	ldr r1, [r10, r2] @ [sp, r2]
	ldr r0, =outp
	
	bl printf
	
	add r8, r8, #1
	
	b printArrayLoop

done_printarrayLoop:

	sub sp, fp, #4
	pop {fp, pc}
