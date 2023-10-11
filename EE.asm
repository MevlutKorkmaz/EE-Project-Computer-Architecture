.include "macros.asm"
.data
inputCounter: .word 0
deck: .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14   # Ace through King of spades
       2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14   # Ace through King of hearts
       2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14    # Ace through King of clubs
       2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14   # Ace through King of diamonds

array1:         .space 28        # Spaces for player cards
array2:         .space 28       # Spaces for player cards
array3:         .space 28        # Spaces for player cards
array4:         .space 28       # Spaces for player cards
array5:         .space 112       # Spaces for that rounds cards

card1: .word 3   # Card counter 1
card2: .word 3    # Card counter 2
card3: .word 3    # Card counter 3
card4: .word 3    # Card counter 4
result: .word 0   # Variable to store the how many cards are in the specific round


space:	.asciiz " "		# a space string.

newline: .asciiz "\n"
colonsp:	.asciiz ": "	# a colon string with space.
array:	.word	0 : 30	# an array of word, for storing values.
size:	.word	5		# actual count of the elements in the array.
previousArray: .word 0 : 40
previousArraySize: .word 40

param_info_string:	.asciiz	"Enter how many cards are you going to bet (if you want to call the previous bet enter 0):"
receive_values_loop_info_string:	.asciiz	"Input each value(one at a time): "
receive_values_loop_iter_string:	.asciiz	"Input"
receive_values_loop_iter_string2:	.asciiz	" value#"
sorted_array_string:	.asciiz "\n"
playerCards1: .asciiz "Player1 your cards are: \n"
playerCards2: .asciiz "Player2 your cards are: \n"
playerCards3: .asciiz "Player3 your cards are: \n"
playerCards4: .asciiz "Player4 your cards are: \n"
previousCards: .asciiz "\nPrevious players bets in total: \n"
player1: .asciiz "PLAYER1 lost the game."
player2: .asciiz "PLAYER2 lost the game."
player3: .asciiz "PLAYER3 lost the game."
player4: .asciiz "PLAYER4 lost the game."
cardsOnTheTable: .asciiz "Last rounds cards: "


	.text
	.globl	mainnn
	addi  $sp,$sp,-100
	la	$sp, previousArray
	move $fp, $sp
	
	
	
	


cardLoad:
	
    la $t0, card1    # Load address of card1 into $t0
    lw $t1, ($t0)    # Load value of card1 into $t1

    la $t0, card2    # Load address of card2 into $t0
    lw $t2, ($t0)    # Load value of card2 into $t2

    add $t3, $t1, $t2  # Add card1 and card2, store result in $t3

    la $t0, card3    # Load address of card3 into $t0
    lw $t4, ($t0)    # Load value of card3 into $t4

    add $t3, $t3, $t4  # Add result with card3, store result in $t3

    la $t0, card4    # Load address of card4 into $t0
    lw $t5, ($t0)    # Load value of card4 into $t5

    add $t3, $t3, $t5  # Add result with card4, store final result in $t3

    la $t0, result   # Load address of result variable into $t0
    sw $t3, ($t0)    # Store the final result in the result variable
    
        # Jump to the modifyCardNumber function
        la $s0, size
        lw $s1, ($s0)
        
    beqz $s1, modifyCardNumberBetChecker




m:
# Shuffle the deck by swapping two random slots 1,000 times
    li $t1, 1000        # loop counter for shuffling
j shuffle_loop
main:
    # Initialize registers
    la $s0, deck     # Load the address of source_array into $s0
    la $s1, array1           # Load the address of array1 into $s1
    la $s2, array2           # Load the address of array2 into $s2
    la $s3, array3           # Load the address of array3 into $s3
    la $s4, array4           # Load the address of array4 into $s4
    la $s5, array5           # Load the address of array4 into $s4

    # Load division points
    #lw $t0, card1       # Load division point 1 into $t0
    #lw $t1, card2       # Load division point 2 into $t1
    #lw $t2, card3       # Load division point 3 into $t2
   # lw $t3, card4       # Load division point 4 into $t3
  #  lw $t7, result       # Load division point 4 into $t3
	
	
	# Copy elements from source_array to array1 (indices 0-1)
    li $t4, 0                # Start index
    lw $t5, result       # End index
    
    copy_elements0:
        beq $t4, $t5, copy_array1  # If end index is reached, jump to copying array2
        lw $t6, ($s0)          # Load an element from source_array
        sw $t6, ($s5)          # Store the element in array1
        addiu $s0, $s0, 4      # Increment the address of source_array by 4 bytes
        addiu $s5, $s5, 4      # Increment the address of array1 by 4 bytes
        addiu $t4, $t4, 1      # Increment index
        j copy_elements0       # Jump back to copy_elements
	
