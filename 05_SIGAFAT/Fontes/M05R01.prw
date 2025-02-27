#Include 'Protheus.ch'

//+-----------------------------------------------------------------------------------------------------
//| Relatorio de produtos por data de cadastro
//+-----------------------------------------------------------------------------------------------------
User Function M05R01()
    Local _oReport      := Nil
    Local _cPerg        := 'M05R01   '

    MR05PutSX1(_cPerg)

    If FindFunction('TRepInUse') .And. TRepInUse(.F.)    //verifica se relatorios personalizaveis esta disponivel
        If Pergunte(_cPerg, .T.)
            _oReport := MR05Def(_oReport, _cPerg)
            _oReport:PrintDialog()
        EndIf
    EndIf
Return

//+-----------------------------------------------------------------------------------------------------
Static Function MR05Def(_oReport, _cPerg)
    Local _cTitle   := 'Relatório data de cadastro de produtos'
    Local _cHelp    := 'Relatório data de cadastro de produtos'
    Local _cAlias   := GetNextAlias()
    Local _oSection1          := Nil

    _oReport    := TReport():New('M05R01   ',_cTitle,_cPerg,{|_oReport| MR05Print(_oReport,_cAlias)},_cHelp)

    //+-------------------------------------------
    //| Secao dos itens do Pedido de Vendas
    //+-------------------------------------------
    _oSection1 := TRSection():New(_oReport,'PRODUTOS',{_cAlias})

    TRCell():New(_oSection1,'PRODUTO'                   , _cAlias)
    TRCell():New(_oSection1,'TIPO'                      , _cAlias)
    TRCell():New(_oSection1,'DESCRICAO'                 , _cAlias)
    TRCell():New(_oSection1,'MODELO'                    , _cAlias)

    TRCell():New(_oSection1,'DATA_CADASTRO'             , _cAlias)
    TRCell():New(_oSection1,'USUARIO_CADASTRO'          , _cAlias)
    TRCell():New(_oSection1,'DATA_ULTIMA_ALTERACAO'     , _cAlias)
    TRCell():New(_oSection1,'USUARIO_ULTIMA_ALTERACAO'  , _cAlias)


    _oSection1:oReport:cFontBody          := 'Calibri'
    _oSection1:oReport:nFontBody          := 11

Return(_oReport)

//+-----------------------------------------------------------------------------------------------------
Static Function MR05Print(_oReport,_cAlias)
    
    Local _cData            := ''
    Local _dData            := CToD('  /  /  ')
    Private _oSection         := _oReport:Section(1)
    Private _cChave           := ''

    _oReport:Section(1):Init()
    _oReport:IncMeter()

    MR05GetSB1(_cAlias,_oReport)
    //+-------------------------------------------
    //| Inicio da impressao
    //+-------------------------------------------

    While !_oReport:Cancel() .And. (_cAlias)->(!EOF())
        SB1->(DbGoTo( (_cAlias)->B1_RECNO ))

        _cData := FWLeUserlg( 'B1_USERLGI',2 )
        _dData := CToD(_cData,'DD/MM/YYYY')

        If MV_PAR03 <= _dData .And. _dData <= MV_PAR04
            _oReport:Section(1):Cell('DATA_CADASTRO'                ):SetBlock( {|| _cData})
            _oReport:Section(1):Cell('USUARIO_CADASTRO'             ):SetBlock( {|| FWLeUserlg( 'B1_USERLGI',1 )})
            _oReport:Section(1):Cell('DATA_ULTIMA_ALTERACAO'        ):SetBlock( {|| FWLeUserlg( 'B1_USERLGA',2 )})
            _oReport:Section(1):Cell('USUARIO_ULTIMA_ALTERACAO'     ):SetBlock( {|| FWLeUserlg( 'B1_USERLGA',1 )})

            _oReport:Section(1):PrintLine()
        EndIf

        _oReport:IncMeter()
        (_cAlias)->(DbSkip())
    EndDo

    _oReport:Section(1):Finish()

    (_cAlias)->(dbCloseArea())
return

//+-----------------------------------------------------------------------------------------------------
Static Function MR05GetSB1(_cAlias,_oReport)
    Local _nTotal           := 0

    BeginSQL Alias _cAlias
        SELECT   B1_COD         AS PRODUTO
                ,B1_TIPO        AS TIPO
                ,B1_DESC        AS DESCRICAO
                ,B1_MODELO      AS MODELO
                ,B1_USERLGI
                ,B1_USERLGA
                ,SB1.R_E_C_N_O_ AS B1_RECNO
        FROM %Table:SB1% SB1
        WHERE   SB1.%NotDel%
            AND B1_COD BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
            ORDER BY B1_COD
    EndSql

    // Atualiza regua de processamento
    (_cAlias)->( dbEval( {|| _nTotal++ } ) )
    (_cAlias)->( dbGoTop() )

    _oReport:SetMeter(_nTotal)
Return

//+-----------------------------------------------------------------------------------------------------
Static Function MR05PutSX1(_cPerg)
    Local _aAreaSX1     := SX1->(GetArea())

    SX1->(DbGoTop())
    SX1->(DbSetOrder(1))

    If !SX1->(DbSeek(_cPerg))
        PutSX1(_cPerg,'01','Produto De ?'        ,'Produto De ?'            ,'Produto De ?'         ,'mv_ch1','C',TamSX3('B1_COD')[1],0, ,'G','','SB1',,,'mv_par01',,,,Space(TamSX3('B1_COD')[1]))
        PutSX1(_cPerg,'02','Produto Ate ?'       ,'Produto Ate ?'           ,'Produto Ate ?'        ,'mv_ch2','C',TamSX3('B1_COD')[1],0, ,'G','NaoVazio()','SB1',,,'mv_par02',,,,Replicate('Z',TamSX3('B1_COD')[1]))
        PutSX1(_cPerg,'03','Data De ?'          ,'Data De ?'                ,'Data De ?'            ,'mv_ch3','D',08,0, ,'G','NaoVazio()','   ',,,'mv_par03',,,,)
        PutSX1(_cPerg,'04','Data Ate ?'         ,'Data Ate ?'               ,'Data Ate ?'           ,'mv_ch4','D',08,0, ,'G','NaoVazio()','   ',,,'mv_par04',,,,)
    EndIf

    RestArea(_aAreaSX1)

Return

//+-----------------------------------------------------------------------------------------------------
