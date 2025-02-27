#Include 'Protheus.ch'

//+---------------------------------------------------------------------------------
//	Respons�vel pelo preenchimento dos campos customizados do or�amento de vendas
//	para o pedido de venda ao "Aprovar Venda"
//
//	Chamada do ponto de entrada MTA416PV
//+---------------------------------------------------------------------------------
User Function M05A05(_nItem)

cTeste := '2' 

	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLUTAB'})] 	:= SCK->CK_XVLUTAB
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLUTAB'})] 	:= SCK->CK_XVLUTAB
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLUBRU'})] 	:= SCK->CK_XVLUBRU
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLUIPI'})] 	:= SCK->CK_XVLUIPI
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLUICM'})] 	:= SCK->CK_XVLUICM
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLUPS2'})] 	:= SCK->CK_XVLUPS2
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLUCF2'})] 	:= SCK->CK_XVLUCF2
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLUICO'})] 	:= SCK->CK_XVLUICO
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLUICD'})] 	:= SCK->CK_XVLUICD
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLUFCP'})] 	:= SCK->CK_XVLUFCP
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLUSOL'})] 	:= SCK->CK_XVLUSOL
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLUIMP'})] 	:= SCK->CK_XVLUIMP
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLULIQ'})] 	:= SCK->CK_XVLULIQ
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XALQIPI'})] 	:= SCK->CK_XALQIPI
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XALQICM'})] 	:= SCK->CK_XALQICM
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XALQPS2'})] 	:= SCK->CK_XALQPS2
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XALQCF2'})] 	:= SCK->CK_XALQCF2
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XALQICO'})] 	:= SCK->CK_XALQICO
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XALQICD'})] 	:= SCK->CK_XALQICD
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XALQFCP'})] 	:= SCK->CK_XALQFCP
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XALQSOL'})] 	:= SCK->CK_XALQSOL
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XALQIMP'})] 	:= SCK->CK_XALQIMP
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLTIPI'})] 	:= SCK->CK_XVLTIPI
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLTICM'})] 	:= SCK->CK_XVLTICM
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLTPS2'})] 	:= SCK->CK_XVLTPS2
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLTCF2'})] 	:= SCK->CK_XVLTCF2
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLTICO'})] 	:= SCK->CK_XVLTICO
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLTICD'})] 	:= SCK->CK_XVLTICD
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLTFCP'})] 	:= SCK->CK_XVLTFCP
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLTSOL'})] 	:= SCK->CK_XVLTSOL
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLTIMP'})] 	:= SCK->CK_XVLTIMP
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XVLTBRU'})] 	:= SCK->CK_XVLTBRU
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XACRESC'})] 	:= SCK->CK_XACRESC
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XITEMP '})] 	:= SCK->CK_XITEMP
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_DESCONT'})] 	:= SCK->CK_XDESCON
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XACRESC'})] 	:= SCK->CK_XACRESC
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_VALDESC'})] 	:= 0
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XINSTA '})] 	:= SCK->CK_XINSTA
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XOPER  '})] 	:= SCK->CK_XOPER
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_ENTREG '})] 	:= SCK->CK_ENTREG
	_aCols[_nItem][AScan(_aHeader,{|x,y|x[2] == 'C6_XITEMOR'})] 	:= SCK->CK_ITEM

	M->C5_XACRESC  := SCJ->CJ_XACRESC
	M->C5_XTPVEN   := SCJ->CJ_XTPVEN
	M->C5_XFINAME  := SCJ->CJ_XFINAME
	M->C5_XOBRAS   := SCJ->CJ_XOBRAS
	M->C5_XINFOR   := SCJ->CJ_XINFOR
	M->C5_XHIST    := SCJ->CJ_XHIST
	M->C5_XDTENC   := SCJ->CJ_XDTENC
	M->C5_XEMAILC  := SCJ->CJ_XEMAILC
	M->C5_XEMAILF  := SCJ->CJ_XEMAILF
	M->C5_VEND1    := SCJ->CJ_XVEND1
	M->C5_XFRETE   := SCJ->CJ_XFRETE
	M->C5_XINSTA   := SCJ->CJ_XINSTA
	M->C5_FECENT   := SCJ->CJ_XFECENT
	M->C5_XTPINST  := SCJ->CJ_XTPINST
	M->C5_XVLINST  := SCJ->CJ_XVLINST
	M->C5_XDESPAG  := SCJ->CJ_XDESPAG
	M->C5_TPFRETE  := SCJ->CJ_XTFRETE
	M->C5_XNUNORC  := SCJ->CJ_NUM
	M->C5_XANEXOO  := SCJ->CJ_XANEXO
	M->C5_XPLANTA  := SCJ->CJ_XPLANTA
	M->C5_XPEDCEN  := SCJ->CJ_XPEDCEN
	M->C5_XPRZEMB  := SCJ->CJ_XPRZEMB
	M->C5_XRT	   := SCJ->CJ_XRT // #2390 - % Responsavel Tec
	M->C5_XCRED    := IIF(SCJ->CJ_XCRED == '2','1',' ')
	M->C5_XCOTCLI  := IIF(AllTrim(SCJ->CJ_COTCLI) == '.',Space(TamSX3('C5_XCOTCLI')[1]),SCJ->CJ_COTCLI)
	// Efetua libera��o financeira para o cliente Arcos Dourados.
//	M->C5_XSTSFIN  := IIF(SCJ->CJ_CLIENTE == '002953' .Or. SCJ->CJ_CLIENTE == '000001','2','1')
	M->C5_XSTSFIN  := IIF(SCJ->CJ_CLIENTE == AllTrim(GetMv("AM_CLIMCD")),'2','1')

	M->C5_ACRSFIN  := Posicione('SE4',1, xFilial('SE4') + SCJ->CJ_CONDPAG,'E4_ACRSFIN') // Solu��o alternativa at� a Totvs enviar corre��o - N�o est� carregando o acrescimo financeiro para o pedido de venda
Return
