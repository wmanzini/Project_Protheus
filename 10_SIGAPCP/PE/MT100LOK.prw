User Function MT100LOK()
Local lRet := .T.

    // Ponto de chamada Conex�oNF-e sempre como primeira instru��o.
    lRet := U_GTPE004()

    // Restri��o para valida��es n�o serem chamadas duas vezes ao utilizar o importador da Conex�oNF-e,
    // mantendo a chamada apenas no final do processo, quando a variavel l103Auto estiver .F.
    //If lRet .And. !FwIsInCallStack('U_GATI001') .Or. IIf(Type('l103Auto') == 'U',.T.,!l103Auto)
    //    If
    //        Regra existente
    //        [...]
    //    EndIf
    //EndIf

Return lRet
