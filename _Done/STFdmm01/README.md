[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **STFdmm01** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet: STFdmm01

Published in: Statistical Tools for Finance and Insurance

Description: 'Calculates the minimum spanning tree (MST) and presents the results as a set of links for company data set (close.csv). The data contains 20 stocks listet in S&P 500. The links are presented in the order of attachments. The matlab version equires mst.m to run the program.'

Keywords: financial, distance, tree, portfolio, asset

See also: mst, STFdmm11

Author: Janusz Miskiewicz, Awdesch Melzer

Submitted: Fri, November 09 2012 by Dedy Dwi Prastyo

Datafile: close.csv





```

### R Code
```r

# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

########################################### Subroutine mst(x) ############


mst = function(x) {
    # Algorithm generates minimum spanning tree The rsult is presentes as a set of links between nodes
    n = nrow(x)
    m = ncol(x)
    true = upper.tri(x)
    x = true * x
    net = matrix(0, n - 1, 3)
    onnet = rep(as.integer(0), n)
    klaster = rep(as.integer(0), n)
    klast = 0L
    licz = 0L
    # check if the matrics is symmetric and positive
    maxx = max(apply(x, 2, max))
    smax = 10 * abs(maxx)
    x[x == 0] = smax
    while (licz < n - 1) {
        
        minx = min(apply(x, 2, min))
        d = which(x <= minx, arr.ind = T)
        i = d[, 1]
        j = d[, 2]
        if (length(i) > 1) {
            ii = i[1]
            jj = j[1]
            i = 0
            j = 0
            i = ii
            j = jj
        }
        
        if (onnet[i] == 0 & onnet[j] == 0) {
            licz = licz + 1L
            net[licz, 1] = i
            net[licz, 2] = j
            klast = klast + 1L
            klaster[i] = klast
            klaster[j] = klast
            net[licz, 3] = min(x[i, j], x[j, i])
            onnet[i] = 1
            onnet[j] = 1
            x[i, j] = smax
            x[j, i] = smax
            
        } else if (onnet[i] == 0 & onnet[j] == 1) {
            licz = licz + 1
            net[licz, 1] = i
            net[licz, 2] = j
            net[licz, 3] = min(x[i, j], x[j, i])
            onnet[i] = 1
            klaster[i] = klaster[j]
            x[i, j] = smax
            x[j, i] = smax
        } else if (onnet[i] == 1 & onnet[j] == 0) {
            licz = licz + 1L
            net[licz, 1] = i
            net[licz, 2] = j
            net[licz, 3] = min(x[i, j], x[j, i])
            onnet[j] = 1
            klaster[j] = klaster[i]
            x[i, j] = smax
            x[j, i] = smax
        } else if (onnet[i] == 1 & onnet[j] == 1 & klaster[i] == klaster[j]) {
            x[i, j] = smax
            x[j, i] = smax
        } else if (onnet[i] == 1 & onnet[j] == 1 & klaster[i] != klaster[j]) {
            licz = licz + 1L
            net[licz, 1] = i
            net[licz, 2] = j
            net[licz, 3] = min(x[i, j], x[j, i])
            klaster[klaster == klaster[i]] = klaster[j]
        }
    }
    retval = net
    return(retval)
}


######################################## Main calculation ############

data = read.table("close.csv", header = T)  # load data

data = diff(log(as.matrix(data)))  # log returns
data = cor(data)  # correlations of log returns
odl = sqrt(0.5 * (1 - data))
mst_odl = mst(odl)  # minimum span tree


companies = c("ABB", "AAPL", "BA", "KO", "EMR", "GE", "HPQ", "HIT", "IBM", "INTC", "JNJ", "LMT", "MSFT", "NOC", "NVS", "CL", 
    "PEP", "PG", "TSEM", "WEC")  # company names
odl.true = upper.tri(odl, 1)  # upper triangle
odl = odl.true * odl


MST_UD = cbind(as.character(companies[mst_odl[, 1]]), as.character(companies[mst_odl[, 2]]), as.numeric(round(mst_odl[, 3], 
    3)))  # company i and j and MST
colnames(MST_UD) = c("i", "j", "D_U(i,j)")

MST_UD  # results 

```

automatically created on 2018-05-28

### MATLAB Code
```matlab

% clear variables and close windows
clear all
close all
clc


data      = load('close.csv'); % load data
data      = diff(log(data));   % log returns
data      = corr(data);        % correlations of log returns
odl       = sqrt(0.5*(1-data));
mst_odl   = mst(odl);          % minimum span tree

format short;
companies = char('ABB  ','AAPL ','BA   ','KO   ','EMR   ','GE   ','HPQ  ','HIT  ','IBM  ','INTC ','JNJ  ','LMT  ','MSFT ','NOC  ','NVS  ','CL    ','PEP  ','PG    ','TSEM ','WEC  ');
odl       = triu(odl,1);
MST_UD    = [companies(mst_odl(:,1),:),companies(mst_odl(:,2),:),num2str(mst_odl(:,3),4)];
MST_UD
```

automatically created on 2018-05-28