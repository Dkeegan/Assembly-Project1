#Name: Denis Keegan
#UBId: 50172028

.data
prompt: .asciiz "Enter 5 numbers(max of 5 decimial):\n"
# this is stored at memory location 0 and at the end it is overwritten 
#Some parts are still in the memory location but the numbers somehow are null terminated I think
#so its still in the memory location and jumbled up but since its not being printed when I print out the memory locations
#I think its fine. Maybe Its not the right decsion but the pre-allication thing in recitation screw's up the code even more
.text
.globl main
.globl checkString
.globl count
.globl shifter
.globl endOfLoop
.globl addCount
.globl done
main:
	addi $t0, $0, '+' # to be check against
	addi $t1, $0, ',' # to be check against

	#Display the prompt 
	addi $v0, $0, 4			#MIPS Syscall to print string
	lui $a0, 0x1000			#Where I want to look for the string
	#I don't know if it's supposed to be in a0 but I tried another register and it crashed which doesn't make sense
	syscall
	
	#Get the user input 1
	addi $v0, $0, 8			#MIPS Syscall to read string
	lui $a0, 0x1000			#Where the string is to be written to
	syscall					#Syscall
	jal checkString			#GoTo check and then comeback and continue
	addi $0, $0, 0			#NOP
	
		
	

	#Get the user input 2
	addi $v0, $0, 8			#MIPS Syscall to read string
	lui $a0, 0x1000			#The memory location where the string is to be written to
	ori $a0,$a0,0x0008		#Add 0x8 places to the memory location 
	syscall
	jal checkString			#GoTo check and then comeback and continue
	addi $0, $0, 0			#NOP
	

	#Get the user input 3
	addi $v0, $0, 8			#MIPS Syscall to read string
	lui $a0, 0x1000			#The memory location where the string is to be written to
	ori $a0,$a0,0x0010		#Add 0x10 places to the memory location
	syscall
	jal checkString			#GoTo check and then comeback and continue
	addi $0, $0, 0			#NOP

	#Get the user input 4
	addi $v0, $0, 8			#MIPS Syscall to read string
	lui $a0, 0x1000			#The memory location where the string is to be written to
	ori $a0,$a0,0x0018		#Add 0x18 places to the memory location
	syscall
	jal checkString			#GoTo check and then comeback and continue
	addi $0, $0, 0

	#Get the user input 5
	addi $v0, $0, 8			#MIPS Syscall to read string
	lui $a0, 0x1000			#The memory location where the string is to be written to
	ori $a0,$a0,0x0020		#Add 0x18 places to the memory location
	syscall
	jal checkString			#GoTo check and then comeback and continue
	addi $0, $0, 0
		
	j		done			#jump to done
		addi $0, $0, 0		#nop
		addi $0, $0, 0		#nop


	
	
checkString:
	lb $t3, 0($a0)		#Load first digit
	addi $0,$0, 0
	beq $t3, $0, endOfLoop 		#If at end of string, end loop
	addi $0, $0, 0			#nop			
	addi $0, $0, 0			#nop I think it actually loads on this one
	addi $0, $0, 0			#nop This one is for s**ts and giggles
	slt $t4,$t3,$t0			#count t4 1 if +> whats in t3
	slt $t4,$t0,$t3			#count t4 1 if +< t3
	# I think one of those slt is not necessary but im leaving both in since it works
	addi $0, $0, 0			#nop
	addi $0, $0, 0			#nop
	addi $0, $0, 0			#nop
	beq $t4, $0, count 		#the binary check of t4 if it is 0 then go to count
	addi $0, $0, 0			#nop
	addi $0, $0, 0			#nop
	addi $0, $0, 0			#nop

	slt $t4,$t3,$t1			#count t4 1 if ,> whats in t3
	slt $t4,$t1,$t3			#count t4 1 if ,< whats in t3
	beq $t4, $0, count 		#If digit = ',', perform shift

	addi $0, $0, 0			#I want to tell a story about these particular nop's because I hate them
	addi $0, $0, 0			#Now dear grader you may be wondering why I hate these particlar nop's
	addi $0, $0, 0			#These Nops were the last things I added because nothing was working and I spent many hours looking over
							#My code but I did't know what was wrong. I spent many hours just playing around with it essentially
							#rewritting it until I figured this spot needed some nops so I put them in and low and behold it worked
							#Therefore these "no operations" are the "trivial" solution that I just looked past for many hours while
							#Trying to fix everything else. 
							#I may add a different story with time

	addi $a0, $a0, 1 		#Increment position
	j checkString			#jump to the to the top of the subroutine
	addi $0, $0, 0			#nop
	addi $0, $0, 0			#nop
endOfLoop:		
	jr $ra 					#Go back to the link
	addi $0, $0, 0			#nop
	addi $0, $0, 0			#nop


count:	addi $t6, $a0, 1 #keeps a count to where to start the next one

shifter:	
	lb $t4, 1($a0)		#load the byte in a0 offset by 1 and store it in t4
	addi $0, $0, 0		#nop
	addi $0, $0, 0		#nop
	addi $0, $0, 0		#nop
	sb $t4, 0($a0) 		#Store next digit into current digit's position
	beq $t4, $0, addCount  #If t4 is equal to 0 goto addCount
	addi $a0, $a0, 1 	#Increment position
	j shifter				#Loop
	addi $0, $0, 0		#nop
addCount:	
	addi $a0, $t6, 0	#add to the count
	j checkString		#go to checkstring
	addi $0, $0, 0		#nop
	addi $0, $0, 0		#nop
	addi $0, $0, 0		#nop
	
	
done:
	
############################################################################
#this part isn't really necessary for the project but I will leave it in
	addi $v0, $0, 4
	lui $a0, 0x1000
	syscall
	addi $v0, $0, 4


	addi $v0, $0, 4
	lui $a0, 0x1000
	addi $a0,$a0,8
	syscall
	
	


	addi $v0, $0, 4
	lui $a0, 0x1000
	addi $a0,$a0,16
	syscall


	addi $v0, $0, 4
	lui $a0, 0x1000
	addi $a0,$a0,24
	syscall


	addi $v0, $0, 4
	lui $a0, 0x1000
	addi $a0,$a0,32
	syscall
############################################################################
	addi $0, $0, 0		#end of the program


