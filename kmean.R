
## Import the datasets

df1 <- read.csv('winequality-red.csv',sep=';')
df2 <- read.csv('winequality-white.csv',sep=';')

## Add a label column to both df1 and df2 indicating a label 'red' or 'white'
## Using sapply with anon functions

df1$label <- sapply(df1$pH,function(x){'red'})
df2$label <- sapply(df2$pH,function(x){'white'})

## Check the head of the data

head(df1)
head(df2)

## Combine df1 and df2

wine <- rbind(df1, df2)
head(wine)

str(wine)

## Exploratory data analysis
## lets's explore the data a bit

## load ggplot2

library(ggplot2)

## Create a Histogram of residual sugar from the wine data. Color by red and white wines

pl <- ggplot(wine,aes(x=residual.sugar)) + geom_histogram(aes(fill=label),
                                                          color='black',bins=50)
pl + scale_fill_manual(values = c('#ae4554','#faf7ea')) + theme_bw()

## Create a Histogram of citric.acid from the wine data. Color by red and white wines.

pl <- ggplot(wine,aes(x=citric.acid)) + geom_histogram(aes(fill=label),
                                                       color='black',bins=50)
pl + scale_fill_manual(values = c('#ae4554','#faf7ea')) + theme_bw()

## Create a Histogram of alcohol from the wine data. Color by red and white wines
pl <- ggplot(wine,aes(x=alcohol)) + geom_histogram(aes(fill=label),
                                                   color='black',bins=50)
pl + scale_fill_manual(values = c('#ae4554','#faf7ea')) + theme_bw()

## Create a scatterplot of residual.sugar versus citric.acid, color by red and white wine.

pl <- ggplot(wine,aes(x=citric.acid,y=residual.sugar)) + geom_point(aes(color=label),alpha=0.2)
pl + scale_color_manual(values = c('#ae4554','#faf7ea')) +theme_dark()

## Create a scatterplot of volatile.acidity versus residual.sugar, color by red and white wine.

pl <- ggplot(wine,aes(x=volatile.acidity,y=residual.sugar)) + geom_point(aes(color=label),alpha=0.2)
pl + scale_color_manual(values = c('#ae4554','#faf7ea')) +theme_dark()

## Let's pull out the wine data without the label and call it clus.data

clus.data <- wine[,1:12]

head(clus.data)

## Building the Clusters using Kmeans
wine.cluster <- kmeans(wine[1:12],2)

## Print out the wine.cluster cluster means and explore the information

print(wine.cluster$centers)

##EVALUATING THE CLUSTERS
####You usually won't have the luxury of labeled data with KMeans,
####but let's go ahead and see how we did

table(wine$label,wine.cluster$cluster)


##########We can see that red is easier to cluster together,
##which makes sense given our previous visualizations.
##There seems to be a lot of noise with white wines,
##this could also be due to "Rose" wines being categorized as white wine,
##while still retaining the qualities of a red wine.
##Overall this makes sense since wine is essentially just fermented grape juice
##and the chemical measurements we were provided may not correlate
##well with whether or not the wine is red or white!

##It's important to note here,
##that K-Means can only give you the clusters,
##it can't directly tell you what the labels should be,
##or even how many clusters you should have,
##we are just lucky to know we expected two types of wine.
##This is where domain knowledge really comes into play.
