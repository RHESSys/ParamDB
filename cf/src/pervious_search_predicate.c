#include <stdlib.h>
#include <stdio.h>

#include "util.h"
#include "pervious_search_predicate.h"

typedef struct pervious_context_s {
    int maxr_;
    int maxc_;
    const double* roofs_;
    const int* impervious_;
} pervious_context_t;

bool pervious_make_context(
    int _maxr,
    int _maxc,
    const double* _roofs,
    const int* _impervious,
    void** _rtn_ctx)
{
    bool result = true;
    if(_rtn_ctx == 0) {
	fprintf(stderr, "ERROR: Return impervious context pointer is NULL.\n");
	result = false;
    } else {
	pervious_context_t* context = (pervious_context_t*)calloc(1, sizeof(pervious_context_t));
	if(context == 0) {
	    fprintf(stderr, "ERROR: Failed to allocate memory for the impervious search context.\n");
	    result = false;
	} else {
	    context->maxr_ = _maxr;
	    context->maxc_ = _maxc;
	    context->roofs_ = _roofs;
	    context->impervious_ = _impervious;

	    *_rtn_ctx = (void*)context;
	}
    }    
    return result;
}

bool pervious_search_predicate(
    int _row,
    int _col,
    void* _context,
    int* _rtn_vote)
{
    bool result = true;
    if(_context == 0) {
	fprintf(stderr, "ERROR: Search context pointer is NULL.\n");
	result = false;
    } else {
	/* kinda ugly but it is C */
	pervious_context_t* context = (pervious_context_t*)_context;
	int index;
	if(!row_col_to_index(_row, _col, context->maxr_, context->maxc_, &index)) {
//	    fprintf(stderr, "ERROR: Failed to map the row: %d, and column: %d to an index.\n", _row, _col);
	    result = false;
	} else {
	    if(context->impervious_[index] != 1 && !is_roof(context->roofs_[index])) {
		*_rtn_vote = 1;
	    } else {
		*_rtn_vote = 0;
	    }
	}
    }
    
    return result;
}
