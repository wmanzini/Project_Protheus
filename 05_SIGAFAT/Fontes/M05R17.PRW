#INCLUDE "MATR620.ch"
#Include "PROTHEUS.Ch"

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � M05R17   � Autor � Cleber Maldonado      � Data � 30/06/17 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Relat�rio de Remessas do Suporte T�cnico                   ���
�������������������������������������������������������������������������Ĵ��
���Uso       � SIGAFAT                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
User Function M05R17()

Local oReport

If FindFunction("TRepInUse") .And. TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
EndIf

Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportDef � Autor � Cleber Maldonado      � Data � 30/06/17 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios que poderao ser agendados pelo usuario.          ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �ExpO1: Objeto do relat�rio                                  ���
�������������������������������������������������������������������������Ĵ��
���Parametros�Nenhum                                                      ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ReportDef()

Local oReport
Local oVenProd
Local cAliasQry := GetNextAlias()

//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�                                                                        �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//�                                                                        �
//��������������������������������������������������������������������������
oReport := TReport():New("M05R17","Remessas Suporte T�cnico","M05R17", {|oReport| ReportPrint(oReport,cAliasQry,oVenProd)},"Este relatorio emite a relacao diaria de itens do pedido de venda" + " " + " relacionados ao suporte t�cnico.")
oReport:SetTotalInLine(.F.)

Pergunte(oReport:uParam,.F.)

//������������������������������������������������������������������������Ŀ
//�Criacao da secao utilizada pelo relatorio                               �
//�                                                                        �
//�TRSection():New                                                         �
//�ExpO1 : Objeto TReport que a secao pertence                             �
//�ExpC2 : Descricao da se�ao                                              �
//�ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   �
//�        sera considerada como principal para a se��o.                   �
//�ExpA4 : Array com as Ordens do relat�rio                                �
//�ExpL5 : Carrega campos do SX3 como celulas                              �
//�        Default : False                                                 �
//�ExpL6 : Carrega ordens do Sindex                                        �
//�        Default : False                                                 �
//�                                                                        �
//��������������������������������������������������������������������������
//������������������������������������������������������������������������Ŀ
//�Criacao da celulas da secao do relatorio                                �
//�                                                                        �
//�TRCell():New                                                            �
//�ExpO1 : Objeto TSection que a secao pertence                            �
//�ExpC2 : Nome da celula do relat�rio. O SX3 ser� consultado              �
//�ExpC3 : Nome da tabela de referencia da celula                          �
//�ExpC4 : Titulo da celula                                                �
//�        Default : X3Titulo()                                            �
//�ExpC5 : Picture                                                         �
//�        Default : X3_PICTURE                                            �
//�ExpC6 : Tamanho                                                         �
//�        Default : X3_TAMANHO                                            �
//�ExpL7 : Informe se o tamanho esta em pixel                              �
//�        Default : False                                                 �
//�ExpB8 : Bloco de c�digo para impressao.                                 �
//�        Default : ExpC2                                                 �
//�                                                                        �
//��������������������������������������������������������������������������
oVenProd := TRSection():New(oReport,"Remessas Suporte T�cnico",{"SC6","SB1"},/*{Array com as ordens do relat�rio}*/,/*Campos do SX3*/,/*Campos do SIX*/)		// "Relacao de Pedidos por Produto"
oVenProd:SetTotalInLine(.F.)

