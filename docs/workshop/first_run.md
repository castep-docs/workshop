CASTEP has two main input files, called [the cell file](basic_cell_file.md) and [the param file](basic_param_file.md). The cell file defines the structure of the material (or molecule) you wish to study, and the param file defines the kind of simulation CASTEP should perform.

The cell and param files should be named using the same prefix, which CASTEP calls the "seedname", with the extensions `.cell` and `.param`, respectively. For example, for a calculation called `mytest`, you need the input files
```
mytest.cell
mytest.param
```
and the calculation is run with the command
```
castep.serial mytest
```
The main CASTEP output file will be names using the same seedname and the `.castep` extension, i.e. in the above example it would be called `mytest.castep`. If this file already exists, CASTEP will append its output to it.

When CASTEP completes successfully, it writes additional files such as the `.bib` file, which contains references to key papers for the theory and methods CASTEP used.

If CASTEP encounters a serious problem, it will stop and write an error message to a `.err` file. If you are using the parallel version of CASTEP on many cores, you may see error files from each of these cores. They are named using the same seedname, but with the numeric process ID added, e.g. if CASTEP is run on 2 cores and a serious problem occurs, you might see the files
```
mytest.0001.err
mytest.0002.err
```
These files contain useful information about what went wrong, so it is always worth looking at them. See the [Troubleshooting Guide](../Troubleshooting/troubleshooting.md) for details of how to find and fix common problems.

## Silicon 


```
! Si.cell 
%block lattice_abc
3.8 3.8 3.8
60 60 60
%endblock lattice_abc
!
! Atomic co-ordinates for each species.
! These are in fractional co-ordinates wrt to the cell.
!
%block positions_frac
Si 0.00 0.00 0.00
Si 0.25 0.25 0.25
%endblock positions_frac
!
! Analyse structure to determine symmetry
!
symmetry_generate
!
! Specify M-P grid dimensions for electron wavevectors (K-points)
!
kpoint_mp_grid 4 4 4

```

```
! Si.param 
task            spectral      ! The TASK keyword instructs CASTEP what to do
spectral_task   bandstructure !
xc_functional   LDA           ! Which exchange-correlation functional to use.
cut_off_energy  500 eV        !
opt_strategy    speed         ! Choose algorithms for best speed
```

Copy these files to a directory on the VM (you can copy and paste them)

and the calculation is run with the command
```
castep.serial Si
```

Examine the file Si.castep. Speak to a demonstrator is there is anything you don't understand.



