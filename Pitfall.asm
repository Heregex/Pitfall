.text
.main:
	lui $s0, 0x1001           # início do endereço de memória
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
	
	addi $2, $zero, 10 # >>> ENDPROGRAM <<<
	syscall
	
	gerarCenario:
		
		for_gC: beq $t0, $a1, EXIT_gerarCenario
		
			sw $t1, 0($s0)

			addi $t0, $t0, 1 # incremento
			addi $s0, $s0, 4
			
			j for_gC
			
		EXIT_gerarCenario: jr $31
