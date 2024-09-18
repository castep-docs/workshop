We will use cif to cell to generate cell files from cif files. Cif files can be obtained from the [ICSD](https://www.psds.ac.uk/) (inorganic crystals) or the [CSD](https://www.ccdc.cam.ac.uk/structures/) (molecular crystals).

## MgO

Examine the [file](http://www.castep.org/files/MgO.cif). Look at the crystal structure with jmol or [magresview](https://ccp-nc.github.io/magresview-2/) (drag and drop the file onto the magresview window). You will see a cubic face-centre cubic cell. How many atoms in the cell?

Use cif2cell to convert this cif file to a cell file.

```
cif2cell MgO.cif --program=castep -o MgO.cell
```

Look at the cell file. How many atoms in the cell? View this will jmol or magresview. Do you understand what cif2cell has done?


To obtain the conventional unit cell, use the --no-reduce option when running `cif2cell`. Note that `cif2cell` assumes that values such as 0.333333 mean ⅓, and silently corrects the decimal so it corresponds to the machine-precision representation of the fraction, e.g. 0.33333333333, which may not be correct. 

Using the `--export-cif-labels` option ensures that any site labels in the .cif file are used in the .cell file and thereby also in the .castep and .magres files. This is extremely useful for keeping track of equivalent/special sites. For example, you might do:

```
cif2cell --export-cif-labels <seedname>.cif -p castep -o <seedname>.cell
```

A note that some versions of cif2cell use the tag `ID` in the generated .cell file, which is not recognised by CASTEP. In this case, the tag should be changed to `LABEL`. 



## Molecular Tweezers
Examine the [file](http://www.castep.org/files/GUQHUV.cif)
