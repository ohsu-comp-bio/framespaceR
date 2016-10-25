# framespacer 

R Package to pull FrameSpace DataFrames into your R environment and use as native R objects. 

## Installation Instructions:

```
install_github("ohsu-computational-biology/framespace_r_client/framespacer")
library(framespacer)
```

##Quick DataFrame Grab
The get.dataframe() function is designed to allow a user to retrieve a (currently whole) dataframe from a FrameSpace instance by providing a KeySpace name and a Unit name. For example, if a user would like to get rsem values from the ACC TCGA live example data this could be achieved by the following call:

```
df <- get.dataframe('<framespace_ip>:5000', 'tcga-ACC', 'tcga-gene-expression')
```

This will perform the series of required steps to consolidate the dataframe from FrameSpace into R and convert it to a FrameSpace dataframe. 

Note that it is suggested to save your FrameSpace host (ip:port or aliased hostname) as a variable for ease of use. Ie. to repeat the above:
```
fs <- '<framespace_ip>:5000'
df <- get.dataframe(fs, 'tcga-ACC', 'tcga-gene-expression')
```

The rest of the examples will use `fs` in place of the FrameSpace url to query.

##Make Raw Requests:
It may be common for a user to want to quickly query a FrameSpace instance from inside R to explore the data, make sure things are working properly, etc. For this reason all the standard FrameSpace search requests are exposed to use when upon calling `library(framespacer)`, including the `as.data.frame` method that can be called on a FrameSpace DataFrame response from `dfslice()`. 

The search function will all format a request and return a response from the provided FrameSpace url. These functions, other than dfslice, will return data as a parsed json response (nested list style R object). If you specifiy, `raw = TRUE` you can see just the first bit of the raw response returned from the FrameSpace server. dfslice will return what appears to be the same nested list style, but it is actually of class `framespace`. This enables the `framespacer as.data.frame method` to be called on the FrameSpace DataFrame response that is returned, thus producing an R data.frame.  

##Note about RProtoBuf
Following suit with the FrameSpace API, the request objects within the search functions are built using [RProtoBuf](https://github.com/eddelbuettel/rprotobuf). Upon calling `library(framespacer)` the available FrameSpace messages are available for your use. An example usage is as follows:

```
p <- new(framespace.Axis)
```

