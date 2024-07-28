.text
.main:
	lui $s0, 0x1001           # início do endereço de memória
	addi $s1, $zero, 32       # L: quantidade de UG na linha
	
	add $t0, $zero, $zero     # iterador
	
	addi $t1, $zero, 0x345C1C # cor da Copa
	addi $a1, $zero, 96       # UG limite
	jal gerarCenario
	addi $t1, $zero, 0x6C9850 # cor da Floresta
	addi $a1, $zero, 256      # UG limite
	jal gerarCenario
	addi $t1, $zero, 0xB8B840 # cor da Faixa de Terra 1
	addi $a1, $zero, 320      # UG limite
	jal gerarCenario
	addi $t1, $zero, 0x848424 # cor da Faixa de Terra 2
	addi $a1, $zero, 384      # UG limite
	jal gerarCenario
	
	lui $s0, 0x1001           # início do endereço de memória
	addi $t2, $zero, 3        # l: linha
	addi $t1, $zero, 0x444400 # cor do Tronco
	
	addi $a1, $zero, 6  # c: coluna
	jal gerarTronco
	addi $a1, $zero, 13 # c: coluna
	jal gerarTronco
	addi $a1, $zero, 18 # c: coluna
	jal gerarTronco
	addi $a1, $zero, 25 # c: coluna
	jal gerarTronco
	
	addi $2, $zero, 10 # >>> ENDPROGRAM <<<
	syscall
	
	gerarCenario:
		
		for_gC: beq $t0, $a1, EXIT_gerarCenario
			
			sw $t1, 0($s0)

			addi $t0, $t0, 1 # incremento
			addi $s0, $s0, 4
			
			j for_gC
			
		gerarTronco:
			add $t5, $zero, $zero # iterador
				
			# &pX = &p0 + (l * L + c) * 4
			mul $t6, $t2, $s1
			add $t6, $t6, $a1
			sll $t6, $t6, 2
			add $t6, $t6, $s0
			
			for_gT: beq $t5, 5, EXIT_gerarCenario # pinta 5 UG de Tronco
				
				sw $t1, 0($t6)
			
				addi $t5, $t5, 1 # incremento
				addi $t6, $t6, 128
				
				j for_gT
			
		EXIT_gerarCenario: jr $31