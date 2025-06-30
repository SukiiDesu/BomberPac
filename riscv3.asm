.text 
	li t1, 201
	li t0, 20
	LOOP_PRINTA_ALGARISMOS_TIMER:
	addi t0, t0, -1
	beqz t1, PULA_REDUZ_TIMER
	li t3, 10
	rem s2, t1, t3	# Pega o alagrismo desejado
	sub t1, t1, s2	# Subtrai as unidades
	div t1, t1, t3	
	j LOOP_PRINTA_ALGARISMOS_TIMER
	
PULA_REDUZ_TIMER:
	li a7, 10
	ecall