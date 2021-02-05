.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text

.align 2
.global init
.type init, %function

init:
	push {fp, lr}	@ on to the stack
	add fp, sp, #4	@ setting up fp to point to where lr is
	
	@ array -> r0, #10 -> r1
 	@ run a loop with r10
	@ for (i = 0; i < SIZE; i++);
	@ array [i] = i + 1
	@ init  i = 0
	mov r10, #0 	@ r10 = 0

init_loop:
	@ i < SIZE
	cmp r10, r1	@ i < 10
	
	@ quit loop is i >= SIZE
	bge done_init_loop
	
	@ array[i] = i + 1 same as [x, i * 4]
	@ calculate array offset corresponding to i
	mov r2 , r10, LSL #2	@ mul by 4

	@ store i + 1 into offset = [r0, r2]
	add r3, r10, #1		@ value i + i into r2
	str r3, [r0, r2]	@ store value array[1] = r3

	@ increment i 
	add r10, r10, #1	@ i = i + 1

	b init_loop

done_init_loop:
	@ reset sp, fp
	sub sp, fp, #4
	pop {fp, pc}


		