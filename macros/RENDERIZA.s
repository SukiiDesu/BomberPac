########################################################
#                     MACROS
########################################################
#.macro Desenha_imagem(%reg)
	###############
#.end_macro


########################################################
#                     MAIN
########################################################
.data

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

.text
		# Como que "acompanha" qual etapa da animacao deve ser renderizada ???????? Deve ser feito em ATUALIZA_FRAME????
		# "Conferir passagem dos registradores"
		# Para todas as imagens necessarias:
			# Carrega endereco da imagem em um registrador
			# Desenha_imagem(%reg) # Chama Desenha_imagem com o registrador que guarda o endereco correto para desenho do objeto
