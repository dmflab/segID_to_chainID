#!/usr/bin/awk -f 
# -*_ coding: UTF8 -*-
#
# dmf 10.2.17 segid_to_chainid
#
# handle MD snapshot coordinates that use SEGID 
# to identify chains (i.e. with the same CHAINID)
# by transfering the unique part of the SEGID to 
# the CHAINID. Oh, and give atoms an occupancy and 
# B-factor, too. And those pesky hydrogens...
#
#
#          > record is:
#	            10        20        30        40        50        60        70 
#          123456789A123456789B123456789C123456789D123456789E123456789F123456789G12345678
#          ATOM      1  N   THR A 144       8.284 -10.719  29.242  1.00255.38           N
#                               ^                                  ^^^^ ^^^^^      ^^^^  
#          13-16 Atom  [hydrogen atoms - 'H' at position 13, 14]
#          22    chainID
#          55-60 occupancy  
#          61-66 tempFactor 
#          73-76 segID [which are formatted as 'PROA', 'PROB'... etc in these files]
#
# input: MD file with only SEGIDs unique
# output: new PDB file 
# usage: ./segid_to_chainid input.pdb > output.pdb  
#
{
 if (NR==FNR) {   # copying old code, clean up later
   if ($1=="ATOM"){
        if (substr($0,13,1)=="H" || substr($0,14,1)=="H") {
		# skip
	} else {
        	printf("%s", substr($0,1,21));   # output 1-21
        	printf("%s", substr($0,76,1));    # add new CHAINID at 22, extracted from position 76
        	printf("%s", substr($0,23,32));  # output 23-54
        	printf("%6.2f", 1.0);            # add new occupancy at 55-60
        	printf("%6.2f", 20.0);		# add new tempFactor at 61-66
        	printf("%s\n", substr($0,67,11));  # output 67-78 (including old SEGID)
	}
   } else { # just dump the line back out 
	printf("%s\n", $0);  
   } 
 }
}
