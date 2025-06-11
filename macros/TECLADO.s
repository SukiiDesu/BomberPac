# Macro para ler em pooling uma tecla pressionada
# Recebe o registrador em que o valor da tecla serah armazenada como argumento
.macro Le_Tecla_Non_Blocking(%reg1)
	li t1,ENDERECO_CONTROLE_TECLADO		# t0 = Endereco de Controle do KDMMIO
	lw t0,0(t1)				# Pega o Conteudo do Endereco de Controle do KDMMIO
	andi t0,t0,1				# Verifica se o ultimo bit de t0 == 1
	beqz t0,FIM_ZERO			# Se ultimo bit de t0 == 1: Tecla nova foi lida -> Guarda e ecoa tecla; 0 : Nao foi lida nenhuma tecla->Encerra
	lw t0,4(t1)				# Pegue o conteudo da nova tecla lida
	mv %reg1,t0				# Salva o conteudo de t0 no registrador passado como argumento
	sw t0,12(t1)				# Ecoa a tecla lida no display do KDMMIO
	j FIM					# Sai da funcao com retorno diferente de 0
FIM_ZERO:
	li %reg1,0				# Como nenhum caractere foi lido, "retorne 0" : "Nao faca nada"
FIM:						# Sai da funcao
.end_macro 
