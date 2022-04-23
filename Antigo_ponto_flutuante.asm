 @ /0000
 MAIN SC ANTIFLOAT
      HM MAIN

; ===========================================================
; =================== FLOAT =================================
; ===========================================================

; =================== variaveis de retorno =================================

SIGNAL          K /0000; s = 0000 ou 0001
CARACTERISTICA1 K /0000; 0 < c <  31 
CARACTERISTICA2 K /0000; 
MANTISSA1       K /0000; 
MANTISSA2       K /0000;
MANTISSA3       K /0000;
MANTISSA4       K /0000;


; f (16 bits) mais significativo para menos significativo

; =================== variaveis de entrada =================================

VARIAVEL K /1234 ;numero a ser convertido

; =================== numeros em binario =================================

BINARIO1    K /0000 ; mais significativo
BINARIO2    K /0000
BINARIO3    K /0000
BINARIO4    K /0000 ; menos significativo

; =================== constantes  para a funcao float =================================

QUATRO        K /0004
OITO          K /0008
DOZE          K /000C
DEZESSEIS     K /0010
BIAS          K /000F;

; =================== variaveis para a funcao float =================================

INTERCARACTERISTICA K /0000;

;############################ função float ############################################

FLOAT        K /0000;
            LD VARIAVEL;primeiro testa o s e o coloca na calor
            JN NEGATIVO;
            LV /0000 ;carrega 0
            MM SIGNAL ;
            JP VOLTASIGNAL
NEGATIVO    LV /0001 ; garrega um 
            MM SIGNAL ; 
            LD VARIAVEL
            ML MENOSUM
            MM VARIAVEL
            JP VOLTASIGNAL 
;depois de descobrir o sinal, precisamos transformartransformar a varivel em bits, guardando nas mantissas          
VOLTASIGNAL LD VARIAVEL;1234
            ML CONST1;4000
            DV CONST1;0004
            MM INTERMEDIARIO;
            SC HEX2BIN;
            MM BINARIO4;

            LD VARIAVEL; 1234
            ML CONST2; 3400
            DV CONST1; 0003
            MM INTERMEDIARIO;
            SC HEX2BIN;
            MM BINARIO3;

            LD VARIAVEL; 1234
            ML CONST3; 2340
            DV CONST1; 0002
            MM INTERMEDIARIO;
            SC HEX2BIN;
            MM BINARIO2;

            LD VARIAVEL; 1234
            DV CONST1; 0001
            MM INTERMEDIARIO;
            SC HEX2BIN;
            MM BINARIO1;

            ;caracteristica
              
            SC ENCONTRAPRIMEIROUM; funcao irá procurar em qual posicao o primeiro 1 se encontra, na varivel binarios
            AD BIAS; 
            MM INTERCARACTERISTICA; salva provisoriamente a caracteristica em hexa
            ;transformamos em binário a caracteristica
            ML CONST1
            DV CONST1
            MM INTERMEDIARIO;
            SC HEX2BIN
            MM CARACTERISTICA2;
            LD INTERCARACTERISTICA;
            DV CONST3
            MM INTERMEDIARIO;
            SC HEX2BIN
            MM CARACTERISTICA1;

            ;mantissa
            SC ENCONTRAMANTISSA
            LD BINARIO1
            MM MANTISSA1
            LD BINARIO2
            MM MANTISSA2
            LD BINARIO3
            MM MANTISSA3
            LD BINARIO4
            MM MANTISSA4


            RS FLOAT; retorna a funcao


;############################ fim da função float ############################################


; =================== variaveis para a funcao HEX2BIN =================================
BINARIO K /0000;
INTERMEDIARIO K /0000;

; =================== constantes para a funcao HEX2BIN =================================

CONST1  K /1000;
CONST2  K /0100;
CONST3  K /0010;
DOIS    K /0002;
MENOSUM K /FFFF;



;############################ subrotina HEX2BIN ############################################

