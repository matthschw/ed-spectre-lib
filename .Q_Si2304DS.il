(let 
  (
    libId
    cellId
    cdfId
    src
    srcList
    dest
    destList
    (libName "ED_SPECTRE_LIB")
    (templateLib "CELL_TEMPLATES")
    (templateCell "NCH3")
    (cellName "Q_Si2304DS")
    (modelName "SI2304DS")
  )

  (setq srcList (gdmCreateSpecList))
  (setq src (gdmCreateSpec templateLib templateCell "" "" "CDBA" 0))
  (gdmAddSpecToSpecList src srcList)

  (setq destList (gdmCreateSpecList))
  (setq dest (gdmCreateSpec libName cellName "" "" "CDBA" 0))
  (gdmAddSpecToSpecList dest destList)

  (ccpCopy
    srcList
    destList
    t
    'CCP_EXPAND_ALL
    '(schematicSymbol)
    nil
  );ccpCopy

  (setq cellId (ddGetObj libName cellName))

  (when (setq cdfId (cdfGetBaseCellCDF cellId))
    (cdfDeleteCDF cdfId)
  );when

  (setq cdfId (cdfCreateBaseCellCDF cellId))

  (cdfCreateParam
    cdfId
    ?name "model"
    ?prompt "Model name"
    ?defValue modelName
    ?type "string"
    ?display "artParameterInToolDisplay('model)"
    ?parseAsCEL "yes"
    ?editable "nil"
  );cdfCreateParam

  (putpropq
    cdfId
    (list nil)
    simInfo
  );putpropq

  (putpropq
    cdfId->simInfo
    (list nil)
    spectre
  );putpropq

  (putpropq
    cdfId->simInfo->spectre
    (list 
      (quote D)
      (quote G)
      (quote S)
    );list
    termOrder
  );putpropq

  (putpropq
    cdfId->simInfo->spectre
    (list 
      (quote model)
    );list
    otherParameters
  );putpropq

  (putpropq
    cdfId->simInfo->spectre
    (list 
      nil
      (quote D)
      (quote \:1)
      (quote G)
      (quote \:2)
      (quote S)
      (quote \:3)
    );list
    termMapping
  );putpropq

 (cdfSaveCDF cdfId)
);let