# $Id$
# chkurl.R
# ========
#
#     check whether a specific URL is valid, and if it can be accessed
#
#     input parameter:
#         valURLurl -- vector of URLs to check/validate
#
#     output value:
#         TRUE ------- success; vector; URLs are valid and accessible
#         FALSE ------ failure: vector; URLs are not existing/cannot be accessed
#
# Copyright (C) Martin HEIN (m#)/October 2015
#
#     $Log$
#

chkUrl <- function(valURL=NULL) {
    rc <- NULL

    # URK(s) provided
    if (length(valURL) > 0) {
        
        # check each URL provided
        for (i in 1:length(valURL)) {
            rc <- c(rc, (class(try(url_ok(valURL[i], user_agent(usrAgent)), 
                                   silent=TRUE)) != "try-error"))
        } # for
    } else {
        rc <- FALSE
    } # if/else
    
    # return checking result
    rc
} # chkUrl

#
# end of file
#