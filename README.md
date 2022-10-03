# Electronics & Drives Spectre Circuit Simulation Model Library

This repository contains the Cadence Virtuoso library *ED_SPECTRE_LIB*.
This library contains several devices (transistors, opamps, etc.).
You can instantiate them in your schematic and simulate them in the
Analog Design Environment (ADE).

The license holders of the models that are shipped with this repository
are annotated in the corresponding model files.

## Devices

The devices described below are available in the library:

- [U_OPAx333](https://www.ti.com/product/OPA333#design-tools-simulation), added 30.09.22

  Changed T_ABS=-273.15 to -273.149999999, because T=0K leads to errors
  
- [Q_EPC2001C](https://epc-co.com/epc/products/gan-fets-and-ics/epc2001c), added 03.10.22

- [Q_EPC2007C](https://epc-co.com/epc/products/gan-fets-and-ics/epc2007c), added 03.10.22

- [Q_EPC2010C](https://epc-co.com/epc/products/gan-fets-and-ics/epc2010c), added 03.10.22

- [Q_EPC2012C](https://epc-co.com/epc/products/gan-fets-and-ics/epc2012c), added 03.10.22

- [Q_EPC2014C](https://epc-co.com/epc/products/gan-fets-and-ics/epc2014c), added 03.10.22

- [Q_EPC2015C](https://epc-co.com/epc/products/gan-fets-and-ics/epc2015c), added 03.10.22

- [Q_EPC2016C](https://epc-co.com/epc/products/gan-fets-and-ics/epc2016c), added 03.10.22

- [Q_EPC2019](https://epc-co.com/epc/products/gan-fets-and-ics/epc2019), added 03.10.22

- [Q_EPC2020](https://epc-co.com/epc/products/gan-fets-and-ics/epc2020), added 03.10.22

- [Q_EPC2021](https://epc-co.com/epc/products/gan-fets-and-ics/epc2021), added 03.10.22

- [Q_EPC2022](https://epc-co.com/epc/products/gan-fets-and-ics/epc2022), added 03.10.22

- [Q_EPC2023](https://epc-co.com/epc/products/gan-fets-and-ics/epc2023), added 03.10.22

- [Q_EPC2024](https://epc-co.com/epc/products/gan-fets-and-ics/epc2024), added 03.10.22

- [Q_EPC2029](https://epc-co.com/epc/products/gan-fets-and-ics/epc2029), added 03.10.22

- [Q_EPC2030](https://epc-co.com/epc/products/gan-fets-and-ics/epc2030), added 03.10.22

- [Q_EPC2031](https://epc-co.com/epc/products/gan-fets-and-ics/epc2031), added 03.10.22

- [Q_EPC2032](https://epc-co.com/epc/products/gan-fets-and-ics/epc2032), added 03.10.22

- [Q_EPC2033](https://epc-co.com/epc/products/gan-fets-and-ics/epc2033), added 03.10.22

- [Q_EPC2034](https://epc-co.com/epc/products/gan-fets-and-ics/epc2034), added 03.10.22

- [Q_EPC2034C](https://epc-co.com/epc/products/gan-fets-and-ics/epc2034c), added 03.10.22

- [Q_EPC2035](https://epc-co.com/epc/products/gan-fets-and-ics/epc2035), added 03.10.22

- [Q_EPC2036](https://epc-co.com/epc/products/gan-fets-and-ics/epc2036), added 03.10.22


## Setup

Please follow the steps described in this subsection to register this library
with your Virtuoso session.

Clone this repository first.
Point the environment variable `ED_SPECTRE_LIB` to this repository

```bash
export ED_SPECTRE_LIB=<path>
```

Define the library in your `cds.lib` with

```
DEFINE ED_SPECTRE_LIB $ED_SPECTRE_LIB/ED_SPECTRE_LIB
```

In addition you must add the command

```lisp
(envSetVal
  "spectre.envOpts" 
  "modelFiles" 
  (quote string)
  (strcat
    (envGetVal "spectre.envOpts" "modelFiles")
    " $ED_SPECTRE_LIB/models/models.scs"
  );strcat
);envSetVal
```

to your `.cdsinit`.