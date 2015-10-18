# $Id$
# plot6.R
# =======
#
#     plot the data provided both to the screen as well as a file
#     (format png) by facilitating the R qqplot2 system
#
#     question to address:
#         Compare emissions from motor vehicle sources in Baltimore City 
#         (fips == "24510") with emissions from motor vehicle sources in Los 
#         Angeles County, California (fips == "06037"). Which city has seen 
#         greater changes over time in motor vehicle emissions?
#
#     input value:
#         dtPlt ------- data table containing the data to plot
#         fname ------- name of the file the plot has to sent to
#         imgSize ----- size/dimension (<pixels height>x<pixels width>x
#                       <resolution>) of the plot generated and written to file
#         cnty1 ------- five-digit number indicating the U.S. county
#         cnty2 ------- five-digit number indicating the U.S. county
#
#     output value:
#         TRUE -------- success; data have been plot both the screen as well
#                       as the file
#         FALSE ------- failure
#
#     note:
#         :: all of dtPlt, fname, imgSize, cnty1, and cnty2 have to be provided,
#            and set to a non-NULL value.
#
# Copyright (c) Martin HEIN (m#)/October 2015
#
#     $Log$
#

plot6 <- function(dtPlt=NULL, fname=NULL, imgSize=NULL, 
                  cnty1="24510", cnty2="06037") {
    
    # local variable declaration
    rc <- FALSE
    tmpfname <- file.path(fname)
    ofinf <- NULL
    nfinf <- NULL
    pltDT <- NULL
    pltDT1 <- NULL
    pltDT2 <- NULL
    pltDims <- NULL
    pltWidth <- NULL
    pltHeight <- NULL
    pltRes <- NULL
    
    # plot data to screen and file
    if (all((!is.null(dtPlt)), (!is.null(fname)), (!is.null(imgSize)),
            (!is.null(cnty1)), (!is.null(cnty2)))) {
        
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
                par(mgp=c(2, 0.5, 0), mar=c(4, 4, 3, 2), mfcol=c(1, 2))
                
                # generate plot #1 (development/changes in emissions)
                pltDat <- c("Baltimore City, Maryland", "Los Angeles County")
                pltCol <- c("red", "blue")
                
                with(dtPlt, {
                    ymin <- min(Total.Emissions.Baltimore.City, 
                                Total.Emissions.Los.Angeles.County, na.rm=TRUE)
                    ymax <- max(Total.Emissions.Baltimore.City, 
                                Total.Emissions.Los.Angeles.County, na.rm=TRUE)
                    
                    plot(Year, Total.Emissions.Baltimore.City, 
                         ylim=c(ymin, ymax),
                         col=pltCol[1], type="l", lwd=lwd,
                         xlab="", ylab="", main="", 
                         ps=20, cex.axis=0.6, cex.lab=0.8, cex.main=1)
                    
                    lines(Year, Total.Emissions.Los.Angeles.County, 
                          col=pltCol[2], type="l", lwd=lwd)
                    
                    abline(v=Year, lty="dotted")
                    abline(h=dtPlt[.(min(Year)), Total.Emissions.Baltimore.City], 
                           lty=4, lwd=1, col=pltCol[1])
                    abline(h=dtPlt[.(min(Year)), Total.Emissions.Los.Angeles.County], 
                           lty=4, lwd=1, col=pltCol[2])
                    
                    mdlPlt <- lm(Total.Emissions.Baltimore.City ~ Year)
                    abline(mdlPlt, lty=2, lwd=1, col=pltCol[1])
                    mdlPlt <- lm(Total.Emissions.Los.Angeles.County ~ Year)
                    abline(mdlPlt, lty=2, lwd=1, col=pltCol[2])
                    
                    legend("right", 
                           legend=c(pltDat, "trend", "starting point"),
                           cex=lfs, col=c(pltCol, "black", "black"),
                           lty=c(1, 1, 2, 4), 
                           lwd=c(lwd, lwd, lwd, lwd))
                    
                    mtext("Year", side=1, line=2, cex=xfs)
                    mtext("Emissions", side=2, line=2, cex=yfs)
                    title(main="Total emissions from PM2.5\nfrom motor vehicle sources", 
                          cex=tfs)
                })
                
                # generate plot #2 (compare difference in changes)
                with(dtPlt, {
                    dlt1 <- dtPlt[.(max(Year)), 
                                  Total.Emissions.Baltimore.City] -
                            dtPlt[.(min(Year)), 
                                  Total.Emissions.Baltimore.City]
                    dlt2 <- dtPlt[.(max(Year)), 
                                  Total.Emissions.Los.Angeles.County] -
                            dtPlt[.(min(Year)), 
                                  Total.Emissions.Los.Angeles.County]
                    
                    barplot(c(abs(dlt1), abs(dlt2)), col=pltCol,
                            xlab=paste(min(Year), "-", max(Year)), 
                            ylab="Emissions")

                    abline(h=abs(dlt1), lty=2, lwd=1, col=pltCol[1])
                    abline(h=abs(dlt2), lty=2, lwd=1, col=pltCol[2])
                    
                    legend("center", legend=pltDat, 
                           cex=lfs, col=pltCol,
                            lty=c(1, 1), lwd=c(lwd, lwd))
                    
                    title(main="Absolute change in\ntotal emissions from PM2.5", 
                          cex=tfs)
                })

                # restore original par settings
                par(opar)
            } # pltData
            
            # prepare data to be plotted
            pltDT <- dtPlt[grepl("mobile", SCC.Level.One, 
                                 perl=TRUE, ignore.case=TRUE) &
                               grepl("vehicle", SCC.Level.Two, 
                                     perl=TRUE, ignore.case=TRUE) &
                               (fips %in% c(cnty1, cnty2)),
                           sum(Emissions), by=c("year", "fips")] %>%
                     spread(fips, V1)
            setnames(pltDT, c("Year", "Total.Emissions.Los.Angeles.County", 
                              "Total.Emissions.Baltimore.City"))
            setkeyv(pltDT, c("Year"))
            
            # plot to screen
            pltData(pltDT)
            
            # plot to file
            png(paste(tmpfname, sep=""))
            pltData(pltDT, 1, 1, 1, 0.7, 0.5)
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
} # plot6

#
# end of file
#