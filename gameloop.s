########################################################
#                     CHECKLIST
########################################################
#                       INPUT
# [x] Integrar o KDMMIO
# [x] Pool do teclado
########################################################
#                       OUTPUT
# [x] Integrar Bitmap Display
# [] Desenhar uma linha
# [] Preencher uma matriz (linhas empilhadas)
########################################################
#                     FUNCIONALIDADES
# [] Movimentar personagem em uma direcao
# [] Movimentar em todas as direcoes
# [] Colisao com parede
########################################################
#                         MENU
# [] Desenhar menu
# [] Selecionar botao
# [] Clicar botao
# [] Mudar animacao do botao
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

.include ".\macros\MACROSv24.s"
#.include ".\macros\MENU.s"
.include ".\macros\TECLADO.s"
#.include ".\macros\ATUALIZA_FRAME.s"
.include ".\macros\RENDERIZA.s"
#.include ".\macros\MUSICA.s"

########################################################
#                  MAIN (GAME LOOP)
########################################################
.data
	.eqv ENDERECO_CONTROLE_TECLADO 0xFF200000		# Endereco de Controle KDMMIO
	.eqv ENDERECO_TECLA_LIDA 0xFF200004			# Endereco de Armazenamento KDMMIO
	.eqv ENDERECO_DISPLAY_TECLADO 0xFF20000C		# Endereco de Echo KDMMIO
	.eqv ENDERECO_INICIAL_FRAME0 0xFF000000			# Endereco inicial : [0,0] do Frame 0
	VERDE: .word 0x10101010
	#.eqv ENDERECO_INICIAL_FRAME1 0xFF100000			# Endereco inicial : [0,0] do Frame 1
	#.eqv ENDERECO_INICIAL_PERSONAGEM ""			# Endereco inicial : [0,0] da "matriz" Personagem
	#.eqv ENDERECO_INICIAL_MOB1 ""
	#.eqv ENDERECO_INICIAL_MOB2 ""
	#.eqv ENDERECO_INICIAL_BOSS ""
	#.eqv DIRECAO s0	#Recebe WASD/SPACE BAR/P - P eh a cheat code para pular de nivel
	#.eqv SCORE s1
	#.eqv TEMPO s2
	#.eqv VIDAS s3
	#.eqv INIMIGOS_VIVOS s4  # Condicao de vitoria : saida do nivel
.text
MAIN:

		
#CONDIFURA:	# Seta Configuracoes a depender da Dificuldade / Fase	
			# Inicializa contadores
				####	
			# Inicializa enderecos iniciais
				####
			# Define imagens / Sprites / ...
				####
LOOP:	
	# Pegue Input : Tecla pressionada
		#Le_Tecla_Non_Blocking(s0)	# Chama funcao de leitura do KDMMIO e guarda a reposta, se houver, em s0
		#Escreva_ASCII_no_Console(s0) 	# Escreve um valor ASCII no console. Caso s0==0 nao escreve nada
	
	# Atualize o frame		# Alternar entre atualizar o 0 e o 1????
		####
	# Renderiza frame
		#la s5,LABEL			#Pegue endereco da imagem : essa word VERDE eh apenas para teste
		#li s4,ENDERECO_INICIAL_FRAME0
		#Desenha_Imagem(s4, s5, 0x12C00)
	
	# Toca musica : Uma nota por vez atraves do macete da funcao TIME()
		####
	j LOOP				# Retorna para o Game Loop
	System(10) 			# Encerra o SO

.include ".\macros\SYSTEMv24.s"
