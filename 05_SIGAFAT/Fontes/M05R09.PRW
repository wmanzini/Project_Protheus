#Include "PROTHEUS.Ch"
#INCLUDE "MATR620.ch"               

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � M05R09   � Autor � Cleber Maldonado      � Data � 30/06/17 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Relat�rio Gerencial de Vendas	                          ���
�������������������������������������������������������������������������Ĵ��
���Uso       � SIGAFAT                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
User Function M05R09()

Local oReport
Private cTpOperacao := SuperGetMV("AM_M05R09")

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
oReport := TReport():New("M05R09","Vendas Gerencial","M05R09", {|oReport| ReportPrint(oReport,cAliasQry,oVenProd)},"Este relatorio emite a relacao gerencial de itens do pedido de venda." + "Ser�o itens do pedido com opera��o igual a " + cTpOperacao) // " 01|02|03|04|05|06|11|12|28|38|39|51|55")
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
oVenProd := TRSection():New(oReport,"GERENCIAL VENDAS",{"SC6","SB1"},/*{Array com as ordens do relat�rio}*/,/*Campos do SX3*/,/*Campos do SIX*/)		// "Relacao de Pedidos por Produto"
oVenProd:SetTotalInLine(.F.)
oVenProd:oReport:cFontBody := "Verdana"
oVenProd:oReport:nFontBody := 10


