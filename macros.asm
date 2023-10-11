.macro incrementCardNum (%x)
 la $t0, %x 
 lw $t1, ($t0)
    # Load value of card1 into $t1
    addi $t1, $t1, 1  # Increment card1 by 1
    sw $t1, ($t0)    # Store the updated value of card1
    la $t0, inputCounter
 
sw $zero,($t0)	
la $fp,previousArray
previousArrayResetter(previousArray, previousArraySize)


    
.end_macro


.macro arrayPrinter (%Aaddress, %Asize)
    # Loop through the array
    la $t0, %Aaddress     # Load the base address of the array into $t0
    lw $t1, %Asize # Load the size of the array into $t1
    loop:
        beq $t1, $zero, end_loop # If array size is zero, exit the loop

        lw $a0, 0($t0)      # Load the element at the current index
        li $v0, 1           # Set $v0 to 1 to indicate print integer
        syscall             # Print the element

        la $a0, space      # Load the address of the format string
        li $v0, 4           # Set $v0 to 4 to indicate print string
        syscall             # Print the space after the element

        addiu $t0, $t0, 4   # Increment the array pointer by 4 bytes
        subiu $t1, $t1, 1   # Decrement the array size by 1

        j loop              # Jump back to the beginning of the loop

    end_loop:
     la $a0, newline     # Load the address of the newline string
        li $v0, 4           # Set $v0 to 4 to indicate print string
        syscall 
          j params_info          # Print a newline character
.end_macro


.macro previousArrayPrinter (%Aaddress, %Asize)
    # Loop through the array
    la $t0, %Aaddress     # Load the base address of the array into $t0
   
    lw $t1, %Asize # Load the size of the array into $t1
    loop:
        beq $t1, $zero, end_loop # If array size is zero, exit the loop

        lw $a0, 0($t0)      # Load the element at the current index
        li $v0, 1           # Set $v0 to 1 to indicate print integer
        syscall             # Print the element

        la $a0, space      # Load the address of the format string
        li $v0, 4           # Set $v0 to 4 to indicate print string
        syscall             # Print the space after the element

        addiu $t0, $t0, 4   # Increment the array pointer by 4 bytes
        subiu $t1, $t1, 1   # Decrement the array size by 1

        j loop              # Jump back to the beginning of the loop

    end_loop:
     la $a0, newline     # Load the address of the newline string
        li $v0, 4           # Set $v0 to 4 to indicate print string
        syscall 
          
.end_macro

.macro previousArrayResetter(%Aaddress, %Asize)
    # Loop through the array
    la $t0, %Aaddress     # Load the base address of the array into $t0
    lw $t1, %Asize # Load the size of the array into $t1
    loop:
        beq $t1, $zero, end_loop # If array size is zero, exit the loop
	sw $zero,($t0)
        
        addiu $t0, $t0, 4   # Increment the array pointer by 4 bytes
        subiu $t1, $t1, 1   # Decrement the array size by 1

        j loop              # Jump back to the beginning of the loop

    end_loop:
    li	$v0, 4			# 4 = print_string syscall.
	la	$a0, cardsOnTheTable	# load params_info_string to argument register $a0.
	syscall		
    RandomArrayPrinter (array5, result)
     la $a0, newline     # Load the address of the newline string
        li $v0, 4           # Set $v0 to 4 to indicate print string
        syscall 
        
         la $t0, card1    # Load address of card1 into $t0
    lw $t1, ($t0)    # Load value of card1 into $t1
    beq $t1, 7, lost1

	
        la $t0, card2    # Load address of card1 into $t0
  	 lw $t1, ($t0)    # Load value of card1 into $t1
    beq $t1, 7,lost2   # If $t0 = 1, go to incrementCard2
    
	
        la $t0, card3   # Load address of card1 into $t0
    lw $t1, ($t0)    # Load value of card1 into $t1
    beq $t1, 7, lost3  # If $t0 = 2, go to incrementCard3
    
	
        la $t0, card4   # Load address of card1 into $t0
    lw $t1, ($t0)    # Load value of card1 into $t1
    beq $t1, 7, lost4
    j m
.end_macro

.macro RandomArrayPrinter (%Aaddress, %Asize)
    # Loop through the array
    la $t0, %Aaddress     # Load the base address of the array into $t0
    lw $t1, %Asize # Load the size of the array into $t1
    loop:
        beq $t1, $zero, end_loop # If array size is zero, exit the loop

        lw $a0, 0($t0)      # Load the element at the current index
        li $v0, 1           # Set $v0 to 1 to indicate print integer
        syscall             # Print the element

        la $a0, space      # Load the address of the format string
        li $v0, 4           # Set $v0 to 4 to indicate print string
        syscall             # Print the space after the element

        addiu $t0, $t0, 4   # Increment the array pointer by 4 bytes
        subiu $t1, $t1, 1   # Decrement the array size by 1

        j loop              # Jump back to the beginning of the loop

    end_loop:
     la $a0, newline     # Load the address of the newline string
        li $v0, 4           # Set $v0 to 4 to indicate print string
        syscall 
          
.end_macro

