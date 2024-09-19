

# Introduction

In this practical, we will demonstrate some of the machine learning techniques that can accelerate CASTEP calculations. 

In particular, we will use the on-the-fly (OTF) Gaussian Approximation Potential(GAP) toolset to dynamically learn energies and forces as we perform a molecular dynamics simulation. These are often quite large and expensive calculations involving many atoms and these are often in unusual configurations. 

Gaussian approximation potential (GAP) is a machine learning approach to interpolating interatomic potential energy surfaces, based on Gaussian process regression. This scheme allows us to both predict the total energy, as well as get an estimate of the uncertainty. Further details of the GAP methodology are given [here](https://libatoms.github.io/GAP/). GAP is implemented as part of a the general purpose QUIP package for accelerating molecular dynamics simulations. 

In particular, GAP/QUIP have been integrated directly with CASTEP. This means that the workflow can be controlled by adding a few lines to the CASTEP input files.

# GAP MD Workflow

In this tutorial, we will train a model from scratch. Initially, CASTEP will do a number of DFT steps to get some training data. `gap_fit` is then called to train a model with the DFT energies and forces. This is then used to compute the next MD steps. 

After a set number of steps, or if the GAP predicts are large uncertainty, CASTEP will perform another DFT calculation and check the quality of the model. If the DFT and GAP results disagree, the model will be retrained.

# Silicon Carbide Example

## DFT MD Simulation

We will perform a silicon carbide molecular dynamics calculation. An example unit cell is given here:

    %BLOCK LATTICE_CART
     4.350000  0.000000  0.000000
     0.000000  4.350000  0.000000
     0.000000  0.000000  4.350000
    %ENDBLOCK LATTICE_CART
    
    %BLOCK POSITIONS_ABS
    Si  0.000000  0.000000  0.010000
     C  1.087500  1.087500  1.087500
    Si  0.000000  2.175000  2.175000
     C  1.087500  3.262500  3.262500
    Si  2.175000  0.000000  2.175000
     C  3.262500  1.087500  3.262500
    Si  2.175000  2.175000  0.000000
     C  3.262500  3.262500  1.087500
    %ENDBLOCK POSITIONS_ABS

    kpoint_mp_grid 4 4 4

We will perform an MD simiulation with the following param file:
    cut_off_energy = 200 eV
    elec_energy_tol = 0.0001 eV
    finite_basis_corr = 0
    fix_occupancy = true
    backup_interval = 0
    calculate_stress = true
    popn_calculate   = false
    write_checkpoint = none
    task = molecular dynamics
    
    # These settings make sure that forces printed in .md have no thermostat contribution
    md_ensemble = NVT
    md_thermostat = NOSE-HOOVER
    md_barostat   = Parrinello-Rahman
    md_ion_t = 500 fs
    md_cell_t = 2000 fs
    md_delta_t = 2 fs
    md_num_iter = 50
    md_temperature = 75 K
    md_sample_iter = 10

Save these files as `SiC.cell` and `SiC.param`. These set up a standard non-ML calculation. Run this calculation and observe the time taken
`castep-gap castep.mpi SiC`

## GAP MD Simulation

To enable the GAP OTF learning, we must add a section to the param file. First copy the param and cell files to a new folder and add the following section to `SiC.param`. 
    %BLOCK DEVEL_CODE
      ! generally turns on PP, this is needed together with "PP_HYBRID=T"
      PP=T
      MD: PP=T :ENDMD
    
      ! settings of model called through QUIP
      pp:
          QUIP=T
          QUIP_PARAM_FILE=GAP.xml
          quip_init_args:IP GAP:endquip_init_args
      :endpp
    
      ! settings of PP Hybrid
      PP_HYBRID=T
      pp_hybrid_exec:
        hybrid-md
      :endpp_hybrid_exec
    %ENDBLOCK DEVEL_CODE

This tells CASTEP to use the GAP and the QUIP library to compute energies and forces. It also tells CASTEP the script that it should call to check whether the model is retrained (`hybrid-md`). This is a python script which the user can override and this allows the functionality to be much more flexible.  

Add this section to your param file and re-run this calculation and observe the total time taken:
`castep-gap castep.mpi SiC`

As this calculation progresses, `hybrid-md` prints some information on whether it decided to retrain the GAP model at each MD step. You can see that some steps take longer than others and these are the steps where a DFT calculation has been performed.


# Further Examples

Thses techniques are used further in the [Genetic Algorithm tutorial](11_GA.md) to help accelerate these large calculations. 





