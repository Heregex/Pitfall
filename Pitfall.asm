.text
.main:
	lui $s0, 0x1001       # início do endereço de memória
	addi $s1, $zero, 128  # L: quantidade de UG na linha
	
	add $t0, $zero, $zero # iterador global
	
	# __________ CENÁRIO __________ #
	addi $t1, $zero, 0x345C1C # cor da Copa
	addi $a1, $zero, 1536     # UG limite
	jal gerarCenario
	addi $t1, $zero, 0x6C9850 # cor da Floresta
	addi $a1, $zero, 4096     # UG limite
	jal gerarCenario
	addi $t1, $zero, 0xB8B840 # cor da Faixa de Terra 1
	addi $a1, $zero, 5120     # UG limite
	jal gerarCenario
	addi $t1, $zero, 0x848424 # cor da Faixa de Terra 2
	addi $a1, $zero, 6144     # UG limite
	jal gerarCenario
	
	# __________ TRONCOS __________ #
	lui $s0, 0x1001           # início do endereço de memória
	addi $a2, $zero, 12       # l: linha
	addi $t1, $zero, 0x444400 # cor do Tronco
	
	addi $a1, $zero, 24  # c: coluna
	jal gerarTronco
	addi $a1, $zero, 44  # c: coluna
	jal gerarTronco
	addi $a1, $zero, 80  # c: coluna
	jal gerarTronco
	addi $a1, $zero, 100 # c: coluna
	jal gerarTronco

	# __________ LAGO __________ #
	addi $t1, $zero, 0x386890 # cor do Lago
	addi $a1, $zero, 52	  # c: coluna
	addi $a2, $zero, 33       # l: linha
	addi $a3, $zero, 24	  # Quantidade de UG do lago na linha
	jal gerarLago
	addi $a1, $zero, 48	  # c: coluna
	addi $a2, $zero, 34       # l: linha
	addi $a3, $zero, 32	  # Quantidade de UG do lago na linha
	jal gerarLago
	addi $a1, $zero, 44	  # c: coluna
	addi $a2, $zero, 35       # l: linha
	addi $a3, $zero, 40	  # Quantidade de UG do lago na linha
	jal gerarLago
	addi $a1, $zero, 44	  # c: coluna
	addi $a2, $zero, 36       # l: linha
	addi $a3, $zero, 40	  # Quantidade de UG do lago na linha
	jal gerarLago
	addi $a1, $zero, 48	  # c: coluna
	addi $a2, $zero, 37       # l: linha
	addi $a3, $zero, 32	  # Quantidade de UG do lago na linha
	jal gerarLago
	addi $t1, $zero, 0x386890 # cor do Lago
	addi $a1, $zero, 52	  # c: coluna
	addi $a2, $zero, 38       # l: linha
	addi $a3, $zero, 24	  # Quantidade de UG do lago na linha
	jal gerarLago
	
	# __________ CROCODILO __________ #
	addi $t1, $zero, 0x143800 # cor do Crocodilo
	addi $a1, $zero, 66 	  # c: coluna
	addi $a2, $zero, 34	  # l: linha
	jal gerarCrocodilo
	
	# __________ ESCORPIÃO __________ #
	#addi $t1, $zero, 0xF4F4F4 # cor do Escorpião
	#addi $a1, $zero, 11       # c: coluna
	#addi $a2, $zero, 55	  # l: linha
	#jal gerarEscorpiao
	
	# __________ PERSONAGEM __________ #
	addi $a1, $zero, 8  # c: coluna
	addi $a2, $zero, 24 # l: linha
	jal gerarPersonagem
	
	# CHECKPOINT {
	addi $t4, $zero, 11 # reseta iterador
	addi $t2, $zero, 19   # c: coluna
	addi $t3, $zero, 55   # l: linha
	
	addi $t1, $zero, 0xFF0000 # cor do Escorpião
	add $a1, $zero, $t2       # c: coluna
	add $a2, $zero, $t3	  # l: linha
	
	EXIT_for2: addi $t4, $zero, 11 # reseta iterador
	
	for:
		beq $t4, 100, EXIT_for
		
		addi $t1, $zero, 0x000000 # cor do Escorpião
		jal moveRIGHT_delete
		
		addi $a1, $a1, 1 # incrementa c: coluna
		
		addi $t1, $zero, 0xF4F4F4 # cor do Escorpião
		jal moveRIGHT
		
		addi $4, $zero, 50
		addi $2, $zero, 32 # delay
		syscall
		
		addi $t4, $t4, 1 # incremento iterador
		j for
	
	EXIT_for: addi $t4, $zero, 11 # reseta iterador
	
	for2:

		beq $t4, 100, EXIT_for2
		
		addi $t1, $zero, 0x000000 # cor do Escorpião
		jal moveRIGHT_delete
		
		addi $a1, $a1, -1 # incrementa c: coluna
		
		addi $t1, $zero, 0xF4F4F4 # cor do Escorpião
		jal moveRIGHT
		
		addi $4, $zero, 50
		addi $2, $zero, 32 # delay
		syscall
		
		addi $t4, $t4, 1 # incremento iterador
		j for2
	# }
	
	# __________ >>> ENDPROGRAM <<< __________ #
	addi $2, $zero, 10
	syscall
	
	# __________ CALCULAR ENDEREÇO PONTO X __________ #
	calc_endereco_pX: # &pX = &p0 + (l * L + c) * 4
		mul $t6, $a2, $s1
		add $t6, $t6, $a1
		sll $t6, $t6, 2
		add $t6, $t6, $s0
		
		jr $31
	
	gerarCenario:
		
		for_gC: beq $t0, $a1, EXIT_gerarCenario
			
			sw $t1, 0($s0)

			addi $t0, $t0, 1 # incremento
			addi $s0, $s0, 4
			
			j for_gC
			
	EXIT_gerarCenario: jr $31

	gerarTronco:
			add $t0, $zero, $zero # reseta iterador
			
			add $s7, $zero, $31   # backup JAL
			jal calc_endereco_pX
			
			for_gT: beq $t0, 20, EXIT_gerarTronco # pinta 20 UG de Tronco
				# espessura do tronco: 4 UG
				sw $t1, 0($t6)
				sw $t1, 4($t6)
				sw $t1, 8($t6)
				sw $t1, 12($t6)
			
				addi $t0, $t0, 1 # incremento
				addi $t6, $t6, 512
				
				j for_gT
				
	EXIT_gerarTronco: add $31, $zero, $s7 # restaura backup JAL
			  jr $31

	gerarLago:
		
		add $t0, $zero, $zero # reseta iterador

		add $s7, $zero, $31   # backup JAL
		jal calc_endereco_pX
		
		for_gL: beq $t0, $a3, EXIT_gerarLago
			
			sw $t1, 0($t6)
			
			addi $t6, $t6, 4
			addi $t0, $t0, 1 # incremento
			j for_gL
		
	EXIT_gerarLago: add $31, $zero, $s7 # restaura backup JAL
			jr $31

	gerarCrocodilo:
		add $t0, $zero, $zero # reseta iterador
		
		add $s7, $zero, $31 # backup JAL
		jal calc_endereco_pX
		add $31, $zero, $s7 # restaura backup JAL
		
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		addi $t6, $t6, 480
		
		add $s7, $zero, $31 # backup JAL
		jal for_gCrc
		add $31, $zero, $s7 # restaura backup JAL
		
		addi $t6 $t6, 468
		sw $t1, 0($t6)
		sw $t1, 8($t6)
		sw $t1, 16($t6)
		sw $t1, 24($t6)
		sw $t1, 36($t6)
		sw $t1, 40($t6)
		
		add $t0, $zero, $zero # reseta iterador
		
		addi $t6, $t6, 508
		
		add $s7, $zero, $31 # backup JAL
		jal for_gCrc
		add $31, $zero, $s7 # restaura backup JAL
		
		j EXIT_gerarCrocodilo
		
		for_gCrc: beq $t0, 12, EXIT_forCrc
		
			sw $t1, 0($t6)
			addi $t6, $t6, 4
		
			addi $t0, $t0, 1 # incremento
			j for_gCrc
		
		EXIT_forCrc: jr $31
	
	EXIT_gerarCrocodilo: jr $31

	gerarEscorpiao:
	
		add $t0, $zero, $zero # reseta iterador
				
		add $s7, $zero, $31   # backup JAL
		jal calc_endereco_pX
		
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		sw $t1, 8($t6)
		addi $t6, $t6, 508
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		sw $t1, 12($t6)
		sw $t1, 16($t6)
		sw $t1, 20($t6)
		addi $t6, $t6, 512
		sw $t1, 0($t6)
		sw $t1, 20($t6)
		addi $t6, $t6, 504
		sw $t1, 0($t6)
		sw $t1, 12($t6)
		sw $t1, 28($t6)
		addi $t6, $t6, 512
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		sw $t1, 24($t6)
		sw $t1, 28($t6)
		addi $t6, $t6, 520
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		sw $t1, 8($t6)
		sw $t1, 12($t6)
		sw $t1, 16($t6)
		addi $t6, $t6, 500
		sw $t1, 0($t6)
		sw $t1, 8($t6)
		sw $t1, 12($t6)
		sw $t1, 16($t6)
		sw $t1, 20($t6)
		sw $t1, 24($t6)
		addi $t6, $t6, 516
		sw $t1, 0($t6)
		sw $t1, 12($t6)
		sw $t1, 16($t6)
		sw $t1, 20($t6)
		addi $t6, $t6, 508
		sw $t1, 0($t6)
		sw $t1, 8($t6)
		sw $t1, 32($t6)
		
	EXIT_gerarEscorpiao: add $31, $zero, $s7 # restaura backup JAL
			     jr $31

	gerarPersonagem:
		
		add $t6, $zero, $zero # reseta $t6
		
		add $s7, $zero, $31   # backup JAL
		jal calc_endereco_pX
		
		HAIR:
			addi $t1, $zero, 0x646410 # cor do Cabelo
			sw $t1, 0($t6)
			sw $t1, 4($t6)
			sw $t1, 8($t6)
		HEAD:
			addi $t1, $zero, 0xE4706F # cor da Cabeça
			add $t0, $zero, $zero     # reseta iterador
			
			for_HEAD: beq $t0, 2, EXIT_for_HEAD
				  
				  addi $t6, $t6, 512
				  sw $t1, 0($t6)
				  sw $t1, 4($t6)
				  sw $t1, 8($t6)
				  
				  addi $t0, $t0, 1 # incremento
				  j for_HEAD
				  
			EXIT_for_HEAD: 
				# Pescoço
				addi $t6, $t6, 512
				sw $t1, 0($t6)
				
		SHIRT:
			addi $t1, $zero, 0x5BBB5C # cor da Camisa
			add $t0, $zero, $zero     # reseta iterador
			
			for_SHIRT: beq $t0, 5, PANTS
				   
				   addi $t6, $t6, 512
				   sw $t1, 0($t6)
				   sw $t1, 4($t6)
				   sw $t1, 8($t6)
				   
				   addi $t0, $t0, 1 # incremento
				   j for_SHIRT
			
		PANTS:
			addi $t1, $zero, 0x356018 # cor da Calça
			add $t0, $zero, $zero     # reseta iterador
			
			for_PANTS: beq $t0, 5, EXIT_for_PANTS
				
				   addi $t6, $t6, 512
				   sw $t1, 0($t6)
				   sw $t1, 4($t6)
				   sw $t1, 8($t6)
				
				   addi $t0, $t0, 1 # incremento
				   j for_PANTS
				
			EXIT_for_PANTS:
				# Pé esquerdo
				sw $t1, 12($t6)
				# Pé direito
				addi $t6, $t6, 512
				sw $t1, 0($t6)
				addi $t6, $t6, 512
				sw $t1, 0($t6)
				sw $t1, 4($t6)
				sw $t1, 8($t6)
		
	EXIT_gerarPersonagem: add $31, $zero, $s7 # restaura backup JAL
			      jr $31

	moveRIGHT:
				
		add $s7, $zero, $31   # backup JAL
		jal calc_endereco_pX
		
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		sw $t1, 8($t6)
		addi $t6, $t6, 508
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		sw $t1, 12($t6)
		sw $t1, 16($t6)
		sw $t1, 20($t6)
		addi $t6, $t6, 512
		sw $t1, 0($t6)
		sw $t1, 20($t6)
		addi $t6, $t6, 504
		sw $t1, 0($t6)
		sw $t1, 12($t6)
		sw $t1, 28($t6)
		addi $t6, $t6, 512
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		sw $t1, 24($t6)
		sw $t1, 28($t6)
		addi $t6, $t6, 520
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		sw $t1, 8($t6)
		sw $t1, 12($t6)
		sw $t1, 16($t6)
		addi $t6, $t6, 500
		sw $t1, 0($t6)
		sw $t1, 8($t6)
		sw $t1, 12($t6)
		sw $t1, 16($t6)
		sw $t1, 20($t6)
		sw $t1, 24($t6)
		addi $t6, $t6, 516
		sw $t1, 0($t6)
		sw $t1, 12($t6)
		sw $t1, 16($t6)
		sw $t1, 20($t6)
		addi $t6, $t6, 508
		sw $t1, 0($t6)
		sw $t1, 8($t6)
		sw $t1, 32($t6)
		
	EXIT_moveRIGHT: add $31, $zero, $s7 # restaura backup JAL
			jr $31
			
	moveRIGHT_delete:
	
		add $s7, $zero, $31   # backup JAL
		jal calc_endereco_pX
		
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		sw $t1, 8($t6)
		addi $t6, $t6, 508
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		sw $t1, 12($t6)
		sw $t1, 16($t6)
		sw $t1, 20($t6)
		addi $t6, $t6, 512
		sw $t1, 0($t6)
		sw $t1, 20($t6)
		addi $t6, $t6, 504
		sw $t1, 0($t6)
		sw $t1, 12($t6)
		sw $t1, 28($t6)
		addi $t6, $t6, 512
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		sw $t1, 24($t6)
		sw $t1, 28($t6)
		addi $t6, $t6, 520
		sw $t1, 0($t6)
		sw $t1, 4($t6)
		sw $t1, 8($t6)
		sw $t1, 12($t6)
		sw $t1, 16($t6)
		addi $t6, $t6, 500
		sw $t1, 0($t6)
		sw $t1, 8($t6)
		sw $t1, 12($t6)
		sw $t1, 16($t6)
		sw $t1, 20($t6)
		sw $t1, 24($t6)
		addi $t6, $t6, 516
		sw $t1, 0($t6)
		sw $t1, 12($t6)
		sw $t1, 16($t6)
		sw $t1, 20($t6)
		addi $t6, $t6, 508
		sw $t1, 0($t6)
		sw $t1, 8($t6)
		sw $t1, 32($t6)
	
	EXIT_moveRIGHT_delete: add $31, $zero, $s7 # restaura backup JAL
			       jr $31
