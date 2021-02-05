.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global swap
.type swap, %function

swap:
	push {fp, lr}
	add fp, sp, #4

	push {r9}
	push {r10}
	
	ldr r9,[r10]
	ldr r10, [r1]
	
	mov r2, r9
	mov r9, r10
	mov r10, r2
	
	@ store r9 and r10 back into r0, r1
	str r9, [r0]
	str r10, [r1]

	@ restore r10 and r9
	pop {r10}
	pop {r9}	


	sub sp, fp, #4
	pop {fp, pc}
