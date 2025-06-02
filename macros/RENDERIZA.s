########################################################
#                     MACROS
########################################################
	# Como que "acompanha" qual etapa da animacao deve ser renderizada ???????? Deve ser feito em ATUALIZA_FRAME????
	# "Conferir passagem dos registradores"
	# Para todas as imagens necessarias:
		# Carrega endereco da imagem em um registrador
		# Desenha_imagem(%reg) # Chama Desenha_imagem com o registrador que guarda o endereco correto para desenho do objeto

# Recebe registrador com endereco do primeiro pixel do frame a ser preenchido : %reg1
# Recebe registrador com endereco da imagem a ser copiada : %reg2
# Recebe (valor total de pixels + 4) da imagem a ser copiada ["Considere como o primeiro pixel apos a coluna da ultima linha"]
# Infelizmente parece que não é possível generalizar a funcao para o endereco de imagem, sem usar outro registrador
.macro Desenha_Imagem(%reg1, %reg2, %op)
.text
	li t1,%op			# Pegue o total de pixels na matriz a ser desenhada
	add t1,%reg1,t1			# Guarde em t1 no endereco de "fim da matriz"
LOOP1:	beq %reg1,t1,FIM_PINTURA	# Enquanto a matriz nao estiver preenchida
	sw %reg2,0(%reg1)		# Printe as cores dos proximos 4 pixels da imagem nos respectivos pixels do frame 
	addi %reg1,%reg1,4		# Selecione os proximos 4 pixels do frame
	#addi %reg2,%reg2,4		# Selecione os proximos 4 pixels da imagem
	j LOOP1				# Volte ao loop	

FIM_PINTURA:
.end_macro


########################################################
#               INCLUDES (Gera erro???)
########################################################

# Os includes devem vir em cima ou embaixo????
# Na duvida entre imagem fundo ou apenas bordas_e_bloco.data : (Preenche tudo de verde primeiro e sobrepoe tipo um png : Funciona assim????)
#.include imagemFundo.data # ou #.include blocos_e_borda.data

# Personagem
	#IDLE????

	# Movimento para direita   	# Animacoes sao passadas assim????
	#.include andaDireitaFrame0.data
	#...
	#.include andaDireitaFrameN.data

	# Movimento para esquerda
	#.include ..\imagens\personagemEsquerdaFrame0.data"
	#...
	#.include ..\imagens\personagemEsquerdaFrameN.data"

	# Movimento para cima
	#.include ..\imagens\personagemCimaFrame0.data"
	#...
	#.include ..\imagens\personagemFCimarameN.data"

	# Movimento para baixo
	#.include ..\imagens\personagemBaixoFrame0.data"
	#...
	#.include ..\imagens\personagemBaixoFrameN.data"

	# Morte
	#.include ..\imagens\personagemMorteFrame0.data"
	#...
	#.include ..\imagens\personagemMorteFrameN.data"

# Mob
	# Movimento para direita
	#.include ..\imagens\mobDireitaFrame0.data"
	#...
	#.include ..\imagens\mobDireitaFrameN.data"

	# Movimento para esquerda
	#.include ..\imagens\mobEsquerdaFrame0.data"
	#...
	#.include ..\imagens\mobEsquerdaFrameN.data"

	# Movimento para cima
	#.include ..\imagens\mobCimaFrame0.data"
	#...
	#.include ..\imagens\mobCimaFrameN.data"

	# Movimento para baixo
	#.include ..\imagens\mobBaixoFrame0.data"
	#...
	#.include ..\imagens\mobBaixoFrameN.data"

	# Morte
	#.include ..\imagens\mobMorteFrame0.data"
	#.include ..\imagens\mobMorteFrame1.data"
	#.include ..\imagens\mobMorteFrame2.data"
	#.include ..\imagens\mobMorteFrameN.data"

# Boss 	# Ou mob_2. Estah em debate
	# Movimento para direita
	#.include "..\imagens\bossDireitaFrame0.data"
	#...
	#.include "..\imagens\bossDireitaFrameN.data"

	# Movimento para esquerda
	#.include "..\imagens\bossEsquerdaFrame0.data"
	#...
	#.include "..\imagens\bossEsquerdaFrameN.data"

	# Movimento para cima
	#.include "\..\imagens\bossCimaFrame0.data"
	#...
	#.include "\..\imagens\bossCimaFrameN.data"

	# Movimento para baixo
	#.include "\..\imagens\bossBaixoFrame0.data"
	#.include "\..\imagens\bossBaixoFrame1.data"
	#.include "\..\imagens\bossBaixoFrame2.data"
	#.include "\..\imagens\bossBaixoFrameN.data"

	# Morte
	#.include ..\imagens\bossMorteFrame0.data"
	#.include ..\imagens\bossMorteFrame1.data"
	#.include ..\imagens\bossMorteFrame2.data"
	#.include ..\imagens\bossMorteFrameN.data"

# Bomba
	# IDLE
	#.include "\..\imagens\bombaFrame0.data"
	#.include "\..\imagens\bombaFrame1.data"
	#.include "\..\imagens\bombaFrame2.data"
	#.include "\..\imagens\bombaFrameN.data"

	# Explosao
		#.include "..\imagens\explosaoFrame0.data"
		#.include "..\imagens\explosaoFrame1.data"
		#.include "..\imagens\explosaoFrame2.data"
		#.include "..\imagens\explosaoFrameN.data"

# Power Ups
	#.include "..\imagens\powerUp1.data"
	#...
	#.include "..\imagens\powerUpN.data"

# Armadilhas
	#.include "..\imagens\armadilha1.data"
	#...
	#.include "..\imagens\armadilhaN.data"
