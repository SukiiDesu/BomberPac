########################################################
#                     CHECKLIST
########################################################
#                       INPUT
# [x] Integrar o KDMMIO
# [x] Pool do teclado
########################################################
#                       OUTPUT
# [] Integrar Bitmap Display
# [] Desenhar uma linha
# [] Preencher uma matriz (linhas empilhadas)
########################################################
#                     FUNCIONALIDADES
# [] Movimentar personagem em uma direcao
# [] Movimentar em todas as direcoes
# [] Colisao com parede
########################################################


########################################################
#                     MACROS
########################################################

# Macro para chamadas simples do sistema
.macro System(%op)	
	li a7,%op
	ecall	
.end_macro 

.macro Escreva_ASCII_no_Console(%reg)
	mv a0,%reg
	System(11)
	li a0,0
.end_macro 

.include ".\macros\TECLADO.s"
.include ".\macros\MACROSv24.s"

########################################################
#                  MAIN (GAME LOOP)
########################################################
.data
	.eqv ENDERECO_CONTROLE_TECLADO 0xFF200000		# Endereco de Controle KDMMIO
	.eqv ENDERECO_TECLA_LIDA 0xFF200004			# Endereco de Armazenamento KDMMIO
	.eqv ENDERECO_DISPLAY_TECLADO 0xFF20000C		# Endereco de Echo KDMMIO
.text
MAIN:
LOOP:	Le_Tecla_Non_Blocking(s0)	# Chama funcao de leitura do KDMMIO e guarda a reposta, se houver, em s0
	# Escreva_ASCII_no_Console(s0) 	# Escreve um valor ASCII no console. Caso s0==0 nao escreve nada
	
	j LOOP				# Retorna para o Game Loop
	System(10) 			# Encerra o SO

.include ".\macros\SYSTEMv24.s"