HEX2BIN K /0000; guarda endereco

       LD INTERMEDIARIO;
       DV DOIS; 0004
       ML DOIS; 0008
       SB INTERMEDIARIO; -0001
       ML MENOSUM; 0001
       MM BINARIO; 

       LD INTERMEDIARIO;
       DV DOIS; 0004
       MM INTERMEDIARIO; 0004
       DV DOIS; 0002
       ML DOIS; 0004
       SB INTERMEDIARIO; 0000
       ML MENOSUM;
       ML CONST3; 0000
       AD BINARIO;
       MM BINARIO; 

       LD INTERMEDIARIO; 0004
       DV DOIS; 0002
       MM INTERMEDIARIO; 0002
       DV DOIS; 0001
       ML DOIS; 0002
       SB INTERMEDIARIO; 0000
       ML MENOSUM;
       ML CONST2; 
       AD BINARIO;
       MM BINARIO;


       LD INTERMEDIARIO; 0002
       DV DOIS; 0001
       MM INTERMEDIARIO; 0001
       DV DOIS; 0000
       ML DOIS; 0000
       SB INTERMEDIARIO; -0001
       ML MENOSUM;0001
       ML CONST1; 
       AD BINARIO;
       MM BINARIO;

       LD BINARIO;

       RS HEX2BIN; retorna

;############################ fim subrotina HEX2BIN ############################################

; =================== constantes para a funcao ENCONTRAPRIMEIROUM ================================
ZERO     K /0000
UM       K /0001

; =================== variaveis para a funcao ENCONTRAPRIMEIROUM =================================
CONTADOR K /0000
POSICAO  K /0000


;############################ subrotina ENCONTRAPRIMEIROUM ############################################

ENCONTRAPRIMEIROUM  K /0000; 
            LD ZERO
            MM CONTADOR
            ;bit mais significativo do binario1
            LD BINARIO1
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            ;segundo bit mais significativo do binario1 
    	    LD BINARIO1 
            ML CONST3  
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            ;terceiro bit mais significativo do BINARIO1
    	    LD BINARIO1 
            ML CONST2
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            ;quarto bit mais significativo do BINARIO1
    	    LD BINARIO1 
            ML CONST1
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            
            ;bit mais significativo do binario2
            LD BINARIO2
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            ;segundo bit mais significativo do binario2 
    	    LD BINARIO2 
            ML CONST3
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            ;terceiro bit mais significativo do BINARIO2
    	    LD BINARIO2 
            ML CONST2
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            ;quarto bit mais significativo do BINARIO2
    	     LD BINARIO2 
            ML CONST1
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            
            ;bit mais significativo do binario3
            LD BINARIO3
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            ;segundo bit mais significativo do binario3
    	    LD BINARIO3
            ML CONST3
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            ;terceiro bit mais significativo do BINARIO3
    	    LD BINARIO3 
            ML CONST2
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            ;quarto bit mais significativo do BINARIO3
            LD BINARIO3
            ML CONST1
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR

            ;bit mais significativo do binario4
            LD BINARIO4
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            ;segundo bit mais significativo do binario4 
    	    LD BINARIO4
            ML CONST3
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            ;terceiro bit mais significativo do BINARIO4
    	    LD BINARIO4
            ML CONST2
            DV CONST1; divide por 0x1000 
            SB UM;
            JZ ENCONTROUUM;
            LD CONTADOR
            AD UM;
            MM CONTADOR;
            ;quarto bit mais significativo do BINARIO4
    	    LD BINARIO4 
            ML CONST1
            DV CONST1; divide por 0x1000 
            SB UM
            JZ ENCONTROUUM
            LD CONTADOR
            AD UM
            MM CONTADOR
            JP ENCONTROUUM
ENCONTROUUM LD DEZESSEIS;
            SB CONTADOR;
            LD POSICAO; carrega a posicao do primeiro 1 nos binarios
            RS ENCONTRAPRIMEIROUM
            
;############################ fim subrotina ENCONTRAPRIMEIROUM ############################################


;############################ subrotina ENCONTRAMANTISSA ############################################

ENCONTRAMANTISSA K /0000
                 LD POSICAO
                 SB QUATRO
                 JN TRATABIN1
                 LD POSICAO
                 SB OITO
                 JN TRATABIN2
                 LD POSICAO
                 SB DOZE
                 JN TRATABIN3
                 JP TRATABIN4;
                 

