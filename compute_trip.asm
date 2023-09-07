extern printf                                               

extern scanf                                                


global compute_trip

segment .data                 
string_format db "%s", 0
float_format db "%lf",0
initial_distance db "Please enter the speed for the initial segment of the trip (mph): ", 0
initial_speed db "for how many miles?  ",0
second_speed db "What will be your speed during the final segment of the trip (mph)?  ",0

average_speed db "Your average speed will be: ", 10,0
mph db "  mph",0
final_time db "The total travel time will be: ", 10,0
hours db "  hours",0
spacer db "", 10,0
;average_speed db "Your average speed will be %lf mph", 10, 0
total_miles dq 253.5
wrong_in dq -1.0

segment .bss      
first_leg_distance resq 1
first_leg_speed resq 1
second_leg_speed resq 1

total_time resq 1
avg_speed resq 1

segment .text
compute_trip:                                          


push       rbp                                              
mov        rbp, rsp                                         
push       rbx                                              
push       rcx                                              
push       rdx                                              
push       rsi                                              
push       rdi                                              
push       r8                                               
push       r9                                               
push       r10                                              
push       r11                                              
push       r12                                              
push       r13                                              
push       r14                                              
push       r15                                              
pushf                   

;<mov rdi to format and rsi to variable memory pring and same with scanf but input to top of stack then save that to xmm register so can do other operations >

;prompt user for initial distance
mov rax, 0
mov rdi, string_format
mov rsi, initial_distance
call printf

;collect inital distance and save to first_leg_distance
mov rax, 0
mov rdi, float_format
mov rsi, first_leg_distance
call scanf

;prompt user for inital speed
mov rax, 0
mov rdi, string_format
mov rsi, initial_speed
call printf

;collect inital speed and save to first_leg_speed
mov rax, 0
mov rdi, float_format
mov rsi, first_leg_speed
call scanf

;prompt user for final speed
mov rax,0
mov rdi, string_format
mov rsi, second_speed
call printf

;collect second speed and save to second_leg_speed
mov rax, 0
mov rdi, float_format
mov rsi, second_leg_speed
call scanf

;======================================calculations==========================================
;move total_miles to xmm8
movsd xmm8, [total_miles]

;move first leg distance to xmm9
movsd xmm9, [first_leg_distance]

;move first leg speed to xmm10
movsd xmm10, [first_leg_speed]

;move second speed to xmm11
movsd xmm11, [second_leg_speed]

;calc second distance
subsd xmm8, xmm9                     ;total miles - first leg ==> second distance (xmm8)

;calc second time
divsd xmm8, xmm11                    ;second distance / second speed ==> second time (xmm8)

;calc first time
divsd xmm9,xmm10                     ;first distance / first speed ==> first time (xmm9)

;total time
addsd xmm9, xmm8 ;total time (xmm9)

;total speed
addsd xmm10,xmm11 ;total speed (xmm11)

;avg speed
divsd xmm11,xmm9 ;avg speed (xmm11)

;================================= dispaly ========================================================

;display avg speed prompt
mov rax,0
mov rdi, string_format
mov rsi, average_speed
call printf

movsd xmm0,xmm11
mov rdi, float_format
mov rsi, average_speed
call printf

mov rax,0
mov rdi, string_format
mov rsi, mph
call printf

;display nothing
mov rax,0
mov rdi, string_format
mov rsi, spacer
call printf

;display total time prompt
mov rax,0
mov rdi, string_format
mov rsi, final_time
call printf

movsd xmm0,xmm9
mov rdi, float_format
mov rsi, total_time
call printf

mov rax,0
mov rdi, string_format
mov rsi, hours
call printf

;display nothing
mov rax,0
mov rdi, string_format
mov rsi, spacer
call printf

;fina:
popf                                                        
pop        r15                                              
pop        r14                                              
pop        r13                                              
pop        r12                                              
pop        r11                                              
pop        r10                                              
pop        r9                                               
pop        r8                                               
pop        rdi                                              
pop        rsi                                              
pop        rdx                                              
pop        rcx                                              
pop        rbx                                              
pop        rbp                                              


ret