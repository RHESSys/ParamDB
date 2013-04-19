#include <stdio.h>
#include <math.h>
#include <string.h>

#include "blender.h"
#include "route_roofs.h"
#include "roof_geometry.h"
#include "util.h"
#include "get_roof_geometry.h"
#include "compute_non_connected.h"
#include "compute_connected.h"

bool route_roofs_to_roads(
    struct flow_struct* _flow_table,
    int _num_patches,
    const double* _roofs,
    const int* _impervious,
    const int* _patch,
    const int* _hill,
    const int* _zone,
    int _maxr,
    int _maxc)
{
    bool result = true;
    int num_squares = _maxr * _maxc;
    bool roof_processed[num_squares];

    memset(roof_processed, 0, sizeof(roof_processed));
    
    // For debugging
    FILE* fid = fopen("RoofGeometries.txt", "w");
    if(fid == 0) {
	fprintf(stderr, "ERROR: could not open roof geometries debug file.\n");
	result = false;
    }
    //

    for(int index = 0; result && index < num_squares; ++index) {
	if(is_roof(_roofs[index]) && roof_processed[index] != true) {

	    /* Construct a new roof geometry */
	    roof_geometry_t* roof_geometry;
	    if(!construct_roof_geometry(&roof_geometry)) {
		fprintf(stderr, "ERROR: Failed to construct a roof geometry.\n");
		result = false;
	    }
	    
	    // Compute the geometry of the entire contiguous roof
	    else if(!get_roof_geometry(_roofs, index, _maxr, _maxc, roof_processed, roof_geometry)) {
		fprintf(stderr, "ERROR: failed to get roof geometry for square index: %d\n", index);
		result = false;
	    }

	    // debugging
	    else if(!print_roof_geometry(fid, roof_geometry)) {
		fprintf(stderr, "ERROR: Failed to print roof geometry.\n");
		result = false;
	    }
	    //
	    
	    // Compute routing for the non-connected (pervious) flow
	    else if(!compute_roof_non_connected_routing(_flow_table, _num_patches, roof_geometry, _roofs, _impervious, _patch, _hill, _zone,_maxr, _maxc)) {
		fprintf(stderr, "ERROR: failed to perform non-connected roof routing");
		result = false;
	    }

	    // Compute routing for the connected (impervious) flow
	    else if(!compute_roof_connected_routing(_flow_table, _num_patches, roof_geometry, _roofs, _impervious, _patch, _hill, _zone, _maxr, _maxc)) {
		fprintf(stderr, "ERROR: failed to perform the connected roof routing");
		result = false;
	    }

	    // Destory the roof geometry
	    else if(!destroy_roof_geometry(&roof_geometry)) {
		fprintf(stderr, "ERROR: Failed to destroy the roof geometry.\n");
		result = false;
	    }
	}
    }

    // debugging
    if(result) {
	fclose(fid);
    }
    //
    
    return result;
}
