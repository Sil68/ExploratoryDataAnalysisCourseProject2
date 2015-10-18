# $Id$
# mrgneiscc.R
# ===========
#
#     merge NEI and SCC data sets
#
#     the merging takes place in form of an outer join, with matching of
#     the respective records based on variables/columns "type" and "SCC".
#
#     after successfully merging the data sets, a re-arranging of the
#     variables/columns of the resulting data set is carried out.
#
#     input value:
#         dtNEI ------- data.table containing the NEI data
#         dtSCC ------- data.table containing the SCC data
#         cnMtch ------ vector of variables/column names to base the
#                       row matching on
#
#     output value:
#         data table -- success; data table containing the merged data
#         NULL -------- failure
#
#     note:
#         :: both dtNEI and dtSCC have to be provided, and a non-NULL value
#            assigned;
#         :: cnMtch has to comprise variables/column names valid for both
#            dtNEI and dtSCC;
#         :: otherwise a NA value will be returned.
#
# Copyright (c) Martin HEIN (m#)/October 2015
#
#     $Log$
#

mrgNEISCC <- function(dtNEI=NULL, dtSCC=NULL, cnMtch=c("type", "SCC")) {
    
    # local variable declaration
    rc <- NULL
    vldCN <- FALSE
    okNEI <- NULL
    okSCC <- NULL
    
    # merge data sets
    if (all(!is.null(dtNEI), !is.null(dtSCC))) {
        
        # check for validity of variables/columns indicated for match
        if (sum((cnMtch %in% colnames(dtNEI)), 
                cnMtch %in% colnames(dtSCC)) == (2 * length(cnMtch))) {

            # save old sorting/matching key, and assign new one
            okNEI <- key(dtNEI)
            okSCC <- key(dtSCC)
            
            setkeyv(dtNEI, cnMtch)
            setkeyv(dtSCC, cnMtch)
            
            # execute outer join
            rc <- dtSCC[dtNEI]
            rc <- rc[, .SD, .SDcols=unique(c(colnames(dtNEI), 
                                             colnames(dtSCC)))]
            setkeyv(rc, unique(okNEI, okSCC))
            
            # restore old sorting/matching key
            setkeyv(dtNEI, okNEI)
            setkeyv(dtSCC, okSCC)
        } # if
        
    # cannot merge data sets
    } else {
        rc <- NA
    } # if/else
    
    # return processing result
    rc
} # mrgNEISCC

#
# end of file
#