#Include 'Protheus.ch'

/*/
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un玢o    � M05C04   � Autor � Cleber Maldonado      � Data � 20/03/18 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Filtro para consulta padr鉶. Retorna somente os contatos   潮�
北�          � relacionados ao cliente informado no pedido de vendas.     潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � #M05C04()                                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北� Uso      � Campo C5_XCONT                                             潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
User Function M05C04()

Local _cFiltro      := ''
Local _cCodCont		:= ''
Local _cAliasCont   := GetNextAlias()
Local _cChave		:= M->C5_CLIENTE+M->C5_LOJACLI

BeginSql Alias _cAliasCont
	SELECT 
		AC8_FILIAL,AC8_FILENT,AC8_ENTIDA,AC8_CODENT,AC8_CODCON
	FROM
		%Table:AC8% AC8
	WHERE
		AC8_CODENT = %Exp:_cChave% AND
		AC8.%NotDel%
EndSql

While (_cAliasCont)->(!EOF())	

	_cCodCont    += "'" + (_cAliasCont)->(AC8_CODCON) + "',"
	
	(_cAliasCont)->(DbSkip())
	 
End

_cFiltro	:= "@U5_CODCONT IN (" + _cCodCont + "' ')"  		
	
Return _cFiltro

