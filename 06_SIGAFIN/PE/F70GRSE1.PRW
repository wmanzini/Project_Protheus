#Include "Protheus.ch"

/*/
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un玢o    � M05C04   � Autor � Cleber Maldonado      � Data � 23/03/18 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Ponto de entrada para grava玢o do campo E1_XSALDO dos      潮�
北�          � t韙ulos de prefixo PVA na baixa por CNAB.                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   �  U_F70GRSE1()                                              潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� Uso      � Baixa por CNAB - FINA700                                   潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
User Function F70GRSE1()

Private cParamIXB	:= PARAMIXB

If IsInCallStack("FA200GERA") .And. SE1->E1_PREFIXO == 'PVA' .And. SE1->E1_TIPO == 'BOL' .And. SE1->E1_XSALDO == 0
	SE1->E1_XSALDO := (SE1->E1_VALOR - SE1->E1_SALDO)
Endif

Return