copy_array1:
    # Copy elements from source_array to array1 (indices 0-1)
    li $t4, 0                # Start index
    lw $t5, card1       # End index
    la $s0, deck     # Load the address of source_array into $s0
    
    copy_elements:
        beq $t4, $t5, copy_array2   # If end index is reached, jump to copying array2
        lw $t6, ($s0)          # Load an element from source_array
        sw $t6, ($s1)          # Store the element in array1
        addiu $s0, $s0, 4      # Increment the address of source_array by 4 bytes
        addiu $s1, $s1, 4      # Increment the address of array1 by 4 bytes
        addiu $t4, $t4, 1      # Increment index
        j copy_elements       # Jump back to copy_elements

    # Copy elements from source_array to array2 (indices 2-5)
    copy_array2:
        lw $t4, card1                # Start index
        lw $t5, card2      # End index (exclusive)
        add $t5,$t5,$t4
     
        copy_elements2:
            beq $t4, $t5, copy_array3   # If end index is reached, jump to copying array3
            lw $t6, ($s0)          # Load an element from source_array
            sw $t6, ($s2)          # Store the element in array2
            addiu $s0, $s0, 4      # Increment the address of source_array by 4 bytes
            addiu $s2, $s2, 4      # Increment the address of array2 by 4 bytes
            addiu $t4, $t4, 1      # Increment index
            j copy_elements2       # Jump back to copy_elements2

    # Copy elements from source_array to array3 (indices 6-11)
    copy_array3:
        lw $t4, card2                # Start index
        lw $t5, card3       # End index (exclusive)
 add $t5,$t5,$t4
        copy_elements3:
            beq $t4, $t5, copy_array4   # If end index is reached, jump to copying array4
            lw $t6, ($s0)          # Load an element from source_array
            sw $t6, ($s3)          # Store the element in array3
            addiu $s0, $s0, 4      # Increment the address of source_array by 4 bytes
            addiu $s3, $s3, 4      # Increment the address of array3 by 4 bytes
            addiu $t4, $t4, 1      # Increment index
            j copy_elements3       # Jump back to copy_elements3

    # Copy elements from source_array to array4 (indices 12-19)
    copy_array4:
        lw $t4, card3                 # Start index
        lw $t5, card4      # End index (exclusive)
         add $t5,$t5,$t4
        copy_elements4:
            beq $t4, $t5, mainnn     # If end index is reached, jump to end_copy
            lw $t6, ($s0)          # Load an element from source_array
            sw $t6, ($s4)          # Store the element in array4
            addiu $s0, $s0, 4      # Increment the address of source_array by 4 bytes
            addiu $s4, $s4, 4      # Increment the address of array4 by 4 bytes
            addiu $t4, $t4, 1      # Increment index
            j copy_elements4       # Jump back to copy_elements4
            
            
shuffle_loop:

        # Pick two random slots
        jal random_slot
        move $t6, $v0       # save the first random slot
        jal random_slot
        move $t7, $v0       # save the second random slot

        # Swap the values in the two slots
        lw $t8, ($t6)       # load the first value
        lw $t9, ($t7)       # load the second value
        sw $t9, ($t6)       # store the second value in the first
        sw $t8, ($t7)       # store the first value in the second

   	# Decrement the loop counter and check if we're done shuffling
    	addi $t1, $t1, -1
   	bne $t1, $zero, shuffle_loop  	
   j main
  	
random_slot:
	la $t0, deck # load the address of the deck array
	li $a1, 52 # set the number of slots in the deck array
	li $v0, 42 # set the syscall number for getting a random integer
	syscall # call the random integer syscall
	move $t2, $a0 # move the random integer into a register
	mul $t2, $t2, 4 # multiply the random integer by 4 to get the byte offset of the selected slot
	add $v0, $t0, $t2 # add the byte offset to the address of the deck array to get the address of the selected slot
	jr $ra # return from the function


