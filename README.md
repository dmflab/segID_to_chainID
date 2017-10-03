# segID_to_chainID

Simple awk script to handle MD snapshot coordinates that use SEGID to 
identify chains (i.e. with the same CHAINID) by transfering the unique 
part of the SEGID to the CHAINID. Oh, and give atoms an occupancy and B
 -factor, too. Ang get rid of hydrogen atoms, while we're at it

Usage -      

<i> ./segID_to_chainID.awk input.pdb > output.pdb </i>

