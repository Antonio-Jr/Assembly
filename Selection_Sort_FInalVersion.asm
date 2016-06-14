 # 							Universidade Federal de Mato Grosso do Sul				    			                            
 #							     FACOM - Faculdade de Computa��o								                            
 # Disciplina: Arquitetura de Computadores I														                            
 # Professor: Renan Albuquerque Marks															                            
 #																			                            
 # Alunos: Antonio Junior Souza Silva, Bruno Akiyama													                            
 # 																			                            
 # Descri��o: Implementa��o do algoritmo de ordena��o Selection Sort em linguagem MIPS Assembly								                            
 # 1 int i,j;																					    
 # 2 for (j = 0; j < n-1; j++) {																		    
 # 3     int iMin = j;																				    
 # 4     for ( i = j+1; i < n; i++) {																		    
 # 5         if (v[i] < v[iMin]) {																		    
 # 6             iMin = i;																			    
 # 7         }																					    
 # 8     }																					    
 # 9     if(iMin != j) {																			    
 # 10        swap(v[j], v[iMin]);																		    
 # 11 }																						    
 #																						    
 # O objetivo do Selection Sort � selecionar o menor valor do vetor e colocar na primeira posi��o, ent�o diminuir o vetor. Repetindo esse processo at� que o vetor esteja ordenado. 
 #  	Este algoritmo acima � o Selection Sort na linguagem C e explicaremos linha por linha o funcionamento deste algoritmo.							    
 # 																						    
 # Linha 1: Cria��o das vari�veis i e j.																	    
 #																						    
 # Linha 2: Neste loop, far� a compara��o j <n-1, n vezes onde entrar� no for n-1 vezes e ser� em j que ser� armazenado o menor valor do vetor. ordenando do menor para o maior     
 #																						    
 # Linha 3: Nesta linha assumiremos que o menor valor esteja na primeira posi��o do atual vetor j, para depois compar�-lo com as pr�ximas posi��es do vetor.			    
 #																						    
 # Linha 4: Est� linha inicia outro for dentro do for da linha 2 e ser� neste loop que o algoritmo ir� buscar o menor valor do vetor.						    
 #																						    
 # Linha 5: Nesta linha ser� comparado o menor valor atual(que inicia com o valor de j) com o atual valor do vetor na posi��o i.						    
 # 																						    
 # Linha 6: Caso o valor do vetor na posi��o i seja menor que o valor na posi��o iMin(menor valor atual), ent�o iMin receber� o valor de i.					    
 #																						    
 # Linha 8: Termina o segundo for.																		    
 #
 # Linha 9: Est� compara��o foi feita para evitar trocas desnecess�rias caso o menor valor esteja na posi��o j.									    
 #
 # Linha 10: Caso iMin seja diferente de j, ent�o troca o valor da posi��o iMin pelo valor da posi��o j.									    
 # 
 # Linha 11: Termina o primeiro for, assim repetindo o loop at� j = n-1.													    
 # 
 # Registradores usados para ordena��o:
 # $t0 = n (vetor.length)
 # $t1 = posi��o inicial do vetor
 # $t2 = contador j
 # $t3 = n-1 (vetor.length - 1)
 # $t4 = iMin
 # $t5 = contador i
 # $t6 = v[i]
 # $t7 = v[iMin]
 # $s0 e $s1 ser�o usados para marcar a posi��o de v[i] e v[iMin]
 #---------------------------------------------------------------------------------------------------------------------------------------------------

		.data
		
V: 		.word 22,3,9,19,16,5,12,6,15,2,7,1
Length: 	.word 12
msg1:	 	.asciiz "O vetor inicial �: "
msg2:		.asciiz "\n\nO vetor ordenado �: "
virgula:	.asciiz ", "
Pulalinha:	.asciiz "\n"
		
		.text

#------------------------------
_start:
		lw $t0, Length			# Registrador $t0 recebe tamanho do vetor. $t0 = n 
		la $t1, V			# Registrador $t1 recebe endere�o de v[0]
		addi $v0, $zero, 4		# Especificando o servi�o de impress�o de string, c�digo 4
		la $a0, msg1			# Carregando para o registrador a0 o endere�o da mensagem 1
		syscall				# Chamada do sistema para impress�o da mensagem
		jal print			# Chamada da fun��o print, para imprimir os numeros do vetor desordenado na tela		
		add $t2, $zero, $zero		# j = 0
		subi $t3, $t0, 1		# n = n-1
