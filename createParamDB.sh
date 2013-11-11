#!/bin/bash

# Create an empty database file
sqlite3 params.sqlite < createParamDB.sql

# Create an empty database file that may be used for testing or building a custom db, etc.
sqlite3 empty_params.sqlite < createParamDB.sql
sqlite3 unittests/empty_params.sqlite < createParamDB.sql

# Insert params for the veg base classes
./insertParams.py -v --type="stratum" --name="nonveg" --parentName="None" --user="RHESSys" defs/stratum/veg_nonveg.def
./insertParams.py -v --type="stratum" --name="grass" --parentName="None" --user="RHESSys" defs/stratum/veg_grass.def
./insertParams.py -v --type="stratum" --name="deciduous" --parentName="None" --user="RHESSys" defs/stratum/veg_deciduous.def
./insertParams.py -v --type="stratum" --name="evergreen" --parentName="None" --user="RHESSys" defs/stratum/veg_evergreen.def
./insertParams.py -v --type="stratum" --name="deciduous_BES" --parentName="deciduous" --location="Baltimore Ecosystem Study" --user="RHESSys" defs/stratum/veg_deciduous_BES.def
./insertParams.py -v --type="stratum" --name="lawn_10cm" --parentName="grass" --user="RHESSys" defs/stratum/veg_lawn_10cm.def
./insertParams.py -v --type="stratum" --name="lawn_5cm" --parentName="grass" --user="RHESSys" defs/stratum/veg_lawn_5cm.def
./insertParams.py -v --type="stratum" --name="lawn_2cm" --parentName="grass" --user="RHESSys" defs/stratum/veg_lawn_2cm.def


# Insert params for the soil base classes
./insertParams.py -v --type="soil" --name="clay" --parentName="None" --user="RHESSys" defs/soil/soil_clay.def
./insertParams.py -v --type="soil" --name="silt-clay" --parentName="None" --user="RHESSys" defs/soil/soil_siltyclay.def
./insertParams.py -v --type="soil" --name="silt-clay-loam" --parentName="None" --user="RHESSys" defs/soil/soil_siltyclayloam.def
./insertParams.py -v --type="soil" --name="sandy-clay" --parentName="None" --user="RHESSys" defs/soil/soil_sandyclay.def
./insertParams.py -v --type="soil" --name="sandy-clay-loam" --parentName="None" --user="RHESSys" defs/soil/soil_sandyclayloam.def
./insertParams.py -v --type="soil" --name="clay-loam" --parentName="None" --user="RHESSys" defs/soil/soil_clayloam.def
./insertParams.py -v --type="soil" --name="silt" --parentName="None" --user="RHESSys" defs/soil/soil_silt.def
./insertParams.py -v --type="soil" --name="silt-loam" --parentName="None" --user="RHESSys" defs/soil/soil_siltyloam.def
./insertParams.py -v --type="soil" --name="loam" --parentName="None" --user="RHESSys" defs/soil/soil_loam.def
./insertParams.py -v --type="soil" --name="sand" --parentName="None" --user="RHESSys" defs/soil/soil_sand.def
./insertParams.py -v --type="soil" --name="loamy-sand" --parentName="None" --user="RHESSys" defs/soil/soil_loamysand.def
./insertParams.py -v --type="soil" --name="sandy-loam" --parentName="None" --user="RHESSys" defs/soil/soil_sandyloam.def
./insertParams.py -v --type="soil" --name="rock" --parentName="None" --user="RHESSys" defs/soil/soil_rock.def
./insertParams.py -v --type="soil" --name="water" --parentName="None" --user="RHESSys" defs/soil/soil_water.def

# Insert params for the landuse base classes
./insertParams.py -v --type="landuse" --name="undeveloped" --parentName="None" --user="RHESSys" defs/lu/lu_undev.def
./insertParams.py -v --type="landuse" --name="agriculture" --parentName="None" --user="RHESSys" defs/lu/lu_ag2.def    
./insertParams.py -v --type="landuse" --name="urban" --parentName="None" --user="RHESSys" defs/lu/lu_urban3.def
./insertParams.py -v --type="landuse" --name="raingarden" --parentName="None" --user="RHESSys" defs/lu/lu_raingarden.def     

# Insert params for the basin, hillslope, and zone base classes
./insertParams.py -v --type="basin" --name="basin" --parentName="None" --user="RHESSys" defs/basin.def
./insertParams.py -v --type="hillslope" --name="hillslope" --parentName="None" --user="RHESSys" defs/hillslope.def
./insertParams.py -v --type="zone" --name="zone" --parentName="None" --user="RHESSys" defs/zone.def