mainnn:


la $t0, inputCounter    # Load address of card1 into $t0
    lw $t1, ($t0)    # Load value of card1 into $t1
	# Perform operation mod4 on input number
	li $t0,4
    div  $t1, $t0    # $t0 = $a0 % 4
mfhi $t0
    # Select the player's card counter based on the result of mod4
    
 # player info    
    beq $t0, 0, aa
    beq $t0, 1, bb   
    beq $t0, 2, cc   
    beq $t0, 3, dd   


#to show players to their own cards
aa:

	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, playerCards1 
	syscall				
arrayPrinter (array1, card1)
bb:
	
	li	$v0, 4			
	la	$a0, playerCards2 
	syscall				
arrayPrinter (array2, card2)
cc:
	
	li	$v0, 4			
	la	$a0, playerCards3 
	syscall				
arrayPrinter (array3, card3)
dd:	
	
	li	$v0, 4			
	la	$a0, playerCards4 
	syscall				
arrayPrinter (array4, card4)


params_info:
	li	$v0, 4			
	la	$a0, previousCards 
	syscall				
	#printing the total of the users previous bets, add zero between them to recognize
previousArrayPrinter (previousArray, previousArraySize)

	la $t0, inputCounter   
    lw $t1, ($t0)    # Load value of card1 into $t1
    addi $t1,$t1,1
    sw $t1, ($t0)
	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, param_info_string	# load params_info_string to argument register $a0.
	syscall				# Enter how many cards are you going to bet (if you want to call the previous bet enter 0):
	############################################################################################################3
params:
	li	$v0, 5			# 5 = read_int syscall.
	syscall				# issue a system call.
	la	$t0, size		# load address of size to $t0.
	move $t1,$v0
	sw	$t1, 0($t0)	
	beqz $t1, cardLoad
		# store returned value in $v0 to size.

receive_values_loop_info:
	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, receive_values_loop_info_string	# load receive_values_loop_info_string to argument register $a0.
	syscall				# Input each value(one at a time):
	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, newline		# load line to argument register $a0.
	syscall				# \n
receive_values_loop_prep:
	la	$t0, array		# load array to $t0.
	lw	$t1, size		# load size to $t1.
	li	$t2, 0			# loop runner, starting from 0.
receive_values_loop:
	bge	$t2, $t1, sort_prep	# while ($t2 < $t1).
	
	
	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, receive_values_loop_iter_string # load receive_values_loop_iter_string to argument register $a0.
	syscall				# issue a system call.
	li	$v0, 1			# 1 = print_int syscall.
	addi	$a0, $t2, 1		# load (runner + 1) to argument register $a0.
	syscall	
	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, receive_values_loop_iter_string2 # load receive_values_loop_iter_string to argument register $a0.
	syscall				# issue a system call.
	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, colonsp		# load colonsp to argument register $a0.
	syscall				# issue a system call.

	li	$v0, 5			# 5 = read_int syscall.
	syscall				# issue a system call.
	sw	$v0, 0($t0)		# store returned value from syscall in the array.

	addi	$t0, $t0, 4		# increment array pointer by 4.
	addi	$t2, $t2, 1		# increment loop runner by 1.
	j	receive_values_loop	# jump back to the beginning of the loop.

sort_prep:
	la	$t0, array		# load array to $t0.
	lw	$t1, size		# load array size to $t1.
	li	$t2, 1			# loop runner, starting from 1.
sort_xloop:
	la	$t0, array		# load array to $t0.
	bge	$t2, $t1, sort_xloop_end	# while (t2 < $t1).
	move	$t3, $t2		# copy $t2 to $t3.
sort_iloop:
	la	$t0, array		# load array to $t0.
	mul	$t5, $t3, 4		# multiply $t3 with 4, and store in $t5
	add	$t0, $t0, $t5		# add the array address with $t5, which is the index multiplied with 4.
	ble	$t3, $zero, sort_iloop_end	# while (t3 > 0).
	lw	$t7, 0($t0)		# load array[$t3] to $t7.
	lw	$t6, -4($t0)		# load array[$t3 - 1] to $t6.
	bge	$t7, $t6, sort_iloop_end	# while (array[$t3] < array[$t3 - 1]).
	lw	$t4, 0($t0)
	sw	$t6, 0($t0)
	sw	$t4, -4($t0)
	subi	$t3, $t3, 1
	j	sort_iloop		# jump back to the beginning of the sort_iloop.
