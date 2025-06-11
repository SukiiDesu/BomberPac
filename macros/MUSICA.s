########################################################
#                     MACROS
########################################################

# reg1 == Tempo atual, reg2 == Tempo de tocar a proxima nota, reg3 == Endereco da nota atual
.macro Toca_Musica(%reg1, %reg2, %reg3)
	beqz %reg1,TOCA_NOTA	# Toca a primeira nota

	# Atualiza o tempo desde a ultima nota tocada
	System(30)	# Pega tempo atual
	mv %reg1, a0	# Atual tempo atual

	# Verifica se a nota contida no endereco %reg3 deve ser executada
	bge %reg1, %reg2, TOCA_NOTA	# Se tempo atual >= tempo proxima nota -> Toque nota
	j FIM_TOCA_MUSICA

TOCA_NOTA:
	lw a0,0(%reg3)	# Pega o pitch da nota
	lw a1,4(%reg3)	# Pega a duracao da nota
	System(31)

# Se a nota foi tocada,
ATUALIZA_NOTA:
	# Atualiza o tempo desde a ultima nota tocada
	System(30)	# Pega tempo atual
	mv %reg1, a0	# Atual tempo atual
	
	lw t3,4(%reg3)		# Pega a duracao da nota atual
	add %reg2,%reg1,t3	# Atualiza o tempo proxima nota como tempo atual + duracao nota atual : O valor bruto estah em milissegundos???? Dividir por 1000?
	
	# Atualiza o endereco da nota de modo ciclico
	addi t0,t0,1			# Passa para a proxima nota
	rem t0,t0,s6			# t0 = t0 % tamanho_musica 
	beqz t0,RETORNA_INICIO_MUSICA	# Se a musica ainda nao acabou -> Encerre a funcao
	addi %reg3, %reg3,8		# Pege o endereco da proxima nota
	j FIM_TOCA_MUSICA

RETORNA_INICIO_MUSICA:	# Garante loop musical
	la %reg3, NOTAS	# Volta para a primeira nota

FIM_TOCA_MUSICA:
.end_macro 


.macro System(%op)
	li a7,%op
	ecall
.end_macro
########################################################
#                     MAIN
########################################################
.data
# Numero de Notas a tocar
TAMANHO_MUSICA: .word 13
# lista de nota,dura??o,nota,dura??o,nota,dura??o,...
NOTAS: 69,500,76,500,74,500,76,500,79,600, 76,1000,0,1200,69,500,76,500,74,500,76,500,81,600,76,1000

.include "..\sons\musica_fundo.data"

.text 
	la t5,NOTAS		# Pega o endereco do vetor de notas
	lw s6,TAMANHO_MUSICA	# Pega o tamanho da musica
	li a2,68		# Define o instrumento
	li a3,127		# Define o volume
	#System(30)		# a0 = tempo do sistema : Primeira chamada de tempo
	li t1, 0		# t1 = tempo do sistema
	#li a1,0		# Teste para troca de notas
	mv t2,t1		# t2 = tempo do sistema guardado + 1 segundo : A ideia eh garantir que a primeira nota eh sempre tocada : Garante???
	li t3,0			# Posicao nota = 0

LOOP_MUSICAL:
	Toca_Musica(t1,t2,t5)
	j LOOP_MUSICAL

FIM:	li a0,40		# define a nota
	li a1,1500		# define a dura??o da nota em ms
	li a2,127		# define o instrumento
	li a3,127		# define o volume
	li a7,33		# define o syscall
	ecall			# toca a nota
	System(10)