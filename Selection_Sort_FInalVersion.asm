 # 							Universidade Federal de Mato Grosso do Sul				    			                            
 #							     FACOM - Faculdade de Computação								                            
 # Disciplina: Arquitetura de Computadores I														                            
 # Professor: Renan Albuquerque Marks															                            
 #																			                            
 # Alunos: Antonio Junior Souza Silva, Bruno Akiyama													                            
 # 																			                            
 # Descrição: Implementação do algoritmo de ordenação Selection Sort em linguagem MIPS Assembly								                            
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
 # O objetivo do Selection Sort é selecionar o menor valor do vetor e colocar na primeira posição, então diminuir o vetor. Repetindo esse processo até que o vetor esteja ordenado. 
 #  	Este algoritmo acima é o Selection Sort na linguagem C e explicaremos linha por linha o funcionamento deste algoritmo.							    
 # 																						    
 # Linha 1: Criação das variáveis i e j.																	    
 #																						    
 # Linha 2: Neste loop, fará a comparação j <n-1, n vezes onde entrará no for n-1 vezes e será em j que será armazenado o menor valor do vetor. ordenando do menor para o maior     
 #																						    
 # Linha 3: Nesta linha assumiremos que o menor valor esteja na primeira posição do atual vetor j, para depois compará-lo com as próximas posições do vetor.			    
 #																						    
 # Linha 4: Está linha inicia outro for dentro do for da linha 2 e será neste loop que o algoritmo irá buscar o menor valor do vetor.						    
 #																						    
 # Linha 5: Nesta linha será comparado o menor valor atual(que inicia com o valor de j) com o atual valor do vetor na posição i.						    
 # 																						    
 # Linha 6: Caso o valor do vetor na posição i seja menor que o valor na posição iMin(menor valor atual), então iMin receberá o valor de i.					    
 #																						    
 # Linha 8: Termina o segundo for.																		    
 #
 # Linha 9: Está comparação foi feita para evitar trocas desnecessárias caso o menor valor esteja na posição j.									    
 #
 # Linha 10: Caso iMin seja diferente de j, então troca o valor da posição iMin pelo valor da posição j.									    
 # 
 # Linha 11: Termina o primeiro for, assim repetindo o loop até j = n-1.													    
 # 
 # Registradores usados para ordenação:
 # $t0 = n (vetor.length)
 # $t1 = posição inicial do vetor
 # $t2 = contador j
 # $t3 = n-1 (vetor.length - 1)
 # $t4 = iMin
 # $t5 = contador i
 # $t6 = v[i]
 # $t7 = v[iMin]
 # $s0 e $s1 serão usados para marcar a posição de v[i] e v[iMin]
 #---------------------------------------------------------------------------------------------------------------------------------------------------

		.data
		
V: 		.word 22,3,9,19,16,5,12,6,15,2,7,1
Length: 	.word 12
msg1:	 	.asciiz "O vetor inicial é: "
msg2:		.asciiz "\n\nO vetor ordenado é: "
virgula:	.asciiz ", "
Pulalinha:	.asciiz "\n"
		
		.text

#------------------------------
_start:
		lw $t0, Length			# Registrador $t0 recebe tamanho do vetor. $t0 = n 
		la $t1, V			# Registrador $t1 recebe endereï¿½o de v[0]
		addi $v0, $zero, 4		# Especificando o serviï¿½o de impressão de string, código 4
		la $a0, msg1			# Carregando para o registrador a0 o endereço da mensagem 1
		syscall				# Chamada do sistema para impressão da mensagem
		jal print			# Chamada da função print, para imprimir os numeros do vetor desordenado na tela		
		add $t2, $zero, $zero		# j = 0
		subi $t3, $t0, 1		# n = n-1
#-----------------------------------
#Iniciando Ordenação

for_Min:	
		beq $t2,$t3, fim_Min		# Se j >= n-1, então termina o forj
		add $t4, $t2, $zero		# iMin = j
		addi $t5, $t2, 1		# i = j + 1
#-----------------------------------

for_Interno:	
		beq $t5, $t0, fim_Interno	# Se i >= n, então termina fori
		sll $s0, $t5, 2			# $s0 = i*4
		sll $s1, $t4, 2			# $s1 = iMin*4
		add $s0, $s0, $t1		# Adiciona a posição de v[0] + i*4
		add $s1, $s1, $t1		# Adiciona a posição de v[0] + iMin*4
		lw $t6, ($s0)			# $t6 = v[i]
		lw $t7, ($s1)			# $t7 = v[iMin]
		bge $t6, $t7, else		# Se v[i]>=v[iMin], então volta para fori
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
		add $s0, $s0, $t1		# Adiciona a $s0 a posição de v[0] + j*4
		add $s1, $s1, $t1		# Adiciona a $s1 a posição de v[0] + iMin*4
		lw $t6, ($s0)			# $t6 = v[j]
		lw $t7, ($s1)			# $t7 = v[iMin]
		sw $t6, ($s1)			# v[iMin]= $t6 (valor na posição v[j])
		sw $t7, ($s0)			# v[j] = $t7 (valor na posição v[iMin])
#-----------------------------------	

else1:	
		addi $t2, $t2, 1		# j = j + 1
		j for_Min			# jump para for_Min
#----------------------------------

fim_Min:	
		add $t2, $zero, $zero 		# j = 0
		addi $v0, $zero, 4		# Especificando serviço de impressao de string
		la $a0, msg2			# Carregando para o registrador a0 o endereço da mensagem 2
		syscall				# Chamada do sistema e impressão da mensagem na tela
		jal print			# Chamando a função de impressão dos numeros do vetor
		addi $v0,$zero, 4		# Codigo de impressão de uma linha
		la $a0, Pulalinha		# Armazena o endereço Pulalinha para imprimi-lo
		syscall				# Pula a linha após o fim da impressão
		addi $v0,$zero, 10		# especificando encerramento do programa, codigo 10
		syscall				# Fim do código
#----------------------------------


# Função para Imprimir os números contidos no vetor.	
print:
		beq $t2, $t0, fim_Print		# Se j >= n, então pula para fimprint
		sll $s0, $t2, 2			# $s0 = j*4
		add $s0, $s0, $t1		# Adiciona a posição de v[0] + j*4
		lw $t6, ($s0)			# $t6 = v[j]
		addi $v0, $zero, 1		# Especificando serviï¿½o de impressï¿½o de inteiros, cï¿½digo 1
		add $a0, $t6, $zero		# Adicionando no registrador a0 o valor contido no registrador t6 para imprimí-lo
		syscall				# Chamada do sistema e impressão da mensagem
		addi $v0, $zero, 4		# Especificando serviço de impressão de string, codigo 4
		la $a0, virgula			# Carregando para registrador $a0 o endereço da mensagem 'virgula'
		syscall				# Chamada do sistema para impressï¿½o da mensagem
		addi $t2, $t2, 1		# j = j + 1
		j print				# Jump para print
#-----------------------------------
fim_Print:
		jr $ra				# Retornando ao endereço de chamada da função
					
	