TRATABIN1        LD POSICAO
                 JZ TRATABIN10
                 SB UM
                 JZ TRATABIN11
                 SB UM
                 JZ TRATABIN12
                 JP TRATABIN13


TRATABIN10       LD BINARIO1
                 SB CONST1
                 MM BINARIO1
                 JP ACABOU 
                 
TRATABIN11       LD BINARIO1
                 SB CONST2
                 MM BINARIO1
                 JP ACABOU 
    
TRATABIN12       LD BINARIO1
                 SB CONST3 
                 MM BINARIO1 
                 JP ACABOU 

TRATABIN13       LD BINARIO1 
                 SB UM 
                 MM BINARIO1 
                 JP ACABOU        


TRATABIN2        LD POSICAO
                 SB QUATRO
                 JZ TRATABIN20
                 SB UM
                 JZ TRATABIN21
                 SB UM
                 JZ TRATABIN22
                 JP TRATABIN23

TRATABIN20       LD BINARIO2
                 SB CONST1
                 MM BINARIO2
                 JP ACABOU 
                 
TRATABIN21       LD BINARIO2
                 SB CONST2
                 MM BINARIO2
                 JP ACABOU 
    
TRATABIN22       LD BINARIO2
                 SB CONST3 
                 MM BINARIO2 
                 JP ACABOU 

TRATABIN23       LD BINARIO2 
                 SB UM 
                 MM BINARIO2 
                 JP ACABOU        


TRATABIN3        LD POSICAO
                 SB OITO;
                 JZ TRATABIN30
                 SB UM
                 JZ TRATABIN31
                 SB UM
                 JZ TRATABIN32
                 JP TRATABIN33

TRATABIN30       LD BINARIO3
                 SB CONST1
                 MM BINARIO3
                 JP ACABOU 
                 
TRATABIN31       LD BINARIO3
                 SB CONST2
                 MM BINARIO3
                 JP ACABOU 
    
TRATABIN32       LD BINARIO3
                 SB CONST3 
                 MM BINARIO3 
                 JP ACABOU 
                 
TRATABIN33       LD BINARIO3 
                 SB UM 
                 MM BINARIO3 
                 JP ACABOU              


TRATABIN4        LD POSICAO
                 SB DOZE
                 JZ TRATABIN40
                 SB UM
                 JZ TRATABIN41
                 SB UM
                 JZ TRATABIN42
                 JP TRATABIN43

TRATABIN40       LD BINARIO4
                 SB CONST1
                 MM BINARIO4
                 JP ACABOU 
                 
TRATABIN41       LD BINARIO4
                 SB CONST2
                 MM BINARIO4
                 JP ACABOU 
    
TRATABIN42       LD BINARIO4
                 SB CONST3 
                 MM BINARIO4 
                 JP ACABOU 
    
TRATABIN43       LD BINARIO4 
                 SB UM 
                 MM BINARIO4 
                 JP ACABOU 


ACABOU           RS ENCONTRAMANTISSA

;############################ fim subrotina ENCONTRAMANTISSA ############################################

; ========================================================================================================
; ===================  SOMA ==============================================================================
; ========================================================================================================

; ===================  tabela de conversão de binario para hexa ====================================================

TABCONV       K /0000
              K /0001
              K /0010
              K /0011
              K /0100
              K /0101
              K /0110
              K /0111
              K /1000
              K /1001
              K /1010
              K /1011
              K /1100
              K /1101
              K /1110
              K /1111

;
;
; ===================  variaveis  ANTIFLOAT ====================================================
EXPOENTE      K /0000
VARHEX        K /0000
ELEVADO       K /0000
MTSHEX1       K /0000
MTSHEX2       K /0000
MTSHEX3       K /0000
MTSHEX4       K /0000
TEMP          K /0000

; ===================  variaveis de entrada ANTIFLOAT ====================================================

AFSIGNAL      K /0000  
AFCARACT1     K /0001
AFCARACT2     K /1011
AFMTSS1       K /0010
AFMTSS2       K /0011
AFMTSS3       K /0100
AFMTSS4       K /0000

;############################ subrotina ANTIFLOAT ############################################

