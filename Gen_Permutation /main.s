.cpu cortex-a53
.fpu neon-fp-armv8

.data

.equ SIZE, 10

.text
.align 2
.global main
.type main, %function

main:
	push {fp, lr}	@ on to the stack
	add fp, sp, #4	@ setting up fp to point to where lr is

	@ making space for the array
	@ allocate 10 * 4 = 40 bytes / x[10]

	@ Calculate the number of bytes = 40
	mov r0, #SIZE
	mov r0, r0, LSL #2	@ multiplication by 4

	sub sp, sp, r0	@ allocates 10 memory locations 

	@ ------ INITIALIZE THE ARRAY ---- init (sp, SIZE)
	@ initialize array init ( sp, 5) sp in r0 and 10 into r1
	mov r0, sp
	mov r1, #SIZE

	@ branch to initialize the array
	bl init

	@ swap 2 random indices
	@ gen_permutations takes in (sp, SIZE). sp and size
	@ srand (time(0)) -> returns r0 which is already in sp

	mov r0, #0
	bl time		@ returns time in ms in r0
	bl srand


	mov r5, #0	
loop:

	cmp r5, #10
	bge done

	@ print array by calling printArray(array,size)
	@mov r0, sp
	@mov r1, #SIZE
	@bl printArray


	mov r0, sp
	mov r1, #SIZE
	bl gen_Permutation

	
	@ print array by calling printArray
	mov r0, sp
	mov r1, #SIZE
	bl printArray
	
	add r5, r5, #1
	b loop
	
done:
	@ quit
	mov r0, #0	@ return 0
	sub sp, fp, #4
	pop {fp, pc}





	