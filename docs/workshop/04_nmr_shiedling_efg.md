# 4 NMR shielding and EFG 

## Part 1

We start running castep calculations by looking at two small systems, and examining the issue of "convergence".

![Fig1. Proton spectrum of ethanol](../img/nmr_tut1.png){width="50%"}
<figure style="display: inline-block;">
  <figcaption style="text-align: left;">Fig1. Proton spectrum of ethanol</figcaption>
</figure>

The discovery that one could actually see chemical shifts in hydrogen
spectra was made in 1951 at Stanford University by Packard, Arnold,
Dharmatti (shown in Fig1.). In this tutorial, we will try to reproduce
this result.



*ethanol.cell*
```

%BLOCK LATTICE_ABC
6 6 6
90 90 90
%ENDBLOCK LATTICE_ABC

%BLOCK POSITIONS_ABS
H 3.980599 4.178342 3.295079
H 5.033394 3.43043 4.504759
H 5.71907 4.552257 3.315353
H 3.720235 5.329505 5.509909
H 4.412171 6.433572 4.317001
H 5.911611 5.032284 6.242202
C 4.84694 4.350631 3.941136
C 4.603025 5.518738 4.882532
O 5.746254 5.812705 5.6871
%ENDBLOCK POSITIONS_ABS

%BLOCK KPOINTS_LIST
0.25 0.25 0.25 1.0
%ENDBLOCK KPOINTS_LIST
```

*ethanol.param* <a name ="ethanol.param"></a>
```
xc_functional   = PBE
fix_occupancy   = true
opt_strategy    = speed
task            = magres
cutoff_energy   = 300 eV
```

Look at the [cell](../../documentation/Input_Files/cell_file.md) and [param](../../documentation/Input_Files/param_file.md) files. Note that the only special part of the `ethanol.param` file is

`task = magres`

Run a standard castep calculation for ethanol. Look at the `ethanol.castep` output file. Towards the end, you should be able to find the isotropic chemical shielding, anisotropy, and asymmetry in a table like this:
<a name="ethanol_result"></a>
 ```
 ====================================================================
 |                      Chemical Shielding Tensor                   |
 |------------------------------------------------------------------|
 |     Nucleus                            Shielding tensor          |
 |  Species            Ion            Iso(ppm)   Aniso(ppm)  Asym   |
 |    H                1               29.45       8.84      0.14   |
 |    H                2               30.10       8.07      0.20   |
 |    H                3               29.94       7.12      0.06   |
 |    H                4               26.83       8.02      0.95   |
 |    H                5               27.24      -7.07      0.90   |
 |    H                6               31.93      13.99      0.46   |
 |    C                1              157.27      33.77      0.70   |
 |    C                2              110.73      69.91      0.42   |
 |    O                1              268.63     -50.78      0.96   |
 ====================================================================

 ```
 Here we are only interested in the isotropic values for the hydrogen atoms


You may also find this information (as well as extra detail) in the file `ethanol.magres`, which contains tables such as
```
============
Atom: H        1
============
H        1 Coordinates      3.981    4.178    3.295   A

TOTAL Shielding Tensor

              30.1276      1.2172      3.7366
               1.9301     27.4802      2.4707
               4.0710      2.2023     30.7511

H        1 Eigenvalue  sigma_xx      26.1030 (ppm)
H        1 Eigenvector sigma_xx       0.3550      0.6810     -0.6405
H        1 Eigenvalue  sigma_yy      26.9119 (ppm)
H        1 Eigenvector sigma_yy       0.6932     -0.6514     -0.3085
H        1 Eigenvalue  sigma_zz      35.3439 (ppm)
H        1 Eigenvector sigma_zz       0.6273      0.3345      0.7033

H        1 Isotropic:       29.4529 (ppm)
H        1 Anisotropy:       8.8365 (ppm)
H        1 Asymmetry:        0.1373
```
for each atom. You can see here that it also gives the same information - the isotropic value for atom 1 is the same. You may note that the isotropic value is the average of the diagonal values in the total shielding tensor.