ANTIFLOAT     K  /0000
              LD AFCARACT1 ; constroi expoente
              ML DEZESSEIS; = 16
              AD AFCARACT2; = 20
              SB BIAS; = 5
              MM EXPOENTE; = 5
              SC POT2; o que é pra ser elevado ta no acumulador
              MM VARHEX; = 32 : começa a construir o resultado em hexa
              LD AFMTSS1 ; converte mantissas para hexa
              SC BIN2HEX; 
              MM MTSHEX1; = 14
              LD AFMTSS2;
              SC BIN2HEX; 
              MM MTSHEX2;
              LD AFMTSS3 
              SC BIN2HEX; 
              MM MTSHEX3;
              LD AFMTSS4; 
              SC BIN2HEX; 
              MM MTSHEX4; = 14
MTSS1         LD EXPOENTE;    começa a somar a mantissa
              SB QUATRO; = 1
              JN EXPNEGATIVO1
              SC POT2; volta 2
              ML MTSHEX1; = 28
              AD VARHEX; = 60, Fim do primeiro bloco
              MM VARHEX
              JP MTSS2
EXPNEGATIVO1  ML MENOSUM
              SC POT2
              MM TEMP
              LD MTSHEX1
              DV TEMP
              AD VARHEX
              MM VARHEX
MTSS2         LD EXPOENTE; 
              SB OITO;
              JN EXPNEGATIVO2
              SC POT2;
              ML MTSHEX2;
              AD VARHEX; Fim do segundo bloco
              MM VARHEX
              JP MTSS3
EXPNEGATIVO2  ML MENOSUM
              SC POT2
              MM TEMP
              LD MTSHEX2
              DV TEMP
              AD VARHEX
              MM VARHEX
MTSS3         LD EXPOENTE; 
              SB DOZE;
              JN EXPNEGATIVO3
              SC POT2;
              ML MTSHEX3;
              AD VARHEX; Fim do terceiro bloco
              MM VARHEX
              JP MTSS4
EXPNEGATIVO3  ML MENOSUM
              SC POT2
              MM TEMP
              LD MTSHEX3
              DV TEMP
              AD VARHEX
              MM VARHEX
MTSS4         LD EXPOENTE; 
              SB DEZESSEIS;
              JN EXPNEGATIVO4
              SC POT2;
              ML MTSHEX4;
              AD VARHEX; Fim do quarto bloco
              MM VARHEX
              JP VERSINAL
EXPNEGATIVO4  ML MENOSUM
              SC POT2
              MM TEMP
              LD MTSHEX4
              DV TEMP
              AD VARHEX
              MM VARHEX
VERSINAL      LD AFSIGNAL
              JZ FIMANTIFLOAT
              LD VARHEX
              ML MENOSUM
              MM VARHEX
FIMANTIFLOAT  RS ANTIFLOAT

;############################ fim subrotina ANTIFLOAT ############################################


; ===================  variaveis e constantes de BIN2HEX ====================================================
APTDB2H       K  /0000
CONTB2H       K  /0000
VLR           K  /0000
TAB           K  TABCONV
LOAD          K  /8000

;############################ subrotina BIN2HEX ############################################      

BIN2HEX       K  /0000 ; entrada e saida no acumulador
              MM VLR
              LV /0000
              MM CONTB2H
              LD TAB; 
              MM APTDB2H
INICIALOOP    AD LOAD
              MM PROXPOSICAO
PROXPOSICAO   K  /0000
              SB VLR
              JZ ACHOUCONV
              LD UM
              AD CONTB2H
              MM CONTB2H
              LD DOIS
              AD APTDB2H
              MM APTDB2H
              JP INICIALOOP
ACHOUCONV     LD CONTB2H
              RS BIN2HEX

;############################ fim subrotina BIN2HEX ############################################

; ===================  variaveis e constantes de POT2 ==========================================
EXPOENTEPOT2  K /0000 ; 
CONTADORPOT2  K /0000 ; 
RESULTADOPOT2 K /0001 ; 

;############################ subrotina POT2 ############################################

POT2          K  /0000 ; entrada e saida no acumulador, expoente vem no acumulador
              MM EXPOENTEPOT2
              LD UM
              MM RESULTADOPOT2
              LD ZERO
              MM CONTADORPOT2
