# $Id$
# estepards.R
# ===========
#
#     estimate the aount of memory required to load and store the read raw 
#     data (National Emissions Inventory (NEI) imported from the EPA National 
#     Emissions Inventory) into a corresponding data structure
#
#     input value:
#         basedir ----- (vector of) base directory/ies to read files from
#         fnames ------ (vector of) file(s) to read
#         unts -------- unit of size returned ("b", "k", "m", "g")
#
#     output value:
#         memory size - success; (vector of) rough estimate(s) of the memory 
#                       required to store the raw data
#         NULL -------- failure
#
#     note:
#         :: Both--baseDir and fnames--have to be provided, and set to a 
#            non-NULL value;
#         :: "b" = bytes; "k" = kilo bytes, "m" = mega bytes, "g" = giga bytes.
#
# Copyright (c) Martin HEIN (m#)/October 2015
#
#     $Log$
#

estEPArds <- function(baseDir=file.path(inDir), fnames=NULL, unts="b") {
    
    # local variable declaration
    rc <- NULL
    tmpFinf <- NULL
    tmpSizeFac <- 22
    tmpUnits <- c("b", "k", "m", "g")
    tmpUnitFac <- c(1, 1024, 1024^2, 1024^3)
    
    # estimate size of raw data
    if (all((!is.null(baseDir)), (!is.null(fnames)))) {
        for (i in 1:length(fnames)) {
            j <- if (i > length(baseDir)) length(baseDir) else i
            
            tmpFinf <- file.info(file.path(baseDir[j], fnames[i]))
            rc <- c(rc, tmpFinf$size * tmpSizeFac)
        } # for
        
        # convert to requested unit
        if ((unts %in% tmpUnits) && (!is.null(rc))) {
            rc <- ceiling(rc / tmpUnitFac[which(tmpUnits %in% unts)])
        } # if
    } # if
    
    # return processing result
    as.numeric(rc)
} # estEPArds

#
# end of file
#