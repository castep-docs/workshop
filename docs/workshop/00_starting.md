
## Connecting to teaching0

Open a terminal and type:

`ssh -X teaching0`

This should present you with a prompt:

`<username>@teaching0:~$`

### Loading CASTEP
The command

`module load phys/CASTEP`

should load castep into the environment as `castep.mpi`. You can test this with

`castep.mpi -v`


### Loading Vesta
There is an incompatability with the VESTA and CASTEP modules on teaching0.

Instead, open a new terminal and connect again to teaching0 (`ssh -X teaching0`). You can then load the VESTA module with:

`module load vis/VESTA`

and run it:

`VESTA`


## Connecting to young
...


## Editing a file
Edit the diamond.param file (increase the cutoff energy to 400 eV). To do this you will need to use an editor. (for experts `vi` and `emacs` are available). Otherwise I suggest using an editor called `nano`. This has helpful list of instructions are the bottom of the screen (but ask if you are confused!)

`[teaching01@arc-login01 ~]$ nano diamond.param`

Now submit the job again.

Compare the runs at 200 and 400eV. Which took longer? Has the total energy gone up or down. Look at the Atomic Populations section - is it what you expect?

## Summary of useful commands
* `mv`   - rename (or move) a file eg. `mv oldfile newfile`
* `cp`   - copy a file eg. `cp original copy`
* `pwd`   - print current (working) directory
* `mkdir`  - make a new directory (aka folder)
* `nano`   - a file editor eg. `nano filename`. Note you can use this to edit an existing file, or to create a new file. eg `nano mynewfile` will create a new file called `mynewfile`
* `ls`  - list files in the current directory
* `ls -l`  - list files - but give more details than plain `ls`
* `exit`  - to close the terminal when you are finished
* `cp fred/* jim/`  - copy all the files in the folder `fred` into the folder `jim`
* `cp ../myfile ./`  - copy the file `myfile` in the folder below to the current folder
* `cp ~/myfile ./`   - copy the file `myfile` in your home folder to the current folder
* `squeue`  - look at the list of jobs running and queued on the cluster
* `squeue -u teachingXX`  - look at the list of jobs running for the user `teachingXX`
* `mpirun -np 8 castep.mpi diamond`  - submits a castep job with `diamond.cell` and `diamond.param` as inputs onto 8 cores with a time limit of 1 hour

### c2x
This is a handy free program written by Michael Rutter (TCM group Cambridge). It can convert
`castep.cell` and `castep.check` files into various formats eg `.cell`, `.pdb`. (and many other things!)

* `c2x -h`  - list all the options
* `c2x --pdbn castep.cell castep.pdb`
* `c2x --pdbn castep.check castep.pdb`
* `c2x --cell castep.check new.cell`
 (useful at the end of geometry optimisation)
