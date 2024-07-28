.text
.main:
	lui $s0, 0x1001           # início do endereço de memória
	add $t0, $zero, $zero     # iterador gerarCopa
	
	addi $t1, $zero, 0x345C1C # cor da Copa
	jal gerarCopa
	addi $t1, $zero, 0x6C9850 # cor da Floresta
	jal gerarFloresta
	addi $t1, $zero, 0xB8B840 # cor da Faixa de Terra 1
	jal gerarFaixaTerra_1
	addi $t1, $zero, 0x848424 # cor da Faixa de Terra 2
	jal gerarFaixaTerra_2
	
	addi $2, $zero, 10 # >>> ENDPROGRAM <<<
	syscall
	
	gerarCopa: 
		
		for_gC: beq $t0, 96, EXIT_gerarCopa # para de pintar na 95º UG (última da 3ª linha)
		
			sw $t1, 0($s0)

			addi $t0, $t0, 1 # incremento
			addi $s0, $s0, 4
			
			j for_gC
			
		EXIT_gerarCopa: jr $31
		
	gerarFloresta: 
	
		for_gF: beq $t0, 256, EXIT_gerarFloresta # para de pintar na 255º UG (última da 8ª linha)

			sw $t1, 0($s0)
			
			addi $t0, $t0, 1 # incremento
			addi $s0, $s0, 4
			
			j for_gF
			
		EXIT_gerarFloresta: jr $31
		
	gerarFaixaTerra_1:
	
		for_gFT_1: beq $t0, 320, EXIT_gerarFaixaTerra_1 # para de pintar na 320º UG (última da 10ª linha)
		
			sw $t1, 0($s0)
			
			addi $t0, $t0, 1 # incremento
			addi $s0, $s0, 4
			
			j for_gFT_1
			
		EXIT_gerarFaixaTerra_1: jr $31
		
	gerarFaixaTerra_2:
	
		for_gFT_2: beq $t0, 384, EXIT_gerarFaixaTerra_2 # para de pintar na 383º UG (última da 12ª linha)
		
			sw $t1, 0($s0)
			
			addi $t0, $t0, 1 # incremento
			addi $s0, $s0, 4
			
			j for_gFT_2
			
		EXIT_gerarFaixaTerra_2: jr $31
