(let (cellId cdfId)

  (setq cellId (ddGetObj "ED_SPECTRE_LIB" "U_OPA847"))

  (when (setq cdfId (cdfGetBaseCellCDF cellId))
    (cdfDeleteCDF cdfId)
  );when

  (setq cdfId (cdfCreateBaseCellCDF cellId))

  (cdfCreateParam
    cdfId
    ?name "model"
    ?prompt "Model name"
    ?defValue "OPA847_Model"
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
      (stringToSymbol "DIS")
      (stringToSymbol "OUT")
      (stringToSymbol "VCC")
      (stringToSymbol "VEE")
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
      (stringToSymbol "DIS")
      (quote \:3)
      (stringToSymbol "OUT")
      (quote \:4)    
      (stringToSymbol "VCC")
      (quote \:5)
      (stringToSymbol "VEE")
      (quote \:6)
    );list
    termMapping
  );putpropq

 	(cdfSaveCDF cdfId)
);let