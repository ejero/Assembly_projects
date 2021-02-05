@ gen_Permutation.s
.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global gen_Permutation
.type gen_Permutation, %function

gen_Permutation:
	push {fp, lr}	@ on to the stack
	add fp, sp, #4	@ setting up fp to point to where lr is
	
	@ r0 <- sp
	@ r1 <- SIZE top of the stack
	@ r0 and r1 need to be saved
	push {r0} 
	push {r1}	@ push {r0, r1} order does not matter	
	
	@ generate a random number and mod r1  
	@ m <- rand() % 10; r1 = 10
	bl rand		@ returns random number into r0 then mod by r1
			@ r0 alrady has value of 'a'
			@ 10 is on top of the stack
	ldr r1, [sp]	@ loading r1 whatever is in the stack
	
	bl modulo 	@ (a,b) takes in two numbers returns r0
	
	push {r0}	@ push on the stack

	@ n = rand() % r1  *** second random number *** 
	bl rand		@ r0 

	ldr r1, [sp, #4]	@ geting 10
	bl modulo	@ returns n into r0
	push {r0}	@ now stack has r0. n onto the stack
        
	@ swap (& x[m], &x[n])
	@ sp + m *4 -> sp + m*4 becomes sp + m * 4

	ldr r3, [sp, #12]	@ load r3 address of where sp is
	ldr r1, [sp, #4]
	
	@ Calculate mem location at index m of array
	add r0, r3, r1, LSL #2	@ r0 = sp + r1 * 4 [m]
	
	ldr r1, [sp]		@ n
	add r1, r3, r1, LSL #2	@ r1 = sp + r1 * 4 [n]

	bl swap		@ take in two addresses

	sub sp, fp, #4
	pop {fp, pc}
	
  








