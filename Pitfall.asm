.text
.main:
	lui $s0, 0x1001           # início do endereço de memória
	addi $s1, $zero, 128      # L: quantidade de UG na linha
	
	add $t0, $zero, $zero     # iterador
	
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
	lui $s0, 0x1001           # início do endereço de memória
	addi $a2, $zero, 33       # l: linha
	addi $a1, $zero, 52	  # c: coluna
	addi $t1, $zero, 0x386890 # cor do Lago
	jal gerarLago

	# __________ PERSONAGEM __________ #		
	lui $s0, 0x1001	    # início do endereço de memória
	addi $a2, $zero, 24 # l: linha
	addi $a1, $zero, 8  # c: coluna
	jal gerarPersonagem
	
	# __________ >>> ENDPROGRAM <<< __________ #
	addi $2, $zero, 10
	syscall
	
	gerarCenario:
		
		for_gC: beq $t0, $a1, EXIT_gerarCenario
			
			sw $t1, 0($s0)

			addi $t0, $t0, 1 # incremento
			addi $s0, $s0, 4
			
			j for_gC
			
		gerarTronco:
			add $t0, $zero, $zero # reseta iterador
				
			# &pX = &p0 + (l * L + c) * 4
			mul $t6, $a2, $s1
			add $t6, $t6, $a1
			sll $t6, $t6, 2
			add $t6, $t6, $s0
			
			for_gT: beq $t0, 20, EXIT_gerarCenario # pinta 20 UG de Tronco
				# espessura do tronco: 4 UG
				sw $t1, 0($t6)
				sw $t1, 4($t6)
				sw $t1, 8($t6)
				sw $t1, 12($t6)
			
				addi $t0, $t0, 1 # incremento
				addi $t6, $t6, 512
				
				j for_gT
			
	EXIT_gerarCenario: jr $31

	gerarLago:
		# CHECKPOINT!
		
		
	EXIT_gerarLago: jr $31

	gerarPersonagem:
		
		add $t6, $zero, $zero # reseta $t6
		
		# &pX = &p0 + (l * L + c) * 4
		mul $t6, $a2, $s1
		add $t6, $t6, $a1
		sll $t6, $t6, 2
		add $t6, $t6, $s0
		
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
		
	EXIT_gerarPersonagem: jr $31