ITERA         LD EXPOENTEPOT2 ;
              SB CONTADORPOT2 ;
              JZ FIMPOT2
              LD RESULTADOPOT2
              ML DOIS
              MM RESULTADOPOT2
              LD CONTADORPOT2
              AD UM
              MM CONTADORPOT2 
              JP ITERA
FIMPOT2       LD RESULTADOPOT2
              RS POT2

;############################ fim subrotina POT2 ############################################

; ===================  variaveis para o primeiro float ==========================================

PARC1SIGNAL          K /0000
PARC1CARAC1          K /0000
PARC1CARAC2          K /0000
PARC1MTSS1           K /0000
PARC1MTSS2           K /0000
PARC1MTSS3           K /0000
PARC1MTSS4           K /0000

PARC1                K /0000

; ===================  variaveis para o segundo float ==========================================

PARC2SIGNAL          K /0000
PARC2CARAC1          K /0000
PARC2CARAC2          K /0000
PARC2MTSS1           K /0000
PARC2MTSS2           K /0000
PARC2MTSS3           K /0000
PARC2MTSS4           K /0000


PARC2                K /0000

; ===================  variaveis para o float da soma ==========================================

SOMASIGNAL1          K /0000
SOMACARACTERISTICA1  K /0000
SOMAMANTISSA1        K /0000
SOMAMANTISSA2        K /0000
SOMAMANTISSA3        K /0000
SOMAMANTISSA4        K /0000
             
RESULTADOSOMA        K /0000

;############################ subrotina SOMA ############################################
; copia as infos de cada variavel para variaveis do antifloat, guarda elas em hexa, e por fim soma

SOMA                 K  /0000
PARCELA1             LD PARC1SIGNAL
                     MM AFSIGNAL
                     LD PARC1CARAC1
                     MM AFCARACT1
                     LD PARC1CARAC2
                     MM AFCARACT2
                     LD PARC1MTSS1
                     MM AFMTSS1
                     LD PARC1MTSS2
                     MM AFMTSS2
                     LD PARC1MTSS3
                     MM AFMTSS3
                     LD PARC1MTSS4
                     MM AFMTSS4
                     SC ANTIFLOAT
                     MM PARC1
PARCELA2             LD PARC2SIGNAL
                     MM AFSIGNAL
                     LD PARC2CARAC1
                     MM AFCARACT1
                     LD PARC2CARAC2
                     MM AFCARACT2
                     LD PARC2MTSS1
                     MM AFMTSS1
                     LD PARC2MTSS2
                     MM AFMTSS2
                     LD PARC2MTSS3
                     MM AFMTSS3
                     LD PARC2MTSS4
                     MM AFMTSS4
                     SC ANTIFLOAT
                     MM PARC2
 ;soma propriamente dita                    
                     AD PARC1
                     MM RESULTADOSOMA
                     MM VARIAVEL
                     SC FLOAT
                     RS SOMA


;############################ fim subrotina SOMA ############################################

; ========================================================================================================
; ===================  SUBTRACAO =========================================================================
; ========================================================================================================

SUBTRACAO            K /0000; multiplica por menos um (troca o s do segundo numero) e chama o soma
                     LD PARC2SIGNAL
                     JZ MUDAPARAUM
                     LV /0000
                     MM PARC2SIGNAL
                     JP CHAMASOMA
MUDAPARAUM           LD UM
                     MM PARC2SIGNAL
CHAMASOMA            SC SOMA
                     RS SUBTRACAO

; ========================================================================================================
; ===================  ESCREVE ===========================================================================
; ========================================================================================================


;representacao escolhido e como será impresso no monitor
;scccccffffffffffffffff

; ===================  constantes ASCII para ESCREVE ===========================================================================

ZEROASCII K /0030


; ===================  constantes para ESCREVE =====================================================
INTERESCREVE K /0000
MONITOR K /0001

