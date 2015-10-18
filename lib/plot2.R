# $Id$
# plot2.R
# =======
#
#     plot the data provided both to the screen as well as a file
#     (format png) by facilitating the R base system
#
#     question to address:
#         Have total emissions from PM2.5 decreased in Baltimore City, 
#         Maryland (fips == "24510") from 1999 to 2008?
#
#     input value:
#         dtPlt ------- data table containing the data to plot
#         fname ------- name of the file the plot has to sent to
#         imgSize ----- size/dimension (<pixels height>x<pixels width>x
#                       <resolution>) of the plot generated and written to file
#         cnty -------- five-digit number indicating the U.S. county
#
#     output value:
#         TRUE -------- success; data have been plot both the screen as well
#                       as the file
#         FALSE ------- failure
#
#     note:
#         :: all of dtPlt, fname, imgSize, and cnty have to be provided, and 
#            set to a non-NULL value.
#
# Copyright (c) Martin HEIN (m#)/October 2015
#
#     $Log$
#

plot2 <- function(dtPlt=NULL, fname=NULL, imgSize=NULL, cnty="24510") {
    
    # local variable declaration
    rc <- FALSE
    tmpfname <- file.path(fname)
    ofinf <- NULL
    nfinf <- NULL
    pltDT <- NULL
    pltDims <- NULL
    pltWidth <- NULL
    pltHeight <- NULL
    pltRes <- NULL
    
    # plot data to screen and file
    if (all((!is.null(dtPlt)), (!is.null(fname)), (!is.null(imgSize)),
            (!is.null(cnty)))) {
        
        # check if output file is already existing
        if (file.exists(tmpfname)) {
            ofinf <- file.info(tmpfname)
        } # if
        
        # split image size into individual components (height, width, 
        # resolution)
        pltDims <- strsplit(imgSize, "x", fixed=TRUE)[[1]]
        
        if (length(pltDims) == 3) {
            pltWidth <- as.numeric(pltDims[1])
            pltHeight <- as.numeric(pltDims[2])
            pltRes <- as.numeric(pltDims[3])
        } # if
        
        # proceed only in case of valid dimensions provided
        if (all(!is.na(pltWidth), !is.na(pltHeight), !is.na(pltRes))) {
            
            # plotting function
            pltData <- function(dtPlt, xfs=1, yfs=1, tfs=0.7, lfs=0.8, lwd=2) {
                opar <- par(no.readonly = TRUE)
                
                # adjust the graphical parameters
                par(mgp=c(2, 0.5, 0), mar=c(4, 4, 3, 2))
                
                # generate plot
                with(dtPlt, {
                    plot(Year, Total.Emissions, 
                         col="red", type="l", lwd=lwd,
                         xlab="", ylab="", main="", 
                         ps=20, cex.axis=0.6, cex.lab=0.8, cex.main=1)
                    
                    abline(v=Year, lty="dotted")
                    abline(h=dtPlt[.(min(Year)), Total.Emissions], 
                           lty=4, lwd=1, col="blue")
                    
                    mdlPlt <- lm(Total.Emissions ~ Year)
                    abline(mdlPlt, lty=2, lwd=1, col="blue")
                    
                    legend("bottomleft", legend=c("trend", "starting point"),
                           lty=c(2, 4), lwd=c(1, 1), col=c("blue", "blue"))
                    
                    mtext("Year", side=1, line=2, cex=xfs)
                    mtext("Emissions", side=2, line=2, cex=yfs)
                    title(main="Total emissions from PM2.5\nin Baltimore City, Maryland", 
                          cex=tfs)
                })
                
                # restore original par settings
                par(opar)
            } # pltData
            
            # prepare data to be plotted
            pltDT <- dtPlt[fips == cnty, sum(Emissions), by=year]
            setnames(pltDT, c("Year", "Total.Emissions"))
            setkeyv(pltDT, c("Year"))
            
            # plot to screen
            pltData(pltDT)
            
            # plot to file
            png(paste(tmpfname, sep=""))
            pltData(pltDT, 1, 1, 1, 0.35, 0.5)
            dev.off()
            
            # check if output file has been written
            if (file.exists(tmpfname)) {
                nfinf <- file.info(tmpfname)
            } # if
            
            rc <- all(!identical(ofinf, nfinf), !is.null(nfinf))
        } # if
    } # if
    
    # return processing result
    rc
} # plot2

#
# end of file
#