You might wish to open the `ethanol.magres` with
[MagresView](https://ccp-nc.github.io/magresview-2/).


OBJECTIVES:

* Examine the convergence of the chemical shieldings with planewave cutoff
* Compare to experiment.

INSTRUCTIONS:

* Examine the effect of increasing the cutoff energy (say 200-1000 eV
  in steps of 100 eV). It always helps to plot a graph of the
  convergence (e.g. with gnuplot, xmgrace, excel)

* Find the "converged" hydrogen (or proton in NMR language) shieldings. We will compare them to experiment. The three methyl (CH<sub>3</sub>) protons undergo fast exchange; they "rotate" faster than the nuclear magnetic moment processes. The magnetic moment will therefore "see" an average chemical shielding. The same is true of the CH<sub>2</sub> protons.

* Average the CH<sub>3</sub> and CH<sub>2</sub> chemical shieldings. This will give you 3 unique chemical shieldings.

* We now need to convert the chemical shieldings &#963;<sub>iso</sub> to chemical shifts &#948;<sub>iso</sub> on the experimental scale. We use the relation: &#948;<sub>iso</sub>=&#963;<sub>ref</sub>-&#963;

A suitable &#963;<sub>ref</sub> for 1H is 30.97ppm.


![Fig2. 1H NMR spectrum of liquid ethanol](../img/nmr_tut2.png){width ="300"}
<figure fig1>
  <figcaption>Fig2. 1H NMR spectrum of liquid ethanol</figcaption>
</figure>


* Fig. 2 shows a modern high-resolution 1H spectrum for liquid ethanol. Note that the peaks are split due to J-coupling - the interaction of the 1H magnetic moments - but let's ignore that for now. The three peaks are roughly at 1.2ppm, 3.7ppm and 5ppm. You should find that your computed values agree for two sites. Do you know why the other site has such a large disagreement with experiment?


###Example 2 - Diamond

FILES:

* diamond.cell

```
%block LATTICE_CART
0 1.7 1.7
1.7  0 1.7
1.7 1.7 0
%endblock LATTICE_CART

%block POSITIONS_FRAC
C   0.000000   0.000000   0.000000
C   0.250000   0.250000   0.250000
%endblock POSITIONS_FRAC


kpoints_mp_grid  4 4 4

symmetry_generate
```
* diamond.param

```
comment         = nmr testing
iprint          = 1
xc_functional = LDA
task : magres
fix_occupancy = true
opt_strategy : speed
cut_off_energy  =  500 eV
```

OBJECTIVES:

Examine the convergence of the chemical shielding as the sampling of the electronic Brillouin zone (BZ) is increased.

INSTRUCTIONS:

* Look at the files diamond.cell and diamond.param
* We have specified the kpoints in the cell file using the keyword
`kpoints_mp_grid 4 4 4`
* Run CASTEP for a range of kpoint meshes (say 2,4,6,8,10)
* Examine (plot?) the convergence of the chemical shielding.

The computational cost scales linearly with the number of kpoints (i.e. the number of points in the irreducible Brillouin Zone). For a large unit cell (i.e. a small BZ) it may be possible to get converged results using a single k-point. But which kpoint should we choose?
For diamond we will look at 3 different k-points (0,0,0), (½,½,½) (¼,¼,¼). Specify the kpoint in the cell file using
```
%BLOCK KPOINTS_LIST
0.25 0.25 0.25 1.0
%ENDBLOCK KPOINTS_LIST
```
Which gives a result closest to the converged answer?
(as the diamond unit cell is rather small the 1 kpoint answer is not too close to converged. However, the observation holds true for all orthorhombic cells)

##Part 2

We now look at some more realistic examples.

**Oxygen-17**


Oxygen is a component of many geological materials. Oxygen is
also important element in organic and biological molecules since it is often intimately involved in hydrogen bonding. Solid State ^17^O NMR should be a uniquely valuable probe as the chemical shift range of ^17^O covers almost 1000 ppm in organic molecules. Furthermore ^17^O has spin I = 5/2 and hence a net quadrupole moment. As a consequence of this the solid state NMR spectrum is strongly affected by the electric
field gradient at the nucleus.

Because the isotopic abundance of ^17^O is very low (0.037%) and the NMR linewidths due to the electric field gradient relatively large, only limited Solid State NMR data is
available. This is particularly true for organic materials. First principles calculations of ^17^O NMR parameters have played a vital role in assigning experimental spectra, and developing empirical rules between NMR  parameters and local atomic structure.



### Alanine

#### Examining input and output
We will use the cell file

[alanine.cell](../../tutorials/NMR/alanine/alanine.cell)

!!! Note
    Don't worry about how long/complex it is - it is no different from any other [cell file](../../documentation/Input_Files/cell_file.md) - it just simply defines a large cell

and param file `alanine.param`

```
fix_occupancy = true
opt_strategy : speed
task        = magres
magres_task = nmr
cut_off_energy = 600 eV
xc_functional : PBE
```
Note that the only difference to the previous param files is the line

```
magres_task = nmr
```

This leads to EFG calculations also being performed.


You may also want to view the file

[alanine.pdb](../../tutorials/NMR/alanine/alanine.pdb)


in Vesta or another software - this allows better examination of features like hydrogen bonding. This is the original file downloaded from the [Cambridge Crystallographic Database](https://www.ccdc.cam.ac.uk/) (and was used to obtain the `alanine.cell` file). The cell structure was obtained experimentally by neutron diffraction.

We will now run castep. The `alanine.castep` output file should
contain the both the shielding information and two further columns  - $C_Q$ and $Eta$ - these are both there because an EFG calculation was now performed.

This result is not fully converged (we will not be testing this in this tutorial, but feel free to check), but the relative shift between some of the sites is converged (again you may verify that if inclined).

#### Analysing and comparing to experiment

We will now compare these results with experiment. The figure below is an experimental ^17^O NMR spectrum of L-alanine. It shows 2 peaks, which are very broad due to the quadripolar coupling, and overlap.

![Solid-State O17 NMR spectrum of L-alanine"](../img/nmr_tut3.png){width="40%"}
<figure style="display: inline-block;">
  <figcaption style="text-align: left;">Fig3. Solid-State <sup><small>17</small></sup>O NMR spectrum of L-alanine. (b) is from MAS (magicangle- spinning) (c) is from DOR (double-orientation rotation)</figcaption>
</figure>
 The experimental parameters are given in Table 1 below.
 

* Assign the two resonances A and B. Do all three computed parameters support this assignment?

| Table 1: Experimental ^17^O NMR parameters for alanine. The two resonances are labeled A and B. Isotropic chemical shift &#948;, quadrupolar coupling C<sub>Q</sub>, and EFG asymmetry &#951;<sub>Q</sub>.||
|--|--|
|&#948;(A)-&#948; (B) (ppm)| 23.5|
|C<sub>Q</sub> (A) (MHz)| 7.86|
|&#951;<sub>Q</sub> (A)| 0.28|
|C<sub>Q</sub>(B) (MHz)| 6.53|
|&#951;<sub>Q</sub>(B)| 0.70|



###Example 4 - Silicates Quartz and Cristoballite


#### Input and output files

For quartz we will use the cell file

[quartz.cell](../../tutorials/NMR/silicates/quartz.cell)

And the param file `quartz.param`

```
cut_off_energy  = 600 eV
xc_functional : PBE
fix_occupancy = true
opt_strategy : speed
task        = magres
magres_task = nmr
```

The param file is identical to the alanine one above.

For cristoballite we will use the cell file

[crist.cell](../../tutorials/NMR/silicates/crist.cell)

And exactly the same param file as above (just named `crist.param` instead)



* Compute the chemical shift and Electric field gradient for two silicates.
* Assign the ^17^O NMR spectrum

INSTRUCTIONS:

* The ^17^O parameters for two silicates are reported in Table 2. From the values you compute can you tell which one is quartz? (a suitable &#963;<sub>ref</sub> is 263ppm)


**Table 2**: Experimental ^17^O NMR parameters for two silicates. Isotropic chemical shift &#948; , quadrupolar coupling C<sub>Q</sub>, and EFG asymmetry &#951;<sub>Q</sub>.

| | &#948; (ppm) | C<sub>Q</sub> (MHz) | &#951;<sub>Q</sub> |
|---|---|---|---|
|Material A| 37.2 | 5.21 | 0.13 |
|Material B| 40.8 | 5.19 | 0.19 |

## Further resources

The Collaborative Computational Project for NMR Crystallography (CCP-NC) has a number of [tools](https://www.ccpnc.ac.uk/software) and [resources](https://www.ccpnc.ac.uk/docs) to help with CASTEP. In addtion is the graphical user interface, MagresView mentioned above, the Soprano python library can be a useful way to analyse CASTEP output. There are NMR-specific tutorials here: <https://jkshenton.github.io/soprano/tutorials/05-nmr.html> and a command line interface for commond NMR tasks with .magres files here: <https://jkshenton.github.io/soprano/tutorials/07-soprano-cli.html>. Soprano is installed on the VM (Applications -> Software -> Soprano).

