#Required Packages
library(data.table)
library(FNN)
library(sp)

avgDiff <- function(data, attribute.col, k) {
  
  #KNN data.table
  knn <- get.knn(sp::coordinates(data), k=k)
  near.neighbors <- as.data.table(knn)
  
  #Extract Distances without Indices (introduced by as.data.table)
  near.neighbors <- near.neighbors[,(k+1):ncol(near.neighbors)]
  
  #Sum Distances for Spatial Weighting
  near.neighbors$sum <- rowSums(near.neighbors, na.rm = FALSE, dims = 1)
  
  #Divide every Distance by Sum to get the Weight
  weights <- near.neighbors[,1:(ncol(near.neighbors)-1)]/near.neighbors$sum
  
  #Replace Indeces by corresponding Attribute
  col <- which(colnames(data@data)==attribute.col)
  attributes <- data@data[c(knn$nn.index), col]
  attributes <- data.frame(matrix(unlist(attributes), ncol=k), stringsAsFactors=FALSE)
  #identical(dim(weights), dim(attributes)) #TRUE!
  
  #Add Index of Point that corresponds to Nearest Neighbors Attributes
  table <- cbind(seq(1:nrow(attributes)), attributes)
  
  #Calculate Absolute Difference 
  difference <- abs(data@data[c(table[,1]), col] - table[,2:ncol(table)])
  
  #Calculate Weighted Difference
  weighted_difference <- as.data.table(difference) * weights
  
  #Bind Averaged Difference with corresponding Index (Decreasing Order)
  result <- as.data.table(cbind(seq(1:nrow(weighted_difference)), as.data.table(rowSums(weighted_difference))))
  names(result) <- c("ID", "AvgDiff")
  result <- result[order(-AvgDiff)]
  result
  
}

##Apply Function
#averaged_differences <- avgDiff(data, attribute.col, k=355)

##Select top 1200 Outliers (Example)
#ranked_differences <- averaged_differences[1:1200,1]

##Subset Original Data Set
#cleansed <- subset(data, !data$id %in% as.list(ranked_differences$ID))
#plot(cleansed)