.cpu cortex-a53
.fpu neon-fp-armv8
.data
.text
.align 2
.global modulo
.type modulo, %function

modulo:
	@ save lr and fp -> remember right to left @ store on the stack
	push {fp, lr}
	
	add fp, sp, #4	@ setting fp to point to where lr is

	@ right now a is in r0 and b is in r1
	@ step 0: use r2 to store the reminder

	@ step 1: d = a / b
	udiv r2, r0, r1  @ r2 = r0 / r1

	@ step 2: d = d * b -> r2 = r2 * r1
	mul r2, r2, r1

	@ step 3: d = a-d -> r2 = r0 - r2
	sub r2, r0, r2

	@ step 4: return d @ the reaminder is in r2
	mov r0, r2


	sub sp, fp, #4 	@ restoring the value of sp using fp
	pop {fp, pc} @ -> restore into program counter into lr move PC
	
