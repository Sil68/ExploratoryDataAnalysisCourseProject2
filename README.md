**********

# Purpose

In the course of partaking an online class regarding data analysis, in particular the class _*Exploratory Data Analysis*_, one assignment was a project with the purpose to demonstrate the student's ability to collect, work with, and plot a data set in various ways.

**********

# Introduction

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the [EPA National Emissions Inventory web site][epahome].

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

The data for this assignment are available from the course web site as a single zip file: [Data for Peer Assessment][epadata] [29Mb]

The zip file contains two files:

+ PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year.
+ Source Classification Code Table (Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source "10100101" is known as "Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal".

**********

# Assignment

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999-2008. You may use any R package you want to support your analysis.

## Questions

You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

1. Have total emissions from PM2.5 decreased in the United  States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
2. Have total emissions from PM2.5 decreased in Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

## Making and Submitting Plots

For each plot you should

+ Construct the plot and save it to a PNG file;
+ Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R should only include code for producing plot1.png);
+ Upload the PNG file on the Assignment submission page;
+ Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.

**********

# Quick start

1. Download the [repository][ghrepo] files to your local machine;
2. Open the R project file (_*```course project 1.Rproj```*_);
3. Open and run the main R script (_*```plot.R```*_).

**********

# Project

The project comprises several directories and files, all of which are outlined below.

## Directory structure

In the project directory you will find several subdirectories.

```
<project directory>/
  +- course project 2.Rproj
  +- data/
  |    +- exdata%2Fdata%2FNEI_data.zip
  |    +- Source_Classification_Code.rds
  |    +- summarySCC_PM25.rds
  +- doc/
  +- lib/
  |    +- bldurl.R
  |    +- chkdir.R
  |    +- chkurl.R
  |    +- dldat.R
  |    +- estepards.R
  |    +- mrgneiscc.R
  |    +- plot1.R
  |    +- plot2.R
  |    +- plot3.R
  |    +- plot4.R
  |    +- plot5.R
  |    +- plot6.R
  |    +- rdepanei.R
  |    +- rdepascc.R
  |    +- setusragnt.R
  +- plot.R
  +- publishing/
  |    +- plot1.png
  |    +- plot2.png
  |    +- plot3.png
  |    +- plot4.png
  |    +- plot5.png
  |    +- plot6.png
  +- README.md (GitHub compatible)
  +- README.Rmd
```

The _*```data```*_ directory contains the downloaded data file, both as a compressed archive (zip), as well as the uncompress individual data files.

Any additional, supporting scripts or libraries are stored inside the _*```lib```*_ directory.

## Files

For reasons of readability, testing, profiling, benchmarking and re-usability, instead of creating one single script file, an approach of splitting the script into several functions, each put into a corresponding script file of its own, placed into the _*```lib```*_ directory, has been taken.

### plot.R

The main entry point, the main script, Upon which execution all required libraries and supporting scripts are getting loaded, as well as global variables and constants are defined.

Steps carried out by this script:

1. check for existence of the _*```doc```*_, _*```data```*_, and _*```publishing```*_ directories, and create these if required;
2. download and uncompress data file (raw data) if not already available;
3. estimate the size of main memory required for loading the data set into the memory;
4. load the NEI data set into a data.table _*```dtInDatNEI```*_;
5. load the SCC data set into a data.table _*```dtInDatSCC```*_;
6. merge data.tables _*```dtInDatNEI```*_ and _*```dtInDatSCC```*_ into data.table _*```dtInDat```*_;
7. create the six plots ([plot1.png][plot1], [plot2.png][plot2], [plot3.png][plot3], [plot4.png][plot4], [plot5.png][plot5], and [plot6.png][plot6])--all of which are located in sub-directory _*```publishing```*_--by executing the corresponding scripts (_*```lib/plot1.R```*_, _*```lib/plot2.R```*_, _*```lib/plot3.R```*_, _*```lib/plot4.R```*_, _*```lib/plot5.R```*_and _*```lib/plot6.R```*_) to answer the questions stated in the assignment.

**Note:**  
The plots stored in the respective PNG files have been generated on a transparent background.

### lib/bldurl.R

Assemble an URL from individual parts by concatenating these, encode it and/or check it for existance if requested.

|Parameter|Description|
|---------|-----------|
|...|individual components of the URL|
|encURL|if TRUE, the URL gets encoded after assembly|
|chkURL|if TRUE, the URL's existance gets verified|

Table: Input parameter

|Result|Description|
|------|-----------|
|TRUE|success; URL has been assembled (and is existing)|
|FALSE|failure; URL couldn't be assembled (or is not existing)|

Table: Output value

### lib/chkdir.R

Check whether a specific directory is already existing, and if not create that directory.

