yield.cleanse <- function(yield_data, verbose=TRUE, stand.dev=0.8) {
  cleansed_yield <- yield_data[!(yield_data$ErtrTRVol<mean(yield_data$ErtrTRVol-(stand.dev)*sd(yield_data$ErtrTRVol))) & !(yield_data$ErtrTRVol>mean(yield_data$ErtrTRVol+1.8*sd(yield_data$ErtrTRVol))),]
  if(isTRUE(verbose)){
    message(mean(yield_data$ErtrTRVol-sd(yield_data$ErtrTRVol)))
    message(mean(yield_data$ErtrTRVol+1.8*sd(yield_data$ErtrTRVol)))
  }
  return(cleansed_yield)
  #cleansed_yield <- cleansed_yield[-sp::zerodist(cleansed_yield, zero=0.00015)[,1],]
}


drv <- DBI::dbDriver("PostgreSQL")

con <- DBI::dbConnect(RPostgres::Postgres()
                      , host='localhost'
                      , port='5432'
                      , dbname='spatial_master'
                      , user='postgres'
                      , password="12ab")

yield10 <- rpostgis::pgGetGeom(con, c("test", "Yield_Lammwirt_2010"))

easy10 <- yield10
#easy10 <- easy10[(easy10$ErtrTRVol>quantile(easy10$ErtrTRVol, probs=0.075) & easy10$ErtrTRVol<quantile(easy10$ErtrTRVol, probs=0.99)),]
hist(easy10$ErtrTRVol, 1000, axes=FALSE, freq=F)

library(spdep)
library(data.table)
tic()
k <- 355
testus <- get.knn(coordinates(easy10), k=k)
test <- as.data.table(testus)
test <- test[,(k+1):ncol(test)]
test$sum <- rowSums (test, na.rm = FALSE, dims = 1)

weights <- test[,1:(ncol(test)-1)]/test$sum

indices <- testus$nn.index
rplc.val <- easy10@data$ErtrTRVol[c(indices)]
rplc.val <- data.frame(matrix(unlist(rplc.val), ncol=k),stringsAsFactors=FALSE)
identical(dim(weights), dim(rplc.val)) #TRUE!

index <- seq(1:nrow(rplc.val))

table <- cbind(index, rplc.val)

weighted <- abs(easy10@data$ErtrTRVol[c(table$index)] - table[,2:ncol(table)])

result <- as.data.table(weighted) * weights

final <- as.data.table(cbind(seq(1:nrow(result)),as.data.table(rowSums(result))))
names(final) <- c("ID", "AvgDiff")
final_order <- final[order(-AvgDiff)]
final_ids <- final_order[1:1200,1]

corrected_yield <- easy10[!easy10$id %in% as.list(final_ids$ID), ]
hist(corrected_yield$ErtrTRVol, 2500, axes=FALSE, freq=F)

yield10_ <- subset(yield10, !yield10$id %in% as.list(final_ids$ID))
plot(yield10_)

toc()

yield10_@data$Obj_ID <- as.numeric(yield10_@data$Obj_ID)
writeOGR(yield10_, layer = 'myshp_simplified', 'C:/temp', driver="ESRI Shapefile", overwrite_layer=TRUE)

##############
library(viridis)
yield10df <- as.data.frame(yield10_)

ggplot() +
  geom_point(data= yield10df, aes(x=x, y=y, colour  = ErtrTRVol)) +
  scale_color_viridis(limits=c(4, 12000))

xx <- as.data.frame(easy10)
ggplot() +
  geom_point(data= xx, aes(x=x, y=y, colour  = ErtrTRVol)) +
  scale_color_viridis(limits=c(4, 12000))

