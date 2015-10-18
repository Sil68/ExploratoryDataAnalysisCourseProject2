# $Id$
# dldat.R
# =======
#
#     download data (dlname) into indicated directory (dldir), expand if 
#     requested (exp), and rename as specified (fname).
#
#     input value:
#         dlname -- vector of files to downloads
#         dldir --- vector of directories files to download to
#         fname --- local filenames of downloaded files
#         exp ----- expand downloaded files?
#         redl ---- re-download files?
#
#     output value:
#         TRUE ---- success; directory is existing/has been created successfully
#         FALSE --- failure; directory does not exist/cannot be created
#
#     note:
#         case #1) dlname, dldir, fname have to be of identical length, -or-
#         case #2) dlname and fname have to be of identical length, and dldir
#                  has to be of length 1.
#
# Copyright (c) Martin HEIN (m#)/September 2015
#
#     $Log$
#

dlDat <- function(dlname=NULL, dldir=NULL, fname=NULL, exp=FALSE, redl=FALSE) {
    rc <- FALSE
    vrc <- vector()
    vdate <- vector()
    dlmeth <- (if(.Platform$OS.type == "windows") "auto" else "curl")
    
    # case #1 -or- case #2
    if ((length(dlname) == length(fname)) && 
        ((length(dlname) == length(dldir)) || 
         (length(dldir) == 1))) {
        
        # filename(s) to download provided
        if (length(dlname) > 0) {
            
            # download each individual file
            for (i in 1:length(dlname)) {
                
                # check whether case #1 or case #2 in order to determine
                # the corresponding download directory (element of the
                # vector)
                di <- ifelse(length(dldir) == 1, 1, i)
                
                # download file
                if (redl || (!file.exists(file.path(dldir[di], fname[i])))) {
                    download.file(dlname[i], file.path(dldir[di], fname[i]), 
                                  method=dlmeth)
                    vdate <- append(vdate, date())
                    
                    # store individual download result
                    rc <- file.exists(file.path(dldir[di], fname[i]))
                    vrc <- append(vrc, rc)
                    
                    # if requested, expand archive
                    if (rc) {
                        unzip(file.path(dldir[di], fname[i]), exdir=dldir)
                    } # if
                } else { # if/else
                    vrc <- append(vrc, TRUE)
                }
            } # for
            
            # determine overall download result
            rc <- (length(vrc) == sum(vrc))
        } # if
    } # if
    
    # return download result
    rc
} # dlDat

#
# end of file
#