# $Id$
# setusragnt.R
# ============
#
#     set user agent to a "real" browser (instead of pointing to the 
#     R environment/session)
#
# Copyright (c) Martin HEIN (m#)/October 2015
#
#     $Log$
#

usrAgent <- "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/601.2.5 (KHTML, like Gecko) Version/9.0.1 Safari/601.2.5"

options(HTTPUserAgent=usrAgent)

#
# end of file
#