#INCLUDE "rwmake.ch"

/*/
// Validacao para a data de entrega do pedido de compras nao
//  ser inferior a data de emissao ou database
/*/
User Function M02V01()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Variaveis da Rotina                                                 �                                                                �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�  
Local lRet		:= .T. 

If ReadVar() == "M->C7_DATPRF"
	If Dtos(&(ReadVar())) < Dtos(DA120EMIS) .Or. Dtos(&(ReadVar())) < Dtos(dDatabase)
		lRet := .F.
		Help(" ",1,"Inconsist�ncia",,"A data de entrega n�o pode ser inferior a data de emiss�o ou database.",4)
	EndIf
EndIf

Return(lRet)	
