@ define the Arn architecture
.cpu cortex-a53
.fpu neon-fp-armv8

@ define constants / gloabal variables
.data
inp1:	.asciz "Enter two positive numbers: "
input:	.asciz "%d "
output:	.asciz "Prime numbers between %d and %d are: "
input2:	.asciz "\n\n%d %d"

.text
.align 2
.global main
.type main, %function

main:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16

	ldr r0, =inp1	@ printf("Enter two positive numbers: "
	bl printf
	
	sub r2, fp, #20	@ n1
	sub r3, fp, #16 @ n2
	mov r1, r3	@ r3 = n2
	ldr r0, =input2	@ scanf ("%d %d, &n1, &n2)	
	bl scanf
	
	ldr r3, [fp, #-16]	@ n1
	ldr r2, [fp, #-20]	@ n2
	mov r1, r3		@ r1 = n1
	ldr r0, =output	@ printf("Prime numbers between %d and %d are:")
	bl printf

	ldr r3, [fp, #-16]	@ r3 = n1
	add r3, r3, #1		@ r3 = r3 + 1
	str r3, [fp, #-8]	@ store value in -8
	b compareNum		@ branch 


checkIfPrime:
	ldr r0, [fp, #-8]	@ value of n1
	bl checkPrimeNumber
	str r0, [fp, #-12]	@ store flag 
	ldr r3, [fp, #-12]	@ r3 = flag
	cmp r3, #1		@ check flag
	bne plusplusi		@ branch to plus plus i			
	ldr r1, [fp, #-8]	@ if equal to 1 print i	
	ldr r0, =input		@ "%d"
	bl printf

plusplusi:
	ldr r3, [fp, #-8] 	@ r3 = n1
	add r3, r3, #1		@ r3 = r3 + 1
	str r3, [fp, #-8]	@ store new value of n1 + 1
 	


compareNum:
	ldr r3, [fp, #-20]	@ r3 = n1
	ldr r2, [fp, #-8]	@ r2 = n2
	cmp r2, r3
	blt checkIfPrime	@ branch to check prime number
	
	mov r3, #0
	mov r0, r3		@ return 0
	sub sp, fp, #4
	pop {fp, pc}		





	
	
	