;############################ rotina ESCREVE ############################################
ESCREVE  K  /0000

         ;escreve signal e primeiro caracter da caracteristica
         LD SIGNAL
         AD ZEROASCII
         ML CONST2
         MM INTERESCREVE
         LD CARACTERISTICA1
         AD ZEROASCII
         AD INTERESCREVE
         PD MONITOR; escreve no MONITOR
         
         ;escreve segundo e terceiro caracter da caracteristica
         LD CARACTERISTICA2
         DV CONST1
         AD ZEROASCII
         ML CONST2
         MM INTERESCREVE
         LD CARACTERISTICA2
         ML CONST3
         DV CONST1
         AD ZEROASCII
         AD INTERESCREVE 
         PD MONITOR

         ;escreve quarto e quinto caracter da caracteristica
         LD CARACTERISTICA2
         ML CONST2
         DV CONST1
         AD ZEROASCII
         ML CONST2
         MM INTERESCREVE
         LD CARACTERISTICA2
         ML CONST1
         DV CONST1
         AD ZEROASCII
         AD INTERESCREVE 
         PD MONITOR

        ;escreve primeiro e segundo do caracter da mantissa1
         LD MANTISSA1
         DV CONST1
         AD ZEROASCII
         ML CONST2
         MM INTERESCREVE
         LD MANTISSA1
         ML CONST3
         DV CONST1
         AD ZEROASCII
         AD INTERESCREVE 
         PD MONITOR

         ;escreve terceira e quarta do caracter da mantissa1
         LD MANTISSA1
         ML CONST2
         DV CONST1
         AD ZEROASCII
         ML CONST2
         MM INTERESCREVE
         LD MANTISSA1
         ML CONST1
         DV CONST1
         AD ZEROASCII
         AD INTERESCREVE 
         PD MONITOR


         ;escreve primeiro e segundo do caracter da mantissa2
         LD MANTISSA2
         DV CONST1
         AD ZEROASCII
         ML CONST2
         MM INTERESCREVE
         LD MANTISSA2
         ML CONST3
         DV CONST1
         AD ZEROASCII
         AD INTERESCREVE 
         PD MONITOR

         ;escreve terceira e quarta do caracter da mantissa2
         LD MANTISSA2
         ML CONST2
         DV CONST1
         AD ZEROASCII
         ML CONST2
         MM INTERESCREVE
         LD MANTISSA2
         ML CONST1
         DV CONST1
         AD ZEROASCII
         AD INTERESCREVE 
         PD MONITOR


         ;escreve primeiro e segundo do caracter da mantissa3
         LD MANTISSA3
         DV CONST1
         AD ZEROASCII
         ML CONST2
         MM INTERESCREVE
         LD MANTISSA3
         ML CONST3
         DV CONST1
         AD ZEROASCII
         AD INTERESCREVE 
         PD MONITOR

         ;escreve terceira e quarta do caracter da mantissa3
         LD MANTISSA3
         ML CONST2
         DV CONST1
         AD ZEROASCII
         ML CONST2
         MM INTERESCREVE
         LD MANTISSA3
         ML CONST1
         DV CONST1
         AD ZEROASCII
         AD INTERESCREVE 
         PD MONITOR


         ;escreve primeiro e segundo do caracter da mantissa4
         LD MANTISSA4
         DV CONST1
         AD ZEROASCII
         ML CONST2
         MM INTERESCREVE
         LD MANTISSA4
         ML CONST3
         DV CONST1
         AD ZEROASCII
         AD INTERESCREVE 
         PD MONITOR

         ;escreve terceira e quarta do caracter da mantissa4
         LD MANTISSA4
         ML CONST2
         DV CONST1
         AD ZEROASCII
         ML CONST2
         MM INTERESCREVE
         LD MANTISSA4
         ML CONST1
         DV CONST1
         AD ZEROASCII
         AD INTERESCREVE 
         PD MONITOR

         RS ESCREVE
         
;############################ fim rotina ESCREVE ############################################


; ========================================================================================================
; ========================  LE ===========================================================================
; ========================================================================================================

TECLADO K /0000

INTERLE K /0000


