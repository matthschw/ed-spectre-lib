(let (cellId cdfId)

  (setq cellId (ddGetObj "ED_SPECTRE_LIB" "U_OPAx333"))

  (when (setq cdfId (cdfGetBaseCellCDF cellId))
    (cdfDeleteCDF cdfId)
  );when

  (setq cdfId (cdfCreateBaseCellCDF cellId))

  (cdfCreateParam
    cdfId
    ?name "model"
    ?prompt "Model name"
    ?defValue "OPAx333"
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
      (stringToSymbol "IN+")
      (stringToSymbol "IN-")
      (stringToSymbol "VCC")
      (stringToSymbol "VEE")
      (stringToSymbol "OUT")
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
    (quote subcircuit)
    componentName
  );putpropq 

  (putpropq
    cdfId->simInfo->spectre
    (list 
      nil
      (stringToSymbol "IN+")
      (quote \:1)
      (stringToSymbol "IN-")
      (quote \:2)
      (stringToSymbol "VCC")
      (quote \:3)
      (stringToSymbol "VEE")
      (quote \:4)
      (stringToSymbol "OUT")
      (quote \:5)
    );list
    termMapping
  );putpropq

 	(cdfSaveCDF cdfId)
);let
