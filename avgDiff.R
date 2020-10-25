avgDiff <- function(data, attribute.col, k, ranks=1, power = 1, mode="linear") {
  require(data.table)
  require(FNN)
  require(sp)
  
  knn <- get.knn(sp::coordinates(data), k=k)
  near.neighbors <- as.data.table(knn)
  
  if (mode == "linear") {
    near.neighbors <- near.neighbors[,(k+1):ncol(near.neighbors)]
    near.neighbors$sum <- rowSums(near.neighbors, na.rm = FALSE, dims = 1)
    weights <- near.neighbors[,1:(ncol(near.neighbors)-1)]/near.neighbors$sum
  }
  
  if (mode == "inverse") {
    near.neighbors <- near.neighbors[,(k+1):ncol(near.neighbors)]
    weights <-(1/(near.neighbors^power))
  }
  
  col <- which(colnames(data@data)==attribute.col)
  attributes <- data@data[c(knn$nn.index), col]
  attributes <- data.frame(matrix(unlist(attributes), ncol=k), stringsAsFactors=FALSE)
  
  table <- cbind(seq(1:nrow(attributes)), attributes)
  
  difference <- abs(data@data[c(table[,1]), col] - table[,2:ncol(table)])
  
  weighted_difference <- as.data.table(difference) * weights
  
  result <- as.data.table(cbind(seq(1:nrow(weighted_difference)), as.data.table(rowSums(weighted_difference))))
  names(result) <- c("ID", "AvgDiff")
  result <- result[order(-AvgDiff)]
  
  data$id <- 1:nrow(data)
  ranked_diffs <- result[1:2000,1]
  data <- subset(data, !data$Id %in% as.list(ranked_diffs$ID))
  data
}