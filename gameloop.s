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

# Todos os frames de uma animacao estão no mesmo arquivo ".data".

#.include ".\pilatra.data"		# Sprite pilastra
#.include ".\tijolo.data"		# Sprite tijolo
#.include ".\fundoComPonto.data"	# Sprite fundo com ponto

#.include "..\imagens\personagemDireita.data"		# Movimento do personagem para a direita
#.include "..\imagens\personagemEsquerda.data"		# Movimento do personagem para a esquerda
#.include "..\imagens\personagemCima.data"		# Movimento do personagem para a cima
#.include "..\imagens\personagemBaixo.data"		# Movimento do personagem para a baixo
#.include "..\imagens\personagemDano.data"		# Quando o personagem toma dano -- Provavelvemente overkill
#.include "..\imagens\personagemMorte.data"		# Morte do personagem
#.include "..\imagens\personagemPowerUp.data"		# Animacao para power ativo : precisa ???

#.include "..\imagens\mobDireita.data"		# Movimento do mob para a direita
#.include "..\imagens\mobEsquerda.data"		# Movimento do mob para a esquerda
#.include "..\imagens\mobCima.data"		# Movimento do mob para a cima
#.include "..\imagens\mobBaixo.data"		# Movimento do mob para a baixo
#.include "..\imagens\mobMorte.data"		# Morte do mob

#.include "..\imagens\bossDireita.data"		# Movimento do boss para a direita
#.include "..\imagens\bossEsquerda.data"	# Movimento do boss para a esquerda
#.include "..\imagens\bossCima.data"		# Movimento do boss para a cima
#.include "..\imagens\bossBaixo.data"		# Movimento do boss para a baixo
#.include "..\imagens\bossMorte.data"		# Morte do boss

#.include "..\imagens\bombaIdle.data"		# Bomba idle
	
#.include "..\imagens\explosa.data"		# Animacao explosao

#.include "..\imagens\powerUp1.data"		# Sprite power Up 1
#.include "..\imagens\powerUpN.data"		# Sprite power Up N

#.include "..\imagens\armadilha1.data"		# Sprite armadilha 1
#.include "..\imagens\armadilhaN.data"		# Sprite armadilha N


########################################################
#                  MAIN (GAME LOOP)
########################################################
.data
	.eqv ENDERECO_CONTROLE_TECLADO 0xFF200000		# Endereco de Controle KDMMIO
	.eqv ENDERECO_TECLA_LIDA 0xFF200004			# Endereco de Armazenamento KDMMIO
	.eqv ENDERECO_DISPLAY_TECLADO 0xFF20000C		# Endereco de Echo KDMMIO
	.eqv ENDERECO_INICIAL_FRAME0 0xFF000000			# Endereco inicial : [0,0] do Frame 0
	.eqv ENDERECO_FIM_FRAME_0 0xFF012C00
	.eqv NUM_MAGICO_1 5440
	.eqv NUM_MAGICO_2 76160
	VERDE_WORD: .word 0x10101010
	VERDE_BYTE: .byte 0x10
	VERMELHO_WORD: .word 0x07070707
	VERMELHO_BYTE: .byte 0x07
	
	#.eqv ENDERECO_INICIAL_FRAME1 0xFF100000		# Endereco inicial : [0,0] do Frame 1
	#.eqv DIRECAO s0	#Recebe WASD/SPACE BAR/P/L/M - P eh a cheat code para pular de nivel, L - limpa todos os blocos, M - mata os inimigos
	#.eqv SCORE s1
	.eqv TEMPO s2
	#.eqv VIDAS s3
	#.eqv INIMIGOS_VIVOS s4  	# Condicao de vitoria : saida do nivel
	.eqv ENDERECO_NOTA_ATUAL s5
	#.eqv CENTRO_PERSONAGEM s7	#Nesse endereco sera guardado o centro do personagem
	#.eqv CENTRO_MOB1 s8		#Nesse endereco sera guardado o centro do mob1
	#.eqv CENTRO_MOB2 s9		#Nesse endereco sera guardado o centro do mob2
	#.eqv CENTRO_BOSS s10		#Nesse endereco sera guardado o centro do boss

	.eqv ENDERECO_INICIAL_FRAME_0 0xFF000000
	
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
.include ".\macros\MUSICA.s"	

.text
MAIN:
#	Preenche_Menu				## Preenche Menu completamente uma unica vez. A logica estah incompleta, pois nao Menu nao eh Prioridade ##
#	Botao_Selecionado = Posicao_Start	## Botao_Selecionado eh um registrador qualquer; Posicao_Start eh um valor arbitrario na imagem do Menu ##
#LOOP_MENU:
#	Preenche_Botao(Botao_Selecionado)
#	T0{} = Le_Tecla_Non_Blocking		## Le uma tecla do teclado, se for pressionada ##
#	switch T0{}:				## Igual no C : Se T0{} == case, execute o codigo do case ##
#		case "ENTER":
#			j FIM_LOOP_MENU	
#		case "s":
#			Botao_Selecionado = Funcao: Seleciona_Botao
#		case n;
#			R1{} = POSICAO_INICIAL_SPRITE_n
#			Pula para funcao Renderiza_Matriz
#
#	j LOOP_MENU				## Retorne ao Loop do Menu ##
#FIM_LOOP_MENU:

#CONFIFURA:	# Seta Configuracoes a depender da Dificuldade / Fase	
			# Inicializa contadores
				####	
			# Inicializa enderecos iniciais
				####
			# Define imagens / Sprites / ...
				####
	
	Preenche_Frame		# Processo extremamente lento que gera conflitos quando dentro do loop
	Preenche_Campo
GAME_LOOP:	
	# Pegue Input : Tecla pressionada
		Le_Tecla_Non_Blocking(s0)	# Chama funcao de leitura do KDMMIO e guarda a reposta, se houver, em s0
		#Escreva_ASCII_no_Console(s0) 	# Escreve um valor ASCII no console. Caso s0==0 nao escreve nada
	
	#System(30)	# a0 = get_time()
	#mv s2,a0	# s2 = tempo_atual
	
	# Atualize o frame		# Alternar entre atualizar o 0 e o 1????
		####
	# Renderiza o que mudou
		####
	# Toca nota : Uma nota por vez atraves do macete da funcao TIME()
		#Toca_Musica(t1,t2,s5)
	
	#System(30)	# a0 = get_time()
	#mv s2,a0	# s2 = tempo_atual
	
	j GAME_LOOP				# Retorna para o Game Loop
	System(10) 			# Encerra o SO

.include ".\macros\SYSTEMv24.s"