//������������������������������������������������������������������������Ŀ
//�Define celulas da secao                                                 �
//��������������������������������������������������������������������������
TRCell():New(oVenProd,"EMISSAO"		,/*Tabela*/	,"Emissao"			 ,PesqPict("SC5","C5_EMISSAO")	,TamSx3("C5_EMISSAO")[1]+20	,/*lPixel*/,{|| dEmiss	})			// Data de Emiss�o
TRCell():New(oVenProd,"NUM"			,/*Tabela*/	,"Pedido"	 		 ,PesqPict("SC6","C6_NUM")		,TamSx3("C6_NUM")[1]+10		,/*lPixel*/,{|| cNum	})			// Numero do Pedido
TRCell():New(oVenProd,"VEND"		,/*Tabela*/ ,"Vendedor"			 ,PesqPict("SC5","C5_VEND1")	,TamSx3("C5_VEND1")[1]+10	,/*lPixel*/,{|| cVend1	})			// Vendedor 1
TRCell():New(oVenProd,"CLIENT"		,/*Tabela*/	,"Cliente"			 ,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME")[1]+10	,/*lPixel*/,{|| cNome	})			// Nome do Cliente
TRCell():New(oVenProd,"ITEM"		,/*Tabela*/ ,"Item"				 ,PesqPict("SC6","C6_ITEM")		,TamSx3("C6_ITEM")[1]+10	,/*lPixel*/,{|| cItem	})			// Item do Pedido
TRCell():New(oVenProd,"ETAPA"		,/*Tabela*/ ,"Etapa"			 ,PesqPict("SC6","C6_XETAPA")	,TamSx3("C6_XETAPA")[1]+10	,/*lPixel*/,{|| cXEtapa })			// Etapa
TRCell():New(oVenProd,"CODIGO"		,/*Tabela*/	,"C�digo"			 ,PesqPict("SC6","C6_PRODUTO")	,TamSx3("C6_PRODUTO")[1]+10	,/*lPixel*/,{|| cCodigo	})			// C�digo do Produto
TRCell():New(oVenProd,"TIPO"		,/*Tabela*/ ,"Tipo"				 ,PesqPict("SB1","B1_TIPO")		,TamSx3("B1_TIPO")[1]+10	,/*lPixel*/,{|| cTipo	})			// Tipo do Produto
TRCell():New(oVenProd,"LOCAL"		,/*Tabela*/ ,"Armazem"			 ,PesqPict("SB1","B1_LOCPAD")	,TamSx3("B1_LOCPAD")[1]+10	,/*lPixel*/,{|| cLocal	})			// Armazem
TRCell():New(oVenProd,"DESC"		,/*Tabela*/	,"Descri�ao"		 ,PesqPict("SB5","B5_CEME")		,TamSx3("B5_CEME")[1]+10	,/*lPixel*/,{|| cDesc	})			// Descri��o do Produto
TRCell():New(oVenProd,"SALDO"		,/*Tabela*/	,"A Entregar"		 ,PesqPict("SC6","C6_QTDVEN")	,TamSx3("C6_QTDVEN")[1]+10	,/*lPixel*/,{|| nSaldo	})			// Saldo
TRCell():New(oVenProd,"SALDOEST"	,/*Tabela*/	,"Saldo Em Estoque"	 ,PesqPict("SB2","B2_QATU")		,TamSx3("B2_QATU")[1]		,/*lPixel*/,{|| nSldEst })			// Saldo em Estoque
TRCell():New(oVenProd,"OP"			,/*Tabela*/	,"OP"				 ,PesqPict("SC6","C6_OP")		,TamSx3("C6_OP")[1]+10		,/*lPixel*/,{||	cOP		})			// Numero da Ordem de Produ��o
TRCell():New(oVenProd,"VLUIPI"		,/*Tabela*/	,"Vl.Tot+IPI"		 ,PesqPict("SC6","C6_XVLTBRU")	,TamSx3("C6_XVLTBRU")[1]+10	,/*lPixel*/,{||	nVlUnIPI})			// Vl Bruto + IPI
TRCell():New(oVenProd,"ENTREGA"		,/*Tabela*/	,"Dt.Entrega"		 ,PesqPict("SC6","C6_ENTREG")	,TamSx3("C6_ENTREG")[1]+10	,/*lPixel*/,{|| dDtEntr	})			// Data de Entrega

Return(oReport)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportPrin� Autor � Cleber Maldonado	    � Data � 30/06/17 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios que poderao ser agendados pelo usuario.          ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���Parametros�ExpO1: Objeto Report do Relat�rio                           ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ReportPrint(oReport,cAliasQry,oVenProd)

Local lPosB1	:= .F.
Local lPosB2	:= .F.
Local lPosB5	:= .F.
Local lPosC5	:= .F.
Local lPosA1	:= .F.
Local lPronta	:= .F.
Local lAtraso	:= .F.

//������������������������������������������������������������������������Ŀ
//�Filtragem do relat�rio                                                  �
//��������������������������������������������������������������������������
dbSelectArea("SC6")		// Itens do Pedido de Vendas
dbSetOrder(2)			// Produto,Numero
#IFDEF TOP
	//������������������������������������������������������������������������Ŀ
	//�Query do relat�rio da secao 1                                           �
	//��������������������������������������������������������������������������
	oReport:Section(1):BeginQuery()	

	BeginSql Alias cAliasQry
	
		COLUMN C6_XGOPDT AS DATE
		COLUMN C6_ENTREG AS DATE
	
		SELECT 
			C6_FILIAL,C6_NUM,C6_ITEM,C6_PRODUTO,C6_QTDVEN,C6_QTDENT,C6_XITEMP,C6_XOPER,C6_XETAPA,C6_XGOPDT,C6_OP,C6_ENTREG,C6_XVLUBRU,C6_XVLTBRU
		FROM 
			%Table:SC6% SC6
		WHERE 
			SC6.C6_FILIAL = '01' AND
			SC6.%NotDel%
		ORDER BY SC6.C6_NUM
	EndSql 
	//������������������������������������������������������������������������Ŀ
	//�Metodo EndQuery ( Classe TRSection )                                    �
	//�                                                                        �
	//�Prepara o relat�rio para executar o Embedded SQL.                       �
	//�                                                                        �
	//�ExpA1 : Array com os parametros do tipo Range                           �
	//�                                                                        �
	//��������������������������������������������������������������������������
	oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
#ENDIF		

//������������������������������������������������������������������������Ŀ
//�Inicio da impressao do fluxo do relat�rio                               �
//��������������������������������������������������������������������������
dbSelectArea("SB1")
dbSetOrder(1)
dbSelectArea("SB2")
dbSetOrder(1)
dbSelectArea("SB5")
dbSetOrder(1)
dbSelectArea("SC5")
dbSetOrder(1)
dbSelectArea("SA1")
dbSetOrder(1)
dbSelectArea(cAliasQry)
dbGoTop()

oReport:SetMeter((cAliasQry)->(LastRec()))
oReport:Section(1):Init()

While !oReport:Cancel() .And. !(cAliasQry)->(Eof())

	nSaldo		:= ((cAliasQry)->C6_QTDVEN - (cAliasQry)->C6_QTDENT)
	cDesc		:= " "
	
	If MV_PAR01 == 2 .And. nSaldo == 0
		(cAliasQry)->(dbSkip())
		Loop
	ElseIf MV_PAR01 == 1 .And. nSaldo <> 0
		(cAliasQry)->(dbSkip())
		Loop
	Endif

	lPosB1 	:= SB1->(MsSeek(xFilial('SB1')+(cAliasQry)->C6_PRODUTO))
	lPosB2	:= SB2->(MsSeek(xFilial('SB2')+(cAliasQry)->C6_PRODUTO+SB1->B1_LOCPAD))
	lPosB5	:= SB5->(MsSeek(xFilial('SB5')+(cAliasQry)->C6_PRODUTO))
	lPosC5	:= SC5->(MsSeek(xFilial('SC5')+(cAliasQry)->C6_NUM))

	If lPosC5
		If SC5->C5_MSBLQL == '1' .Or. SC5->C5_VEND1 <> "000008"
			(cAliasQry)->(dbSkip())
			Loop
		Endif
			
		lPosA1	:= SA1->(MsSeek(xFilial('SA1')+SC5->C5_CLIENTE+SC5->C5_LOJACLI))
		If lPosA1
			If MV_PAR02 == 1
				cNome	:= SA1->A1_NOME
			Else
				cNome	:= SA1->A1_NREDUZ
			Endif			
			cEst	:= SA1->A1_EST
		Else
			cNome	:= ""
			cEst	:= ""
		Endif
	Else
		(cAliasQry)->(dbSkip())		
	EnDif
	
	cNum		:= (cAliasQry)->C6_NUM
	cItem		:= (cAliasQry)->C6_ITEM
	cCodigo		:= (cAliasQry)->C6_PRODUTO
	cOP			:= (cAliasQry)->C6_OP
	cXEtapa		:= POSICIONE("ZA3",1,XFILIAL("ZA3") + (cAliasQry)->C6_XETAPA,"ZA3_DESCRI")
	dDtEntr		:= (cAliasQry)->C6_ENTREG
	nQuant		:= (cAliasQry)->C6_QTDVEN
	nVlUnIPI	:= ((cAliasQry)->C6_XVLTBRU / nQuant ) * nSaldo
	lAtraso		:= (cAliasQry)->C6_ENTREG < DDATABASE

	If lPosC5
		dEmiss		:= SC5->C5_EMISSAO
		cVend1		:= SC5->C5_VEND1
		lPronta		:= ((cAliasQry)->C6_ENTREG - SC5->C5_EMISSAO) < 7

//		U_BusTpVen(cTpVen) //Fun��o para utilizar os tipo de vendas cadastrados no campo C5_XTPVEN

		Do Case
			Case Alltrim(SC5->C5_XTPVEN) == "1"
				cXTpVen		:= "1 - Projeto"
			Case Alltrim(SC5->C5_XTPVEN) == "2"
				cXTpVen		:= "2 - Venda Unitaria"
			Case Alltrim(SC5->C5_XTPVEN) == "3"
				cXTpVen		:= "3 - Dealer"			
			Case Alltrim(SC5->C5_XTPVEN) == "4"
				cXTpVen		:= "4 - E-Commerce"
			Case Alltrim(SC5->C5_XTPVEN) == "5"
				cXTpVen		:= "5 - Pronta Entrega"
			Case Alltrim(SC5->C5_XTPVEN) == "6"
				cXTpVen		:= "6 - Projeto-Dealer"
			Case Alltrim(SC5->C5_XTPVEN) == "7"
				cXTpVen		:= "7 - Venda de Pe�as"
			Case Alltrim(SC5->C5_XTPVEN) == "8"
				cXTpVen		:= "8 - Suporte Tecnico"
			Case Alltrim(SC5->C5_XTPVEN) == "9"
				cXTpVen		:= "9 - ARE"
			Case Alltrim(SC5->C5_XTPVEN) == "10"
				cXTpVen		:= "10 - Servi�os"
			Case Alltrim(SC5->C5_XTPVEN) == "11"
				cXTpVen		:= "11 - Itens Faltantes"			
			Case Alltrim(SC5->C5_XTPVEN) == "12"
				cXTpVen		:= "12 - SAC"			
			Case Alltrim(SC5->C5_XTPVEN) == ""
				cXTpVen		:= ""				
		EndCase
		
	Else
		dEmiss		:= CTOD("  /  /  ")
		cVend1		:= ""		
	Endif
	
	IIF(lAtraso,cAtraso	:= "Sim",cAtraso := "Nao")
	IIF(lPronta,cPronta := "Sim",cPronta := "Nao")

    If lPosB1
		cTipo	 := SB1->B1_TIPO
		cLocal	 := SB1->B1_LOCPAD
		nSldEst	 := SB2->B2_QATU
		If MV_PAR03 == 1
			cDesc	:= SB1->B1_DESC
		Endif
    Endif

	If lPosA1
		SA1->A1_NOME
		SA1->A1_EST
	Endif
	If lPosB5 .And. MV_PAR03 == 2
		cDesc	:= SB5->B5_CEME
	Endif

	oReport:IncMeter()
	oReport:Section(1):PrintLine()

	(cAliasQry)->(dbSkip())
End
	
dbSelectArea(cAliasQry)

oReport:SetLandScape()
oReport:Section(1):Finish()

(cAliasQry)->(DbCloseArea())

Return                          
