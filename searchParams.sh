#!/bin/bash
#Examples
#To run a command, remove the hashtag (#) at the beginning of the command line


#./searchParams.py -v --searchType=hierarchical --name="evergreen" --format=csv
#./searchParams.py -v --searchType=hierarchical --name="evergreen" --format=param
#./searchParams.py -v --searchType=hierarchical --name="evergreen" --format=param --output=veg_evergreen.def

#./searchParams.py -v --searchType=constrained --name="evergreen" --param="max_lai" --format=csv
#./searchParams.py -v --searchType=constrained --location="Oregon" --format=csv
#./searchParams.py -v --searchType=constrained --param="snow" --format=csv
#./searchParams.py -v --searchType=constrained --name="sandyloam" --param="snow" --format=csv
#./searchParams.py -v --searchType=constrained --reference="Jones" --format=csv

# Search for parameter name by partial name, i.e. "epc" matches "epc.maxlgf", "epc.ndays_expand", ...
#./searchParams.py -v --searchType=constrained --param="epc.leaflitr_cn" --format=csv
#./searchParams.py -v --searchType=constrained --param="epc" --startDatetime="2013-04-15 12:00:00" --endDatetime="2013-04-15 17:00:00" --format=csv
