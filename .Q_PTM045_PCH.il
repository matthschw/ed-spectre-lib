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
    (templateCell "PCH4")
    (cellName "Q_PTM045_PCH")
    (modelName "PTM045PCH")
    (oppoints 
      (list 
        "ids" "vgs" "vds" "vbs" "vgd" "vdb" "vgb" "vth" "vdsat" "gm" "gds"
        "gmbs" "betaeff" "cjd" "cjs" "cgg" "cgd" "cgs" "cgb" "cdg" "cdd" "cds"
        "cdb" "csg" "csd" "css" "csb" "cbg" "cbd" "cbs" "cbb" "covlgs" "covlgd"
        "covlgb" "cggbo" "cgdbo" "cgsbo" "cbgbo" "cbdbo" "cbsbo" "cdgbo" "cddbo"
        "cdsbo" "ron" "id" "ig" "is" "ib" "ibulk" "pwr" "gmoverid" "ueff" 
        "rdeff" "rseff" "rgbd" "igidl" "igisl" "igdt" "igd" "igs" "igb" "igbacc"
        "igbinv" "igcs" "igcd" "isub" "gbs" "gbd" "qg" "qd" "qs" "qb" "qjd" 
        "qjs" "qgdovl" "qgsovl" "qgi" "qdi" "qsi" "qbi" "ide" "ige" "ise" "ibe"
        "idb" "isb" "vsb" "gmb" "vgt" "vth_drive" "vdss" "vsat_marg" 
        "vdsat_marg" "self_gain" "rout" "beff" "fug" "ft" "rgate" "vearly"
      );list
    )
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

  (cdfCreateParam
    cdfId
    ?name "w"
    ?prompt "Width"
    ?units "lengthMetric"
    ?defValue "2u"
    ?type "string"
    ?display "artParameterInToolDisplay('w)"
    ?parseAsNumber "yes"
    ?parseAsCEL "yes"
  );cdfCreateParam

  (cdfCreateParam
    cdfId
    ?name "l"
    ?prompt "Length"
    ?units "lengthMetric"
    ?defValue "45n"
    ?type "string"
    ?display "artParameterInToolDisplay('l)"
    ?parseAsNumber "yes"
    ?parseAsCEL "yes"
  );cdfCreateParam

  (cdfCreateParam
    cdfId
    ?name "m"
    ?prompt "Multiplier"
    ?defValue "1"
    ?type "string"
    ?parseAsNumber "yes"
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
      (quote D)
      (quote G)
      (quote S)
      (quote B)
    );list
    termOrder
  );putpropq

  (putpropq
    cdfId->simInfo->spectre
    (list 
      (quote w)
      (quote l)
      (quote m)
    );list
    instParameters
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
      (quote B)
      (quote \:4)
    );list
    termMapping
  );putpropq

  (putpropq
    cdfId->simInfo->spectre
    (foreach mapcar oppoint oppoints
      (list
        oppoint
        (lsprintf "OP(mappedRoot(\"\") \"%s\")" oppoint)
      );list
    );foreach
    opParamExprList
  );putpropq

  (putpropq
    cdfId->simInfo->spectre
    (foreach mapcar oppoint oppoints
      (list
        oppoint
        (lsprintf "OPT(mappedRoot(\"\") \"%s\")" oppoint)
      );list
    );foreach
    optParamExprList
  );putpropq

  (putpropq
    cdfId
    "id gm vth vdsat gmoverid"
    opPointLabelSet
  );putpropq

  (putpropq
    cdfId
    "id gm vth vdsat gmoverid"
    optPointLabelSet
  );putpropq

  (putpropq
    cdfId
    "w l m"
    paramLabelSet
  );putpropq

 (cdfSaveCDF cdfId)
);let
