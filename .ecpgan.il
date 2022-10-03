(let 
  (
    (cellNames 
      (list
        "Q_EPC2001C" "Q_EPC2007C" "Q_EPC2010C" "Q_EPC2012C" "Q_EPC2014C"
        "Q_EPC2015C" "Q_EPC2016C" "Q_EPC2019" "Q_EPC2020" "Q_EPC2021"
        "Q_EPC2022" "Q_EPC2023" "Q_EPC2024" "Q_EPC2029" "Q_EPC2030" "Q_EPC2031"
        "Q_EPC2032" "Q_EPC2033" "Q_EPC2034" "Q_EPC2034C" "Q_EPC2035" "Q_EPC2036"
        "Q_EPC2037" "Q_EPC2038" "Q_EPC2039" "Q_EPC2040" "Q_EPC2045" "Q_EPC2050"
        "Q_EPC2051" "Q_EPC2052" "Q_EPC2053" "Q_EPC2054" "Q_EPC2055" "Q_EPC2059" 
        "Q_EPC2065" "Q_EPC2066" "Q_EPC2067" "Q_EPC2069" "Q_EPC2070" "Q_EPC2071"    
        "Q_EPC2100Q1" "Q_EPC2100Q2" "Q_EPC2101Q1" "Q_EPC2101Q2" "Q_EPC2102Q1"
        "Q_EPC2102Q2" "Q_EPC2103Q1" "Q_EPC2103Q2" "Q_EPC2104Q1" "Q_EPC2104Q2" 
        "Q_EPC2105Q1" "Q_EPC2105Q2" "Q_EPC2106Q1" "Q_EPC2106Q2" "Q_EPC2107Q1" 
        "Q_EPC2107Q2" "Q_EPC2108Q1" "Q_EPC2108Q2" "Q_EPC2108Q3" "Q_EPC2110Q1"
        "Q_EPC2110Q2" "Q_EPC2111Q1" "Q_EPC2111Q2" "Q_EPC2202" "Q_EPC2203" 
        "Q_EPC2204" "Q_EPC2206" "Q_EPC2207" "Q_EPC2212" "Q_EPC2214" "Q_EPC2215"
        "Q_EPC2216" "Q_EPC2218" "Q_EPC2219" "Q_EPC2221Q1" "Q_EPC2221Q2"
        "Q_EPC2302" "Q_EPC7014" "Q_EPC8002" "Q_EPC8004" "Q_EPC8009"  "Q_EPC8010" 
      );list
    )
    (modelNames 
      (list
        "EPC2001C" "EPC2007C" "EPC2010C" "EPC2012C" "EPC2014C"
        "EPC2015C" "EPC2016C" "EPC2019" "EPC2020" "EPC2021"
        "EPC2022" "EPC2023" "EPC2024" "EPC2029" "EPC2030" "EPC2031"
        "EPC2032" "EPC2033" "EPC2034" "EPC2034C" "EPC2035" "EPC2036"
        "EPC2037" "EPC2038" "EPC2039" "EPC2040" "EPC2045" "EPC2050"   
        "EPC2051" "EPC2052" "EPC2053" "EPC2054" "EPC2055" "EPC2059"
        "EPC2065" "EPC2066" "EPC2067" "EPC2069" "EPC2070" "EPC2071" 
        "EPC2100Q1" "EPC2100Q2" "EPC2101Q1" "EPC2101Q2" "EPC2102Q1"
        "EPC2102Q2" "EPC2103Q1" "EPC2103Q2" "EPC2104Q1" "EPC2104Q2"
        "EPC2105Q1" "EPC2105Q2" "EPC2106Q1" "EPC2106Q2" "EPC2107Q1"
        "EPC2107Q2" "EPC2108Q1" "EPC2108Q2" "EPC2108Q3" "EPC2110Q1"
        "EPC2110Q2" "EPC2111Q1" "EPC2111Q2" "EPC2202" "EPC2203"    
        "EPC2204" "EPC2206" "EPC2207" "EPC2212" "EPC2214" "EPC2215" 
        "EPC2216" "EPC2218" "EPC2219" "EPC2221Q1" "EPC2221Q2"
        "EPC2302" "EPC7014" "EPC8002" "EPC8004" "EPC8009" "EPC8010"    
      );list
    )
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

  (foreach (cellName modelName) cellNames modelNames

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
  );foreach
);let