sort_iloop_end:
	addi	$t2, $t2, 1		# increment loop runner by 1.
	j	sort_xloop		# jump back to the beginning of the sort_xloop.
sort_xloop_end:
	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, sorted_array_string	# load sorted_array_string to argument register $a0.
	syscall				# issue a system call.
	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, newline		# load line to argument register $a0.
	syscall				# issue a system call.
	
	li	$t0, 0
       
	
        sw $t0, ($fp)          # Store the element in array1
	addiu $fp, $fp, 4      # Increment the address of array1 by 4 bytes
	j	print			# call print routine.




exit:
	li	$v0, 10			# 10 = exit syscall.
	syscall				# issue a system call.

print:
print_loop_prep:
	
	la	$t0, array
	lw	$t1, size
	li	$t2, 0

    copy_elementss:
        bge $t2, $t1, mainnn # If end index is reached, jump to copying array2
        lw $t6, ($t0)          # Load an element from source_array
        sw $t6, ($fp)          # Store the element in array1
        addiu $t0, $t0, 4      # Increment the address of source_array by 4 bytes
        addiu $fp, $fp, 4      # Increment the address of array1 by 4 bytes
        addiu $t2, $t2, 1      # Increment index
        j copy_elementss      # Jump back to copy_elements
     
  
  
lost1:
   	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, player1	# load receive_values_loop_info_string to argument register $a0.
	syscall	
	j exit	
lost2:
   	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, player2	# load receive_values_loop_info_string to argument register $a0.
	syscall	
	j exit	

lost3:
   	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, player3	# load receive_values_loop_info_string to argument register $a0.
	syscall	
	j exit	
	
lost4:
   	li	$v0, 4			# 4 = print_string syscall.
	la	$a0, player4	# load receive_values_loop_info_string to argument register $a0.
	syscall	
	j exit	
	
incrementCard1:
    incrementCardNum (card1)

incrementCard2:
   incrementCardNum (card2)

incrementCard3:
    incrementCardNum (card3)

incrementCard4:
   incrementCardNum (card4)	


modifyCardNumberBetChecker:
######################################################################################3
#checking which player is right depending on the answer increase by 1 of one of their cards
la	$t0, size		# load address of size to $t0.
lw	$t1, ($t0)
la	$t2, array		# load array to $t0.
lw	$t3, ($t2)		# load array to $t0.
la	$t4, array5		# load size to $t1.
lw	$t5,($t4)
la	$t6,result
lw	$t7,($t6)
li	$s1, 0
li	$s2,0
loo:

beq $t3,$t5, loo2
addi $t4,$t4,4

lw	$t5,($t4)
addi $s2,$s2,1

bgt $s2,$t7,end
bgt $s2, $t7, endBluff
j loo

loo2:
sw $zero, ($t4)
la	$t4, array5
lw	$t5,($t4)
addi $t2,$t2,4
lw	$t3,($t2)	
	# 
addi $s1,$s1,1
j loo
end:
la $t0, inputCounter
lw $a0, ($t0)  
#li $s7,1
#sub  $a0,$a0, $s7
li $t0,4
div  $a0, $t0    # $t0 = $a0 % 4
mfhi $t0
j increment
endBluff:
la $t0, inputCounter
lw $a0, ($t0)
li $s7,1
sub  $a0,$a0, $s7

li $t0,4
div  $a0, $t0    # $t0 = $a0 % 4
mfhi $t0
j increment
########################################################################################
increment:
	

    # Select the player's card counter based on the result of mod4
    beq $t0, 1, incrementCard1    # If $t0 = 0, go to incrementCard1
    beq $t0, 2, incrementCard2    # If $t0 = 1, go to incrementCard2
    beq $t0, 3, incrementCard3    # If $t0 = 2, go to incrementCard3
    beq $t0, 0, incrementCard4    # If $t0 = 3, go to incrementCard4



 




