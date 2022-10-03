(let 
  (
    (cellName "Q_EPC2040")
    (modelName "EPC2040")
    src
    srcList
    dest
    destList
    (libName "ED_SPECTRE_LIB")
    (templateCell "TEMPLATE_GAN")
    cellId
    cdfId
    /*
    (oppoints
      (list
        (list "rg" "rg" "res")
        (list "rd" "rd" "res")
        (list "rs" "rs" "res")
        (list "ids" "gswitch" "i")
        (list "igs" "ggsdiode" "i")
        (list "igd" "ggddiode" "i")
        (list "cgs" "C_GS" "cap")
        (list "cgs1" "G_CGS1" "cap")
        (list "cgd" "C_GD" "cap")
        (list "cgd1" "G_CGD1" "cap")
        (list "csd" "C_SD" "cap")
        (list "csd1" "G_CSD1" "cap")
      );list
    )
    (volts
      (list
        (list "gate" "gate")
        (list "drain" "drain")
        (list "source" "source")
      );list
    )
    */
  )

  (setq srcList (gdmCreateSpecList))
  (setq src (gdmCreateSpec libName templateCell "" "" "CDBA" 0))
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
    ?display "artParameterInToolDisplay('model)"
    ?editable "nil"
    ?type "string"
    ?parseAsCEL "yes"
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
      (stringToSymbol "G")
      (stringToSymbol "D")
      (stringToSymbol "S")
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

  /*
  (putpropq
    cdfId->simInfo->spectre
    (quote port)
    current
  );putpropq 

  (putpropq
    cdfId->simInfo->spectre
    "Q"
    namePrefix
  );putpropq 
  */ 

  (putpropq
    cdfId->simInfo->spectre
    (list 
      nil
      (stringToSymbol "G")
      (quote \:1)
      (stringToSymbol "D")
      (quote \:2)
      (stringToSymbol "S")
      (quote \:3)
    );list
    termMapping
  );putpropq

  /*
  (putpropq
    cdfId->simInfo->spectre
    (append
      (foreach mapcar oppoint oppoints
        (list
          (car oppoint)
          (lsprintf 
            "OP( mappedRoot(\".%s\") \"%s\" )" 
            (cadr oppoint)
            (caddr oppoint)
          );lsprintf
        );list
      );foreach
      (foreach mapcar volt volts
        (list
          (car volt)
          (lsprintf 
            "VDC( mappedRoot(\".%s\") )"
            (cadr volt)
          );lsprintf
        );list
      );foreach      
    ;);append
    opParamExprList
  );putpropq

  (putpropq
    cdfId->simInfo->spectre
    (append
      (foreach mapcar oppoint oppoints
        (list
          (car oppoint)
          (lsprintf 
            "OPT( mappedRoot(\".%s\") \"%s\" )" 
            (cadr oppoint)
            (caddr oppoint)
          );lsprintf
        );list
      );foreach
      (foreach mapcar volt volts
        (list
          (car volt)
          (lsprintf 
            "VT(mappedRoot(\".%s\"))"
            (cadr volt)
          );lsprintf
        );list
      );foreach
    );append
    optParamExprList
  );putpropq
  */

  (cdfSaveCDF cdfId)
);let