|Parameter|Description|
|---------|-----------|
|dname|vector of directory names to check/create|
|mkdir|create directories if non-existing|

Table: Input parameter

|Result|Description|
|------|-----------|
|TRUE|success; directories are existing/have been created successfully|
|FALSE|failure; directories are not existing/cannot be created|

Table: Output value

### lib/chkurl.R

Check whether a specific URL is valid, and if it can be accessed.

|Parameter|Description|
|---------|-----------|
|valURLurl|vector of URLs to check/validate|

Table: Input parameter

|Result|Description|
|------|-----------|
|TRUE|success; vector; URLs are valid and accessible|
|FALSE|failure: vector; URLs are not existing/cannot be accessed|

Table: Output value

### lib/dldat.R

Download data into indicated directory, expand if requested, and rename as specified.

|Parameter|Description|
|---------|-----------|
|dlname|vector of files to downloads|
|dldir|vector of directories files to download to|
|fname|local filenames of downloaded files|
|exp|expand downloaded files?|
|redl|re-download files?|

Table: Input parameter

|Result|Description|
|------|-----------|
|TRUE|success; directory is existing/has been created successfully|
|FALSE|failure; directory does not exist/cannot be created|

Table: Output value

**Note**  
Case #1) _*```dlname```*_, _*```dldir```*_, _*```fname```*_ have to be of identical length, -or-  
Case #2) _*```dlname```*_ and _*```fname```*_ have to be of identical length, and _*```dldir```*_ has to be of length 1.

### lib/estepards.R

Estimate the aount of memory required to load and store the read raw data.

|Parameter|Description|
|---------|-----------|
|basedir|base directory to read files from|
|fname|file to read|
|unts|unit of size returned ("b", "k", "m", "g")|

Table: Input parameter

|Result|Description|
|------|-----------|
|estimated memory size|success; rough estimate of the memory required to store the raw data|
|NULL|failure|

Table: Output value

**Note**  

+ both--baseDir and fname--have to be provided, and set to a non-NULL value;
+ "b" = bytes; "k" = kilo bytes, "m" = mega bytes, "g" = giga bytes.

### lib/plot1.R

Plot the data provided both to the screen as well as a file (format png) by facilitating the R base plot system only

**Question to address:**  
Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

|Parameter|Description|
|---------|-----------|
|dtPlt|data table containing the data to plot|
|fname|name of the file the plot has to sent to|
|imgSize|size/dimension (<pixels height>x<pixels width>x<resolution>) of the plot generated and written to file|

Table: Input parameter

|Result|Description|
|------|-----------|
|TRUE|success; data have been plot both the screen as well as the file|
|FALSE|failure|

Table: Output value

**Note**  
All of dtPlt, fname, and imgSize have to be provided, and set to a non-NULL value.  

### lib/plot2.R

Plot the data provided both to the screen as well as a file (format png) by facilitating the R base plot system only

**Question to address:**  
Have total emissions from PM2.5 decreased in Baltimore City, Maryland (fips == "24510") from 1999 to 2008?

|Parameter|Description|
|---------|-----------|
|dtPlt|data table containing the data to plot|
|fname|name of the file the plot has to sent to|
|imgSize|size/dimension (<pixels height>x<pixels width>x<resolution>) of the plot generated and written to file|
|cnty|five-digit number indicating the U.S. county|

Table: Input parameter

|Result|Description|
|------|-----------|
|TRUE|success; data have been plot both the screen as well as the file|
|FALSE|failure|

Table: Output value

**Note**  
All of dtPlt, fname, imgSize, and cnty have to be provided, and set to a non-NULL value.  

### lib/plot3.R

Plot the data provided both to the screen as well as a file (format png) by facilitating the R base plot system only

**Question to address:**  
Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? 

|Parameter|Description|
|---------|-----------|
|dtPlt|data table containing the data to plot|
|fname|name of the file the plot has to sent to|
|imgSize|size/dimension (<pixels height>x<pixels width>x<resolution>) of the plot generated and written to file|
|cnty|five-digit number indicating the U.S. county|

Table: Input parameter

|Result|Description|
|------|-----------|
|TRUE|success; data have been plot both the screen as well as the file|
|FALSE|failure|

Table: Output value

**Note**  
All of dtPlt, fname, imgSize, and cnty have to be provided, and set to a non-NULL value.  

### lib/plot4.R

Plot the data provided both to the screen as well as a file (format png) by facilitating the R base plot system only

**Question to address:**  
Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

|Parameter|Description|
|---------|-----------|
|dtPlt|data table containing the data to plot|
|fname|name of the file the plot has to sent to|
|imgSize|size/dimension (<pixels height>x<pixels width>x<resolution>) of the plot generated and written to file|

