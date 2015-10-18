# $Id$
# chkdir.R
# ========
#
#     check whether a specific directory is already existing, and if not
#     create that directory
#
#     input parameter:
#         dname -- vector of directory names to check/create
#         mkdir -- create directories if non-existing
#
#     output value:
#         TRUE --- success; directories are existing/have been created 
#                  successfully
#         FALSE -- failure: directories are not existing/cannot be created
#
# Copyright (C) Martin HEIN (m#)/September 2015
#
#     $Log$
#

chkDir <- function(dname=NULL, mkdir=TRUE) {
    rc <- FALSE
    vrc <- vector()

    # directory name(s) provided
    if (length(dname) > 0) {
        
        # check each directory name provided
        for (i in 1:length(dname)) {
            if (!file.exists(dname[i])) {
                rc <- dir.create(dname[i], showWarnings=FALSE, recursive=TRUE)
            } else {
                rc <- TRUE
            } # if/else
            
            # store individual checking result
            vrc <- append(vrc, rc)
        } # for
        
        # determine overall checking result
        rc <- (length(vrc) == sum(vrc))
    } # if
    
    # return checking result
    rc
} # chkDir

#
# end of file
#