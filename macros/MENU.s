######################################################################################################################################################
##################################################                  MENU                     #########################################################
######################################################################################################################################################

#---------------------------------------------------------#
#          Consideracaoes para Preenche_Menu              |
#---------------------------------------------------------#
	## LOOP funciona na mesma logica de C. A verificacao do encerramento do loop so ocorre em Inicio: LOOP ##
	## "MENU_BASE" eh a imagem do Menu em modo de nao-selecao; ela esta no arquivo "menu.data"  ##

####################################################################################
################### Renderiza Menu #################################################
####################################################################################
#Inicio: Funcao Preenche_Menu
#	R0{} = POSICAO_INICIAL_MENU_BASE		## R0{} sera a posicao atual em "menu.data" ##
#	S0{} = POSICAO_INICIAL_FRAME			## S0{} sera a posicao atual no Frame ##
#	S1{} = FLAG					## S1{} sera a condicao de parada do loop ##
#	Inicio: LOOP_Percorre_Frame:
#		0(R0) = 0(S0)		# Quatros pixels do Frame recebem as cores dos correspondentes 4 pixels de MENU_BASE
#		0(S0) += 4		# Pule 4 pixels no Frame
#		0(S0) += 4		# Pule 4 pixels em MENU_BASE
#	Fim: LOOP_Percorre_Frame:
#Fim: Funcao Preenche_Menu

#---------------------------------------------------------#
#          Consideracaoes para Preenche_Botao             |
#---------------------------------------------------------#
	## LOOP funciona na mesma logica de C. A verificacao do encerramento do loop so ocorre em Inicio: LOOP ##
	## "MENU_BASE" eh a imagem do Menu em modo de nao-selecao; ela esta no arquivo "menu.data"  ##
	## Tilemap eh a matriz do "mapa.data" ##
	## "Proxima posicao no Tilemap" eh dada pela Funcao: Proxima_Posicao_Tilemap ##
	## "Proxima posicao no Frame" eh dada pela Funcao: Proxima_Posicao_Frame ##

####################################################################################
################### Renderiza Botao ################################################
####################################################################################
#Inicio: Funcao Preenche_Botao
#	R0{} = POSICAO_INICIAL_MENU_BASE		## R0{} sera a posicao atual em "menu.data" ##
#	S0{} = POSICAO_INICIAL_FRAME			## S0{} sera a posicao atual no Frame ##
#	S1{} = FLAG					## S1{} sera a condicao de parada do loop ##
#	Inicio: LOOP_Percorre_Frame:
#		0(R0) = 0(S0)		# Quatros pixels do Frame recebem as cores dos correspondentes 4 pixels de MENU_BASE
#		0(S0) += 4		# Pule 4 pixels no Frame
#		0(S0) += 4		# Pule 4 pixels em MENU_BASE
#	Fim: LOOP_Percorre_Frame:
#Fim: Funcao Preenche_Menu