Table: Input parameter

|Result|Description|
|------|-----------|
|TRUE|success; data have been plot both the screen as well as the file|
|FALSE|failure|

Table: Output value

**Note**  
All of dtPlt, fname, and imgSize have to be provided, and set to a non-NULL value.  

### lib/plot5.R

Plot the data provided both to the screen as well as a file (format png) by facilitating the R base plot system only

**Question to address:**  
How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

|Parameter|Description|
|---------|-----------|
|dtPlt|data table containing the data to plot|
|fname|name of the file the plot has to sent to|
|imgSize|size/dimension (<pixels height>x<pixels width>x<resolution>) of the plot generated and written to file|
|cnty|five-digit number indicating the U.S. county|

Table: Input parameter

|Result|Description|
|------|-----------|
|TRUE|success; data have been plot both the screen as well as the file|
|FALSE|failure|

Table: Output value

**Note**  
All of dtPlt, fname, imgSize, and cnty have to be provided, and set to a non-NULL value.  

### lib/plot6.R

Plot the data provided both to the screen as well as a file (format png) by facilitating the R base plot system only

**Question to address:**  
Compare emissions from motor vehicle sources in Baltimore City (fips == "24510") with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

|Parameter|Description|
|---------|-----------|
|dtPlt|data table containing the data to plot|
|fname|name of the file the plot has to sent to|
|imgSize|size/dimension (<pixels height>x<pixels width>x<resolution>) of the plot generated and written to file|
|cnty1|five-digit number indicating the U.S. county|
|cnty2|five-digit number indicating the U.S. county|

Table: Input parameter

|Result|Description|
|------|-----------|
|TRUE|success; data have been plot both the screen as well as the file|
|FALSE|failure|

Table: Output value

**Note**  
All of dtPlt, fname, imgSize, cnty1, and cnty2 have to be provided, and set to a non-NULL value.  

### lib/rdepanei.R

Read raw data, in particular the PM2.5 Emissions data from the National Emissions Inventory (NEI) (imported from the EPA National Emissions Inventory) into a corresponding data structure

The variables _*```fips```*_, _*```SCC```*_, _*```Pollutant```*_, and _*```type```*_ are getting converted into class _*```factor```*_. Additionally variable _*```type```*_ is getting amended in such a manner that all values starting with _*NON*_ or _*ON*_ are separated from the remainder by a dash (_*-*_).

|Parameter|Description|
|---------|-----------|
|basedir|base directory to read files from|
|fname|file to read|

Table: Input parameter

|Result|Description|
|------|-----------|
|data table|success; data table containing the read raw data|
|NULL|failure|

Table: Output value

**Note**  

+ both--baseDir and fname--have to be provided, and set to a non-NULL value.

### lib/rdepascc.R

Read raw data, in particular the Source Classification Code data from the National Emissions Inventory (NEI) (imported from the EPA National Emissions Inventory) into a corresponding data structure

An additional variable _*```type```*_ is getting created by processing variable _*```Data.Category```*_ in such a manner that the values are converted to uppercase ones, and all values starting with _*NON*_ or _*ON*_ are separated from the remainder by a dash (_*-*_).

|Parameter|Description|
|---------|-----------|
|basedir|base directory to read files from|
|fname|file to read|

Table: Input parameter

|Result|Description|
|------|-----------|
|data table|success; data table containing the read raw data|
|NULL|failure|

Table: Output value

**Note**  

+ both--baseDir and fname--have to be provided, and set to a non-NULL value.

### lib/setusragnt.R

Set user agent to a "real" browser (instead of pointing to the R environment/session).

|Parameter|Description|
|---------|-----------|
|NONE||

Table: Input parameter

|Result|Description|
|------|-----------|
|NONE||

Table: Output value

*****
[epahome]: <http://www.epa.gov/ttn/chief/eiinformation.html>
[epadata]: <https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip>
[ghrepo]: <https://github.com/Sil68/ExploratoryDataAnalysisCourseProject2.git>
[plot1]: <https://github.com/Sil68/ExploratoryDataAnalysisCourseProject2/blob/master/plot1.png>
[plot2]: <https://github.com/Sil68/ExploratoryDataAnalysisCourseProject2/blob/master/plot2.png>
[plot3]: <https://github.com/Sil68/ExploratoryDataAnalysisCourseProject2/blob/master/plot3.png>
[plot4]: <https://github.com/Sil68/ExploratoryDataAnalysisCourseProject2/blob/master/plot4.png>
[plot5]: <https://github.com/Sil68/ExploratoryDataAnalysisCourseProject2/blob/master/plot5.png>
[plot6]: <https://github.com/Sil68/ExploratoryDataAnalysisCourseProject2/blob/master/plot6.png>
