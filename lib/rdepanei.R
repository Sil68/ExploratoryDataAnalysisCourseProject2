# $Id$
# rdepanei.R
# ==========
#
#     read raw data, in particular the PM2.5 Emissions data from the
#     National Emissions Inventory (NEI) (imported from the EPA National 
#     Emissions Inventory) into a corresponding data structure
#
#     input value:
#         basedir ----- base directory to read files from
#         fname ------- files to read
#
#     output value:
#         data table -- success; data table containing the read raw data
#         NULL -------- failure
#
#     note:
#         Both--baseDir and fname--have to be provided, and set to a 
#         non-NULL value.
#
# Copyright (c) Martin HEIN (m#)/October 2015
#
#     $Log$
#

rdEPAnei <- function(baseDir=file.path(inDir), fname=NULL) {
    
    # local variable declaration
    rc <- NULL
    
    # read raw data
    if (all((!is.null(baseDir)), (!is.null(fname)))) {
        rc <- try(readRDS(file.path(baseDir, fname)), silent=TRUE)
        
        # successfully read raw data, set variable/column classes
        if (class(rc)[1] != "try-error") {
            rc <- as.data.table(rc)
            rc[, c("fips", "SCC", "Pollutant", "type") := list(as.factor(fips), 
                                                               as.factor(SCC), 
                                                               as.factor(Pollutant), 
                                                               as.factor(type))]
            rc[, type := as.factor(gsub("^(NON|ON)([A-Z])", "\\1-\\2", 
                                        toupper(type), perl=TRUE))]
            setkeyv(rc, c("year", "fips", "SCC"))
            
        # failed to read raw data
        } else {
            rc <- NULL
        } # if
    } # if
    
    # return processing result
    rc
} # rdEPAnei

#
# end of file
#