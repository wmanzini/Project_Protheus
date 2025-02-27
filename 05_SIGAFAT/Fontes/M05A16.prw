#Include 'Protheus.ch'
#Include 'FwMVCDef.ch'


//+------------------------------------------------------------------------------------------------
//| Cadastro de Sugrupos de produtos
//+------------------------------------------------------------------------------------------------
User Function M05A16()
    Local _oBrowse  := FwMBrowse():New()

    _oBrowse:SetAlias('ZA4')
    _oBrowse:SetDescription('Descri��o Finame')

    _oBrowse:Activate()
Return

//+------------------------------------------------------------------------------------------------
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.M05A16' OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.M05A16' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.M05A16' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.M05A16' OPERATION 5 ACCESS 0
Return aRotina


//+------------------------------------------------------------------------------------------------
Static Function ModelDef()
    Local oStruZA4 := FWFormStruct( 1, 'ZA4', /*bAvalCampo*/,/*lViewUsado*/ )
    Local oModel

    oModel := MPFormModel():New('M05A14M', /*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/, /*bCancel*/ )
    oModel:AddFields( 'ZA4MASTER', /*cOwner*/, oStruZA4, /*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )
    oModel:SetDescription( 'Descri��o Finame' )

    oModel:GetModel( 'ZA4MASTER' ):SetDescription( 'Dados da Descri��o Finame' )

Return oModel

//+------------------------------------------------------------------------------------------------
Static Function ViewDef()
    Local oModel   := FWLoadModel( 'M05A16' )
    Local oStruZA4 := FWFormStruct( 2, 'ZA4' )
    Local oView
    Private cCampos := {}

    oView := FWFormView():New()

    oView:SetModel( oModel )
    oView:AddField( 'VIEW_ZA4', oStruZA4, 'ZA4MASTER' )

    oView:CreateHorizontalBox( 'TELA' , 100 )
    oView:SetOwnerView( 'VIEW_ZA4', 'TELA' )
Return oView
