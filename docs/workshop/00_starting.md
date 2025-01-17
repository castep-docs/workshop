
# Getting Started

## Settting up the Virtual Workspace

### Signing up to the STFC Training Workspace

Open a browser and navigate to the link you have been emailed  - the one that contains training.analysis.stfc.ac.uk.

This should prompt you for some information and it will then send your account for authorisation. 

Once the account is authorised, you will recieve and email with a link to login. 

### Creating the CASTEP Workspace

You should recieve an email with a link that you can use to connect to the STFC system. Save this email as you will use it to login during the training. 

Select New Workspace and then select CASTEP TRAINING WORKSHOP 2024 and click create workspace. This will generate you a virtual desktop on the STFC cloud service with access to CASTEP.

## Connecting to and using the virtual desktop

Mouse over the workspace and you should be presented with buttons to launch the workspace in either a new tab or new window.  

This should open a new window and load a virtual desktop within the browser. This is a linux desktop with CASTEP and several other useful tools available. 

### Uploading and downloading files from your laptop
To upload or download any files from your laptop to the VM, navigate to <https://training.analysis.stfc.ac.uk/data/>, click on Data (left hand menu) and then select Home - that's your home directory where you can upload files to.   

### Copying and pasting from your laptop

To enable copying and pasting between your laptop and the VM, hover your mouse at the top of the virtual desktop and click on Copy & Paste to enable this.  

## Loading CASTEP

Click the applications button in the bottom left and select software -> CASTEP. This will launch a terminal with shortcuts for running CASTEP. 

!!! note
    You will have to run this additional command to load aliases to run CASTEP and its tools on the VM:

    ```$ source /course_materials/vm_aliases.sh```

### Accessing the CASTEP help system

To search the castep help system for keywords containing castep:

`castep.serial -s lattice`

To view detailed information on a particular keyword:

`castep.serial -h lattice_abc`

### Running CASTEP

To run castep in serial with Si2 as the seedname, type

```$ castep.serial Si2```

To run castep in parallel using 16 core (the maximum for these virutal machines) with same Si2 seedname, type

```$ mpirun -n 16 castep.mpi Si2```


## Tutorial files

The files needed for these tutorials can be found by navigating from Applications -> Data -> Course Materials (that will open up a file browser in the right place). They can also be accessed via the command line from this location: `/course_materials/`. Copy the files to somewhere in your home directory before trying to run CASTEP (you can't run CASTEP in the `/course_materials` directory. You can do that either using the graphical file browser or using the command line. For example:

Make a folder called Si2 in your home directory:

`mkdir ~/Si2`

Then copy in the corresponding tutorial file:

`cp /course_materials/Si2.tar.gz ~/Si2/`


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
* `cp -r alice bob` - copy recursively `alice` to `bob`. You need this if you want to copy whole folders.
* `cp ../myfile ./`  - copy the file `myfile` in the folder below to the current folder
* `cp ~/myfile ./`   - copy the file `myfile` in your home folder to the current folder
* ` mpirun -np 8 castep.mpi diamond`  - submits a castep job with `diamond.cell` and `diamond.param` as inputs onto 8 cores with a time limit of 1 hour

### c2x

This is a handy free program written by Michael Rutter (TCM group Cambridge). It can convert
`castep.cell` and `castep.check` files into various formats eg `.cell`, `.pdb`. (and many other things!)

* `c2x -h`  - list all the options
* `c2x --pdbn castep.cell castep.pdb`
* `c2x --pdbn castep.check castep.pdb`
* `c2x --cell castep.check new.cell`
 (useful at the end of geometry optimisation)