//������������������������������������������������������������������������Ŀ
//�Define celulas da secao                                                 �
//��������������������������������������������������������������������������
TRCell():New(oVenProd,"FILIAL"		,/*Tabela*/	,"Filial"			 ,PesqPict("SC6","C6_FILIAL")	,TamSx3("C6_FILIAL")[1]		,/*lPixel*/,{|| cFil	})				// Filial do Sistema
TRCell():New(oVenProd,"NUMPED"		,/*Tabela*/	,"Pedido"	 		 ,PesqPict("SC6","C6_NUM")		,TamSx3("C6_NUM")[1]		,/*lPixel*/,{|| cNum	})				// Numero do Pedido
TRCell():New(oVenProd,"NOTA"		,/*Tabela*/	,"Nota Fiscal"		 ,PesqPict("SC6","C6_NOTA")		,TamSx3("C6_NOTA")[1]		,/*lPixel*/,{|| cNota	})				// Numero da nota fiscal
TRCell():New(oVenProd,"ULTFAT"		,/*Tabela*/ ,"Dt.Ult.Fat."		 ,PesqPict("SC6","C6_DATFAT")	,TamSx3("C6_DATFAT")[1]		,/*lPixel*/,{|| dDatFat })				// Data do Ultimo Faturamento
TRCell():New(oVenProd,"EMISSAO"		,/*Tabela*/	,"Emissao"			 ,PesqPict("SC5","C5_EMISSAO")	,TamSx3("C5_EMISSAO")[1]	,/*lPixel*/,{|| dEmiss	})				// Data de Emiss�o
TRCell():New(oVenProd,"ENTREGA"		,/*Tabela*/	,"Dt.Entrega"		 ,PesqPict("SC6","C6_ENTREG")	,TamSx3("C6_ENTREG")[1]		,/*lPixel*/,{|| dDtEntr	})				// Data de Entrega
TRCell():New(oVenProd,"CODCLI"		,/*Tabela*/ ,"Cod.Cliente"		 ,PesqPict("SC6","C6_CLI")		,TamSx3("C6_CLI")[1]		,/*lPixel*/,{|| cClient })				// C�digo do cliente
TRCell():New(oVenProd,"LOJCLI"		,/*Tabela*/ ,"Loja"				 ,PesqPict("SC6","C6_LOJA")		,TamSx3("C6_LOJA")[1]		,/*lPixel*/,{|| cLojCLi	})				// Loja do Cliente
TRCell():New(oVenProd,"CLIENT"		,/*Tabela*/	,"Razao Social"		 ,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME")[1]		,/*lPixel*/,{|| cNome	})				// Nome do Cliente
TRCell():New(oVenProd,"FANTASIA"	,/*Tabela*/ ,"Nome Fantasia"	 ,PesqPict("SA1","A1_NREDUZ")	,TamSx3("A1_NREDUZ")[1]		,/*lPixel*/,{|| cNomRed })				// Nome Fantasia
TRCell():New(oVenProd,"SEGMENTO"	,/*Tabela*/ ,"Segmento"	 		 ,PesqPict("ZA8","ZA8_DESC")	,TamSx3("ZA8_DESC")[1]		,/*lPixel*/,{|| cNomSeg })				// Segmento de neg�cio do Cliente
TRCell():New(oVenProd,"VEND1"		,/*Tabela*/ ,"Vendedor 1"		 ,PesqPict("SC5","C5_VEND1")	,TamSx3("C5_VEND1")[1]		,/*lPixel*/,{|| cVend1	})				// Cod. Vendedor 1
TRCell():New(oVenProd,"NOMVEND1"	,/*Tabela*/ ,"Nome"				 ,PesqPict("SC5","C5_XVEND1")	,TamSx3("C5_XVEND1")[1]		,/*lPixel*/,{|| cNomVen1})				// Nome do Vendedor 1
TRCell():New(oVenProd,"COMIS1"		,/*Tabela*/	,"% Comissao"		 ,PesqPict("SC5","C5_COMIS1")	,TamSx3("C5_COMIS1")[1]		,/*lPixel*/,{|| nComis1	})				// % Comiss�o Vendedor 1
TRCell():New(oVenProd,"VEND2"		,/*Tabela*/ ,"Vendedor 2"		 ,PesqPict("SC5","C5_VEND2")	,TamSx3("C5_VEND2")[1]		,/*lPixel*/,{|| cVend2	})				// Cod. Vendedor 2
TRCell():New(oVenProd,"NOMVEND2"	,/*Tabela*/ ,"Nome"				 ,PesqPict("SC5","C5_XVEND1")	,TamSx3("C5_XVEND1")[1]		,/*lPixel*/,{|| cNomVen2})				// Nome do Vendedor 2
TRCell():New(oVenProd,"COMIS2"		,/*Tabela*/	,"% Comissao"		 ,PesqPict("SC5","C5_COMIS2")	,TamSx3("C5_COMIS2")[1]		,/*lPixel*/,{|| nComis2	})				// % Comiss�o Vendedor 2
TRCell():New(oVenProd,"VEND3"		,/*Tabela*/ ,"Vendedor 3"		 ,PesqPict("SC5","C5_VEND3")	,TamSx3("C5_VEND3")[1]		,/*lPixel*/,{|| cVend3	})				// Cod. Vendedor 3
TRCell():New(oVenProd,"NOMVEND3"	,/*Tabela*/ ,"Nome"				 ,PesqPict("SC5","C5_XVEND1")	,TamSx3("C5_XVEND1")[1]		,/*lPixel*/,{|| cNomVen3})				// Nome do Vendedor 3
TRCell():New(oVenProd,"COMIS3"		,/*Tabela*/	,"% Comissao"		 ,PesqPict("SC5","C5_COMIS3")	,TamSx3("C5_COMIS3")[1]		,/*lPixel*/,{|| nComis3	})				// % Comiss�o Vendedor 3
TRCell():New(oVenProd,"VEND4"		,/*Tabela*/ ,"Vendedor 4"		 ,PesqPict("SC5","C5_VEND4")	,TamSx3("C5_VEND4")[1]		,/*lPixel*/,{|| cVend4	})				// Cod. Vendedor 4
TRCell():New(oVenProd,"NOMVEND4"	,/*Tabela*/ ,"Nome"				 ,PesqPict("SC5","C5_XVEND1")	,TamSx3("C5_XVEND1")[1]		,/*lPixel*/,{|| cNomVen4})				// Nome do Vendedor 4
TRCell():New(oVenProd,"COMIS4"		,/*Tabela*/	,"% Comissao"		 ,PesqPict("SC5","C5_COMIS4")	,TamSx3("C5_COMIS4")[1]		,/*lPixel*/,{|| nComis4	})				// % Comiss�o Vendedor 4
TRCell():New(oVenProd,"VEND5"		,/*Tabela*/ ,"Vendedor 5"		 ,PesqPict("SC5","C5_VEND5")	,TamSx3("C5_VEND5")[1]		,/*lPixel*/,{|| cVend5	})				// Cod. Vendedor 5
TRCell():New(oVenProd,"NOMVEND5"	,/*Tabela*/ ,"Nome"				 ,PesqPict("SC5","C5_XVEND1")	,TamSx3("C5_XVEND1")[1]		,/*lPixel*/,{|| cNomVen5})				// Nome do Vendedor 5
TRCell():New(oVenProd,"COMIS5"		,/*Tabela*/	,"% Comissao"		 ,PesqPict("SC5","C5_COMIS5")	,TamSx3("C5_COMIS5")[1]		,/*lPixel*/,{|| nComis5	})				// % Comiss�o Vendedor 5
TRCell():New(oVenProd,"GERENCIA"	,/*Tabela*/	,"Gerencia"			 ,PesqPict("SA3","A3_NOME")		,TamSx3("A3_NOME")[1]		,/*lPixel*/,{|| cNomGer })				// Nome Gerente
TRCell():New(oVenProd,"XTPVEN"		,/*Tabela*/ ,"Tipo Venda"		 ,PesqPict("SC5","C5_XTPVEN")	,TamSx3("C5_XTPVEN")[1]		,/*lPixel*/,{|| cXTpVen })	            // Tipo de Venda
TRCell():New(oVenProd,"REDE"        ,/*Tabela*/ ,"Rede"              ,PesqPict("SA1","A1_XREDE")    ,TamSx3("A1_XREDE")[1]      ,/*lPixel*/,{|| cXrede  })              // Rede 
TRCell():New(oVenProd,"ESTADO"		,/*Tabela*/	,"Estado"			 ,PesqPict("SA1","A1_EST")		,TamSx3("A1_EST")[1]		,/*lPixel*/,{|| cEst	})				// Estado
TRCell():New(oVenProd,"CIDADE"		,/*Tabela*/	,"Cidade"			 ,PesqPict("SA1","A1_MUN")		,TamSx3("A1_MUN")[1]		,/*lPixel*/,{|| cCidade	})				// Cidade
TRCell():New(oVenProd,"REGIAO"		,/*Tabela*/	,"Regiao"			 ,PesqPict("SA1","A1_DSCREG")	,TamSx3("A1_DSCREG")[1]		,/*lPixel*/,{|| cDscReg })				// Regi�o
TRCell():New(oVenProd,"ITEM"		,/*Tabela*/ ,"Item"				 ,PesqPict("SC6","C6_ITEM")		,TamSx3("C6_ITEM")[1]		,/*lPixel*/,{|| cItem	})				// Item do Pedido
TRCell():New(oVenProd,"CODIGO"		,/*Tabela*/	,"C�digo"			 ,PesqPict("SC6","C6_PRODUTO")	,TamSx3("C6_PRODUTO")[1]	,/*lPixel*/,{|| cCodigo	})				// C�digo do Produto
TRCell():New(oVenProd,"DESC"		,/*Tabela*/	,"Descri�ao"		 ,PesqPict("SC6","C6_DESCRI")	,TamSx3("C6_DESCRI")[1]		,/*lPixel*/,{|| cDesc	})				// Descri��o do Produto
TRCell():New(oVenProd,"NCM"			,/*Tabela*/ ,"NCM"				 ,PesqPict("SB1","B1_POSIPI")	,TamSx3("B1_POSIPI")[1]		,/*lPixel*/,{|| cNCM	})				// C�digo NCM do Produto
TRCell():New(oVenProd,"FAMILIA"		,/*Tabela*/	,"Familia"			 ,PesqPict("SB1","B1_XFAMILI")	,TamSx3("B1_XFAMILI")[1]	,/*lPixel*/,{|| cXFamil	})				// Familia
TRCell():New(oVenProd,"TIPO"		,/*Tabela*/	,"Tipo"				 ,PesqPict("SB1","B1_TIPO")		,TamSx3("B1_TIPO")[1]		,/*lPixel*/,{|| cTipo	})				// Tipo de Produto
TRCell():New(oVenProd,"UM"			,/*Tabela*/	,"Un.Medida"		 ,PesqPict("SB1","B1_UM")		,TamSx3("B1_UM")[1]			,/*lPixel*/,{|| cUm		})				// Unidade de Medida
TRCell():New(oVenProd,"QUANT"		,/*Tabela*/	,"Quantidade"		 ,PesqPict("SC6","C6_QTDVEN")	,TamSx3("C6_QTDVEN")[1]		,/*lPixel*/,{|| nQuant	})				// Quantidade
TRCell():New(oVenProd,"CFOP"		,/*Tabela*/	,"CFOP"		         ,PesqPict("SC6","C6_CF")	    ,TamSx3("C6_CF")[1]		    ,/*lPixel*/,{|| cCfop	})				// C�digo Fiscal de Opera��o
TRCell():New(oVenProd,"VLRUNIT"		,/*Tabela*/	,"Vlr.Unitario"		 ,PesqPict("SC6","C6_PRCVEN")	,TamSx3("C6_PRCVEN")[1] 	,/*lPixel*/,{|| nPrcVen })				// Valor Unit�rio
TRCell():New(oVenProd,"VLRTOT"		,/*Tabela*/ ,"Vlr. Total"		 ,PesqPict("SC6","C6_VALOR")	,TamSx3("C6_VALOR")[1]		,/*lPixel*/,{|| nVlrTot })				// Valor Total
TRCell():New(oVenProd,"VLRIPI"		,/*Tabela*/	,"Vlr. Total IPI"	 ,PesqPict("SC6","C6_XVLTIPI")	,TamSx3("C6_XVLTIPI")[1]	,/*lPixel*/,{|| nVlrIPI })				// Valor Total de IPI
TRCell():New(oVenProd,"VLRST"		,/*Tabela*/ ,"Vlr. Total ST"	 ,PesqPict("SC6","C6_XVLUSOL")	,TamSx3("C6_XVLTSOL")[1]	,/*lPixel*/,{|| nVlrST	})				// Valor Total de ICMS-ST
TRCell():New(oVenProd,"VLRTIMP"		,/*Tabela*/	,"Vlr. Tot.+ Imp"	 ,PesqPict("SC6","C6_VALOR")	,TamSx3("C6_VALOR")[1]		,/*lPixel*/,{|| nVlrTImp})				// Valor Total + Impostos
TRCell():New(oVenProd,"VLRFRET"		,/*Tabela*/	,"Vlr. Frete"   	 ,PesqPict("SC5","C5_FRETE")	,TamSx3("C5_FRETE")[1]		,/*lPixel*/,{|| nVlrFret})				// Valor do frete no pedido de vendas
TRCell():New(oVenProd,"TPINST"		,/*Tabela*/	,"Tipo. Instal" 	 ,PesqPict("SC5","C5_XTPINST")	,TamSx3("C5_XTPINST")[1]	,/*lPixel*/,{|| cTpInst})
TRCell():New(oVenProd,"VLRINST"		,/*Tabela*/	,"Vlr. Instalacao" 	 ,PesqPict("SC5","C5_XVLINST")	,TamSx3("C5_XVLINST")[1]	,/*lPixel*/,{|| nVlrInst})				// Valor da instala��o no pedido de vendas
TRCell():New(oVenProd,"REFOBRA"		,/*Tabela*/	,"Ref. Obras" 	     ,PesqPict("SC5","C5_XOBRAS")	,TamSx3("C5_XOBRAS")[1]	    ,/*lPixel*/,{|| cXObras })				// Referencia Obras
TRCell():New(oVenProd,"DESCONT1"	,/*Tabela*/	,"Desconto 1" 	     ,PesqPict("SC5","C5_DESC1")	,TamSx3("C5_DESC1")[1]	    ,/*lPixel*/,{|| nDesc1  })				// Desconto 1
TRCell():New(oVenProd,"DESCONT2"	,/*Tabela*/	,"Desconto 2" 	     ,PesqPict("SC5","C5_DESC2")	,TamSx3("C5_DESC2")[1]	    ,/*lPixel*/,{|| nDesc2  })				// Desconto 2
TRCell():New(oVenProd,"DESCONT3"	,/*Tabela*/	,"Desconto 3" 	     ,PesqPict("SC5","C5_DESC3")	,TamSx3("C5_DESC3")[1]	    ,/*lPixel*/,{|| nDesc3  })				// Desconto 3
TRCell():New(oVenProd,"DESCONT4"	,/*Tabela*/	,"Desconto 4" 	     ,PesqPict("SC5","C5_DESC4")	,TamSx3("C5_DESC4")[1]	    ,/*lPixel*/,{|| nDesc4  })				// Desconto 4
TRCell():New(oVenProd,"%DESCONTO"	,/*Tabela*/	,"% Desconto" 	     ,PesqPict("SC6","C6_DESCONT")	,TamSx3("C6_DESCONT")[1]	,/*lPixel*/,{|| nDescitem  })			// % Desconto

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

Local lPosC5	:= .F.
Local lPosA1	:= .F.
Local cPedido   := Space(6)
Local lPrimItem := .F.

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
	
		COLUMN C6_ENTREG	AS DATE
		COLUMN C6_DATFAT	AS DATE
	
		SELECT 
			C6_FILIAL,C6_NUM,C6_ITEM, C6_NOTA,C6_DATFAT,C6_ENTREG,C6_CLI,C6_LOJA,C6_ITEM,C6_PRODUTO,C6_DESCRI,
			C6_CF,C6_QTDVEN,C6_PRCVEN,C6_XVLTIPI,C6_XVLTSOL,C6_XOPER, B1_DESC, B1_TIPO, B1_POSIPI, B1_UM, B1_XFAMILI, C6_DESCONT
		FROM 
			%Table:SC6% SC6, %Table:SC5% SC5, %Table:SB1% SB1 
		WHERE 
			SC6.C6_FILIAL >= %Exp:MV_PAR10% AND
			SC6.C6_FILIAL <= %Exp:MV_PAR11% AND
			SC6.C6_NUM >= %Exp:MV_PAR03% AND
			SC6.C6_NUM <= %Exp:MV_PAR04% AND
			SC6.C6_ENTREG >= %Exp:MV_PAR05% AND
			SC6.C6_ENTREG <= %Exp:MV_PAR06% AND
			SC6.%NotDel% AND

			SC5.C5_FILIAL = SC6.C6_FILIAL AND
			SC5.C5_NUM = SC6.C6_NUM  AND
			SC5.C5_TIPO NOT IN ('D','B') AND
			SC5.C5_EMISSAO >= %Exp:MV_PAR01% AND
			SC5.C5_EMISSAO <= %Exp:MV_PAR02% AND
			SC5.C5_VEND1 BETWEEN %Exp:MV_PAR07% AND %Exp:MV_PAR08% AND
			SC5.%NotDel% AND 

			SB1.B1_FILIAL = '  ' AND
			SB1.B1_COD = SC6.C6_PRODUTO  AND
			SB1.%NotDel%

		ORDER BY SC6.C6_NUM, SC6.C6_ITEM
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
dbSelectArea("SC5")
dbSetOrder(1)
dbSelectArea("SA1")
dbSetOrder(1)
dbSelectArea("SA3")
dbSetOrder(1)
dbSelectArea(cAliasQry)
dbGoTop()

oReport:SetMeter((cAliasQry)->(LastRec()))
oReport:Section(1):Init()

While !oReport:Cancel() .And. !(cAliasQry)->(Eof())

	If !(cAliasQry)->C6_XOPER $cTpOperacao // '01|02|03|04|05|06|11|12|28|38|39|51|55'
		(cAliasQry)->(dbSkip())
		Loop
	Endif		

	If cPedido  == (cAliasQry)->C6_NUM
 		lPrimItem := .F.
	Else
 		lPrimItem := .T.
	EndIf
	cPedido  := (cAliasQry)->C6_NUM

	lPosC5	:= SC5->(MsSeek((cAliasQry)->C6_FILIAL+(cAliasQry)->C6_NUM))
	lPosA1	:= SA1->(MsSeek(xFilial('SA1')+(cAliasQry)->C6_CLI+(cAliasQry)->C6_LOJA))

	If lPosC5
	
		If SC5->C5_EMISSAO < MV_PAR01 .Or. SC5->C5_EMISSAO > MV_PAR02
			(cAliasQry)->(dbSkip())
			Loop			
    	Endif
    	
    	If SC5->C5_VEND1 < MV_PAR07 .Or. SC5->C5_VEND1 > MV_PAR08
			(cAliasQry)->(dbSkip())
			Loop			
		Endif			
		
		If SC5->C5_MSBLQL == '1' .And. MV_PAR09 == 1
			(cAliasQry)->(dbSkip())
			Loop
		Endif

		If SC5->C5_MSBLQL == '2' .And. MV_PAR09 == 2
			(cAliasQry)->(dbSkip())
			Loop
		Endif	    	
		
		lPosA3	:= SA3->(MsSeek(xFilial('SA3')+SC5->C5_VEND1))
    Else
		(cAliasQry)->(dbSkip())
		Loop			    
	Endif

	If lPosA3
		SA3->(MsSeek(xFilial('SA3')+SA3->A3_GEREN))
		cNomGer		:= SA3->A3_NOME
	Else
		cNomGer		:=	" "
	Endif
			
	cFil		:= (cAliasQry)->C6_FILIAL
	cNum		:= (cAliasQry)->C6_NUM
	cNota		:= (cAliasQry)->C6_NOTA
	dDatFat		:= (cAliasQry)->C6_DATFAT
	dDtEntr		:= (cAliasQry)->C6_ENTREG
	cClient		:= (cAliasQry)->C6_CLI
	cLojCLi		:= (cAliasQry)->C6_LOJA
	cItem		:= (cAliasQry)->C6_ITEM
	cCodigo		:= (cAliasQry)->C6_PRODUTO
	cDesc		:= (cAliasQry)->B1_DESC
	cTipo		:= (cAliasQry)->B1_TIPO
	nQuant		:= (cAliasQry)->C6_QTDVEN
	nPrcVen		:= (cAliasQry)->C6_PRCVEN
	nVlrTot		:= (nQuant * nPrcVen)
	nVlrIPI		:= (cAliasQry)->C6_XVLTIPI
	nVlrST		:= (cAliasQry)->C6_XVLTSOL
	nVlrTImp	:= (nVlrTot + nVlrIPI + nVlrST)
	cCfop		:= (cAliasQry)->C6_CF
	nDescitem	:= (cAliasQry)->C6_DESCONT

	If lPosC5
		dEmiss		:= SC5->C5_EMISSAO
		cVend1		:= SC5->C5_VEND1
		cNomVen1	:= Posicione('SA3',1,XFILIAL('SA3') +SC5->C5_VEND1 ,'A3_NOME')		
		nComis1		:= SC5->C5_COMIS1
		cVend2		:= SC5->C5_VEND2
		cNomVen2	:= Posicione('SA3',1,XFILIAL('SA3') +SC5->C5_VEND2 ,'A3_NOME')				
		nComis2		:= SC5->C5_COMIS2
		cVend3		:= SC5->C5_VEND3
		cNomVen3	:= Posicione('SA3',1,XFILIAL('SA3') +SC5->C5_VEND3 ,'A3_NOME')				
		nComis3		:= SC5->C5_COMIS3
		cVend4		:= SC5->C5_VEND4
		cNomVen4	:= Posicione('SA3',1,XFILIAL('SA3') +SC5->C5_VEND4 ,'A3_NOME')				
		nComis4		:= SC5->C5_COMIS4
		cVend5		:= SC5->C5_VEND5
		cNomVen5	:= Posicione('SA3',1,XFILIAL('SA3') +SC5->C5_VEND5 ,'A3_NOME')
		nComis5		:= SC5->C5_COMIS5
		nDesc1		:= SC5->C5_DESC1
		nDesc2		:= SC5->C5_DESC2
		nDesc3		:= SC5->C5_DESC3
		nDesc4		:= SC5->C5_DESC4


	

		//cXTpVen		:= IIF(Alltrim(SC5->C5_XTPVEN) == "1","1 - Projeto","2 - Venda Unitaria")
		If lPrimItem
			nVlrFret    := SC5->C5_FRETE
		Else
			nVlrFret    := 0
		EndIf

		nVlrInst    := SC5->C5_XVLINST
		//cTpInst		:= IIF(SC5->C5_XTPINST== "1","1 - Sem Instalacao","2 - Credenciada")
		cXObras     := SC5->C5_XOBRAS
		
		//U_BusTpVen(cTpVen) //Fun��o para utilizar os tipo de vendas cadastrados no campo C5_XTPVEN

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
				cXTpVen		:= "7 - Venda Pecas"
			Case Alltrim(SC5->C5_XTPVEN) == "8"
				cXTpVen		:= "8 - Sup.Tecnico"
			Case Alltrim(SC5->C5_XTPVEN) == "9"
				cXTpVen		:= "9 - ARE"
			Case SC5->C5_XTPVEN == "10"
				cXTpVen		:= "10 - Serv"
			Case SC5->C5_XTPVEN == "11"
				cXTpVen		:= "11 - Itens Falta"
			Case SC5->C5_XTPVEN == "12"
				cXTpVen		:= "12 - SAC"
			Case SC5->C5_XTPVEN == ""
				cXTpVen		:= ""
		EndCase

		If SC5->C5_XTPINST== "1" 
			cTpInst := "1 - Sem Instalacao"
		ElseIf SC5->C5_XTPINST == "2"
			cTpInst := "2 - Credenciada"
		ElseIf SC5->C5_XTPINST == "3"
			cTpInst := "3 - Macom"
		ElseIf SC5->C5_XTPINST == "4"
			cTpInst := "4 - Macom Rateio Produto"
		Endif
		
	Else
		(cAliasQry)->(dbSkip())
		Loop
	Endif
	
	If lPosA1
		cEst	:= SA1->A1_EST
		cCidade	:= SA1->A1_MUN
		cDscReg	:= SA1->A1_DSCREG
		cNome	:= SA1->A1_NOME
		cNomRed	:= SA1->A1_NREDUZ
		cXrede  := Posicione("ZA6",1,xFilial("ZA6")+SA1->A1_XREDE,"ZA6_DESC")
		cNomSeg := Posicione("ZA8",1,xFilial("ZA8")+SA1->A1_XSEGM,"ZA8_DESC")

		If Empty(cNomSeg)
			cNomSeg := "NAO CADASTRADO"	
		Endif
	Else
		cNomSeg := "NAO CADASTRADO"
	Endif

	cNCM		:= (cAliasQry)->B1_POSIPI
	cXFamil	 	:= Posicione("ZA1",1,xFilial("ZA1")+(cAliasQry)->B1_XFAMILI,"ZA1_DESC")
	cUm		 	:= (cAliasQry)->B1_UM

	oReport:IncMeter()
	oReport:Section(1):PrintLine()

	(cAliasQry)->(dbSkip())
End
	
dbSelectArea(cAliasQry)

oReport:SetLandScape()
oReport:Section(1):Finish()

(cAliasQry)->(DbCloseArea())

Return