LE    K /0000
      ;zera todas as entradas
      LD ZERO
      MM SIGNAL
      MM CARACTERISTICA1 
      MM CARACTERISTICA2 
      MM MANTISSA1       
      MM MANTISSA2       
      MM MANTISSA3       
      MM MANTISSA4 
    
      ;le e pega o s e o primeiro bit do caracteristico
      GD TECLADO
      MM INTERLE
      DV CONST2
      SB ZEROASCII
      MM SIGNAL
      LD INTERLE
      ML CONST2
      DV CONST2
      SB ZEROASCII
      MM CARACTERISTICA1

      ;le e pega o segudo e terceiro bit do caracteristico
      GD TECLADO
      MM INTERLE
      DV CONST2
      SB ZEROASCII
      ML CONST1
      MM CARACTERISTICA2
      LD INTERLE
      ML CONST2
      DV CONST2
      SB ZEROASCII
      ML CONST2
      AD CARACTERISTICA2
      MM CARACTERISTICA2

      ;le e pega o quarto e quinto bit do caracteristico
      GD TECLADO
      MM INTERLE
      DV CONST2
      SB ZEROASCII
      ML CONST3
      AD CARACTERISTICA2
      MM CARACTERISTICA2
      LD INTERLE
      ML CONST2
      DV CONST2
      SB ZEROASCII
      AD CARACTERISTICA2
      MM CARACTERISTICA2

      ;le e pega o primeiro e segundo bit da MANTISSA1
      GD TECLADO
      MM INTERLE
      DV CONST2
      SB ZEROASCII
      ML CONST1
      AD MANTISSA1
      MM MANTISSA1
      LD INTERLE
      ML CONST2
      DV CONST2
      SB ZEROASCII
      ML CONST2
      AD MANTISSA1
      MM MANTISSA1

      ;le e pega o terceiro e quarto bit da MANTISSA1
      GD TECLADO
      MM INTERLE
      DV CONST2
      SB ZEROASCII
      ML CONST3
      AD MANTISSA1
      MM MANTISSA1
      LD INTERLE
      ML CONST2
      DV CONST2
      SB ZEROASCII
      AD MANTISSA1
      MM MANTISSA1

      
      ;le e pega o primeiro e segundo bit da MANTISSA2
      GD TECLADO
      MM INTERLE
      DV CONST2
      SB ZEROASCII
      ML CONST1
      AD MANTISSA2
      MM MANTISSA2
      LD INTERLE
      ML CONST2
      DV CONST2
      SB ZEROASCII
      ML CONST2
      AD MANTISSA2
      MM MANTISSA2

      ;le e pega o terceiro e quarto bit da MANTISSA2
      GD TECLADO
      MM INTERLE
      DV CONST2
      SB ZEROASCII
      ML CONST3
      AD MANTISSA2
      MM MANTISSA2
      LD INTERLE
      ML CONST2
      DV CONST2
      SB ZEROASCII
      AD MANTISSA2
      MM MANTISSA2


      ;le e pega o primeiro e segundo bit da MANTISSA3
      GD TECLADO
      MM INTERLE
      DV CONST2
      SB ZEROASCII
      ML CONST1
      AD MANTISSA3
      MM MANTISSA3
      LD INTERLE
      ML CONST2
      DV CONST2
      SB ZEROASCII
      ML CONST2
      AD MANTISSA3
      MM MANTISSA3

      ;le e pega o terceiro e quarto bit da MANTISSA3
      GD TECLADO
      MM INTERLE
      DV CONST2
      SB ZEROASCII
      ML CONST3
      AD MANTISSA3
      MM MANTISSA3
      LD INTERLE
      ML CONST2
      DV CONST2
      SB ZEROASCII
      AD MANTISSA3
      MM MANTISSA3


      ;le e pega o primeiro e segundo bit da MANTISSA4
      GD TECLADO
      MM INTERLE
      DV CONST2
      SB ZEROASCII
      ML CONST1
      AD MANTISSA4
      MM MANTISSA4
      LD INTERLE
      ML CONST2
      DV CONST2
      SB ZEROASCII
      ML CONST2
      AD MANTISSA4
      MM MANTISSA4

      ;le e pega o terceiro e quarto bit da MANTISSA4
      GD TECLADO
      MM INTERLE
      DV CONST2
      SB ZEROASCII
      ML CONST3
      AD MANTISSA4
      MM MANTISSA4
      LD INTERLE
      ML CONST2
      DV CONST2
      SB ZEROASCII
      AD MANTISSA4
      MM MANTISSA4

      RS LE 

      
# MAIN