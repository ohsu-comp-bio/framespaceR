# Framespace R Client

This R package contains functions to access and manipulate data from the framespace server.

## Instalation Instructions:
#### Currently the dependencies don't seem to be installing automatically so in the meantime to install enter the following into R:

```
list.of.packages <- c("httr", "xml2", "jsonlite", "devtools")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(httr)
library(jsonlite)
library(xml2)
library(devtools)
install_github("ohsu-computational-biology/framespace_r_client/framespacer")
library(framespacer)
```

##Example:
####Suppose you want to access data on a few genes from the tcga.BRCA tsv but you don't know the keyspaces Id for that tsv nor the dataframe id for the dataset you wish to access.
####First, you would need to format a request to find the keyspaces id:
```
> keyRequest <- keysearch(names = "tcga.BRCA", axisNames ="sample")
```
####Request setup functions format the request into a list like so:
```
> keyRequest
$axisNames
[1] "sample"

$names
[1] "tcga.BRCA"
```
(While the request setup functions are not strictly necessary they can help if you are unsure how to correctly set up a list to use as a request. The syntax has to be specific due to how the post function converts it into a json object)
```
> keyResponse <- framereq(host = "192.168.99.100", port = "5000", end = "/keyspaces/search", req = keyRequest)
```
####You can then use keyidfind to easily extract the keyspace id you need:
```
> keyidfind(keyResponse)
[1] "579128f46ac4ff507bde9091"
```
####Now that you have this id you can use it to find the dataframe id you want:
```
> dfRequest <- dfsearch(keyspaceIds = "579128f46ac4ff507bde9091")
> dfResponse <- framereq(host = "192.168.99.100", port = "5000", end = "/keyspaces/search", req = dfRequest)
> dfidfind(dfResponse)
[1] "57912977105a6c0d293bbe8e"
```
####You can then use the dataframe id to setup a /dataframe/slice request:
```
> request <- dfslice("57912977105a6c0d293bbe8e", 
                      pageEnd = 3, 
                      newMajor = c("TCGA-S3-A6ZG-01A-22R-A32P-07", "TCGA-AR-A250-01A-31R-A169-07", "TCGA-C8-A1HK-01A-21R-A13Q-07"))
```
(In this example we only requested the first 3 genes and 3 specific samples so that it would be easier to look at)
####You can then submit the request in packets (default is packets of 1000 pages) using bufferreq. This returns the response in a list:
```
> response <- bufferreq(host = "192.168.99.100", port = "5000", end = "/dataframe/slice", req = request, buffer = 1000)
> str(response)
List of 4
 $ contents:List of 3
  ..$ A1BG|1     :List of 3
  .. ..$ TCGA-AR-A250-01A-31R-A169-07: num 139
  .. ..$ TCGA-C8-A1HK-01A-21R-A13Q-07: num 15.5
  .. ..$ TCGA-S3-A6ZG-01A-22R-A32P-07: num 161
  ..$ A1CF|29974 :List of 3
  .. ..$ TCGA-AR-A250-01A-31R-A169-07: num 0.828
  .. ..$ TCGA-C8-A1HK-01A-21R-A13Q-07: num 0
  .. ..$ TCGA-S3-A6ZG-01A-22R-A32P-07: num 0.935
  ..$ A2BP1|54715:List of 3
  .. ..$ TCGA-AR-A250-01A-31R-A169-07: num 0
  .. ..$ TCGA-C8-A1HK-01A-21R-A13Q-07: num 0.5
  .. ..$ TCGA-S3-A6ZG-01A-22R-A32P-07: num 0.312
 $ id      : chr "57912977105a6c0d293bbe8e"
 $ major   :List of 2
  ..$ keys      :List of 3
  .. ..$ : chr "TCGA-S3-A6ZG-01A-22R-A32P-07"
  .. ..$ : chr "TCGA-C8-A1HK-01A-21R-A13Q-07"
  .. ..$ : chr "TCGA-AR-A250-01A-31R-A169-07"
  ..$ keyspaceId: chr "579128f46ac4ff507bde9091"
 $ minor   :List of 2
  ..$ keys      :List of 3
  .. ..$ : chr "A1BG|1"
  .. ..$ : chr "A2BP1|54715"
  .. ..$ : chr "A1CF|29974"
  ..$ keyspaceId: chr "579128fd6ac4ff507bde90a3"
```
####Values in this list are accessed in the contents section under the gene and sample names:
```
> response$contents$`A1BG|1`$`TCGA-AR-A250-01A-31R-A169-07`
[1] 139.351
```
####This response can also be formed into a dataframe using the following function:
```
> responseMatrix <- genematrix(response)
> view(responseMatrix)
                                         A1BG|1           A1CF|29974          A2BP1|54715
TCGA-AR-A250-01A-31R-A169-07           139.3510               0.8278               0.0000
TCGA-C8-A1HK-01A-21R-A13Q-07            15.5039               0.0000               0.5001
TCGA-S3-A6ZG-01A-22R-A32P-07           160.6870               0.9355               0.3118
```
(Can also be formed into a matrix if the df argument is set to FALSE e.g. genematrix(response, df = FALSE))
####Now individual values are called like this:
```
> responseMatrix['TCGA-AR-A250-01A-31R-A169-07', 'A1BG|1']
[1] 139.351
```
####Or if you want to call all of the values for a specific gene:
```
> responseMatrix$`A1BG|1`
[1] 139.3510   0.8278   0.0000
```
(If using a matrix the unname function can be used to get rid of sample names in the output. e.g. unname(responseMatrix['A1BG|1',]) This would not be necessary to pass those values through a function.)
####You can quickly get a few summary statistics directly from the response using the genestat function:
```
> responseStats <- genestat(response)
> str(responseStats)
List of 3
 $ A1BG|1     :List of 5
  ..$ mean  : num 105
  ..$ var   : num 6145
  ..$ median: num 139
  ..$ min   : num 15.5
  ..$ max   : num 161
 $ A1CF|29974 :List of 5
  ..$ mean  : num 0.588
  ..$ var   : num 0.262
  ..$ median: num 0.828
  ..$ min   : num 0
  ..$ max   : num 0.935
 $ A2BP1|54715:List of 5
  ..$ mean  : num 0.271
  ..$ var   : num 0.0638
  ..$ median: num 0.312
  ..$ min   : num 0
  ..$ max   : num 0.5
```
####If you don't want to look at all the genes specify which genes you want to look at:
```
> responseStats <- genestat(response, genes = c('A1BG|1', 'A1CF|29974'))
> str(responseStats)
List of 2
 $ A1BG|1    :List of 5
  ..$ mean  : num 105
  ..$ var   : num 6145
  ..$ median: num 139
  ..$ min   : num 15.5
  ..$ max   : num 161
 $ A1CF|29974:List of 5
  ..$ mean  : num 0.588
  ..$ var   : num 0.262
  ..$ median: num 0.828
  ..$ min   : num 0
  ..$ max   : num 0.935
```
