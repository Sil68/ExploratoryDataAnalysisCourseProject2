# $Id$
# bldurl.R
# ========
#
#     assemble URL from individual parts by concatenating these,
#     separated by "/", and subsequently by replacing any occurances of
#     multiple "/" with single ones (expect for the leading protocol ones)
#
#     input value:
#         ... --------- individual parts to assemble the URL from
#                       URLs from
#         encURL ------ encode generated URL?
#         chkURL ------ check generated URL's existance?
#
#     output value:
#         vector ------ success; vector containing the generated URLs
#         NA ---------- failure
#
#     note:
#         :: individual parts have to have a non-NULL value assigned;
#         :: otherwise a corresponding vector or NA values will be returned.
#
# Copyright (c) Martin HEIN (m#)/October 2015
#
#     $Log$
#

BldURL <- function(..., encURL=FALSE, chkURL=FALSE) {
    rc <- NA
    funArgs <- list(...)
    
    # build URL
    if (length(funArgs) > 0) {
        rc <- paste(..., sep="/")
        rc <- gsub("([^:])(/(/{1,}))", "\\1/", rc, perl=TRUE)
    } # if
    
    # encode URL
    if (encURL && (!is.na(rc))) {
        rc <- URLencode(rc)
    } # if
    
    # check URL's existance
    if (chkURL && (!is.na(rc))) {
        if (!url_ok(rc, user_agent(usrAgent))) rc <- NA
    } # if
    
    # return processing result
    rc
} # BldURL

#
# end of file
#