#-----------------------------------
#Iniciando Ordena��o

for_Min:	
		beq $t2,$t3, fim_Min		# Se j >= n-1, ent�o termina o forj
		add $t4, $t2, $zero		# iMin = j
		addi $t5, $t2, 1		# i = j + 1
#-----------------------------------

for_Interno:	
		beq $t5, $t0, fim_Interno	# Se i >= n, ent�o termina fori
		sll $s0, $t5, 2			# $s0 = i*4
		sll $s1, $t4, 2			# $s1 = iMin*4
		add $s0, $s0, $t1		# Adiciona a posi��o de v[0] + i*4
		add $s1, $s1, $t1		# Adiciona a posi��o de v[0] + iMin*4
		lw $t6, ($s0)			# $t6 = v[i]
		lw $t7, ($s1)			# $t7 = v[iMin]
		bge $t6, $t7, else		# Se v[i]>=v[iMin], ent�o volta para fori
		add $t4, $t5, $zero		# iMin = i
#-----------------------------------	

else:	
		addi $t5, $t5, 1		# i = i + 1
		j for_Interno			# Jump para for_Interno
#-----------------------------------

fim_Interno:	
		beq $t4, $t2, else1
		sll $s0, $t2, 2			# Registrador $s0 = j*4
		sll $s1, $t4, 2			# Registrador $s1 = iMin*4
		add $s0, $s0, $t1		# Adiciona a $s0 a posi��o de v[0] + j*4
		add $s1, $s1, $t1		# Adiciona a $s1 a posi��o de v[0] + iMin*4
		lw $t6, ($s0)			# $t6 = v[j]
		lw $t7, ($s1)			# $t7 = v[iMin]
		sw $t6, ($s1)			# v[iMin]= $t6 (valor na posi��o v[j])
		sw $t7, ($s0)			# v[j] = $t7 (valor na posi��o v[iMin])
#-----------------------------------	

else1:	
		addi $t2, $t2, 1		# j = j + 1
		j for_Min			# jump para for_Min
#----------------------------------

fim_Min:	
		add $t2, $zero, $zero 		# j = 0
		addi $v0, $zero, 4		# Especificando servi�o de impressao de string
		la $a0, msg2			# Carregando para o registrador a0 o endere�o da mensagem 2
		syscall				# Chamada do sistema e impress�o da mensagem na tela
		jal print			# Chamando a fun��o de impress�o dos numeros do vetor
		addi $v0,$zero, 4		# Codigo de impress�o de uma linha
		la $a0, Pulalinha		# Armazena o endere�o Pulalinha para imprimi-lo
		syscall				# Pula a linha ap�s o fim da impress�o
		addi $v0,$zero, 10		# especificando encerramento do programa, codigo 10
		syscall				# Fim do c�digo
#----------------------------------


# Fun��o para Imprimir os n�meros contidos no vetor.	
print:
		beq $t2, $t0, fim_Print		# Se j >= n, ent�o pula para fimprint
		sll $s0, $t2, 2			# $s0 = j*4
		add $s0, $s0, $t1		# Adiciona a posi��o de v[0] + j*4
		lw $t6, ($s0)			# $t6 = v[j]
		addi $v0, $zero, 1		# Especificando servi�o de impress�o de inteiros, c�digo 1
		add $a0, $t6, $zero		# Adicionando no registrador a0 o valor contido no registrador t6 para imprim�-lo
		syscall				# Chamada do sistema e impress�o da mensagem
		addi $v0, $zero, 4		# Especificando servi�o de impress�o de string, codigo 4
		la $a0, virgula			# Carregando para registrador $a0 o endere�o da mensagem 'virgula'
		syscall				# Chamada do sistema para impress�o da mensagem
		addi $t2, $t2, 1		# j = j + 1
		j print				# Jump para print
#-----------------------------------
fim_Print:
		jr $ra				# Retornando ao endere�o de chamada da fun��o
					
	
