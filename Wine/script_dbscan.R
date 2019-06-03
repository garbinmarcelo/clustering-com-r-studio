# Define pasta de trabalho e localização do arquivo dataset
setwd("D:/_dev/Web/www/_mestrado/agrupamento-com-r-studio/Wine")

library(fpc)

#carragamento do dataset
Wine = read.csv("wine.data", h = T)
Wine2 = na.omit(Wine)
View(Wine2)

#preparação dos dados para clusterização: Atributo alvo = classe. (Atributo é removido do dataset para realizar a clusterização)
Wine2.features = Wine2
Wine2.features$class <- NULL
View(Wine2.features)

#install.packages("dbscan")
library(dbscan)

kNNdistplot(Wine2.features, k = 3)

results <- dbscan(Wine2.features, eps = 48, minPts = 3)
results

#pplotagem do resultados: neste exemplo (petal.length x petal.width)
plot(Wine2.features[], col = results$cluster)

#pplotagem do resultados: neste exemplo (petal.length x petal.width)
plot(Wine2.features[c("Alcohol", "Magnesium")], col = results$cluster)

#plotagem dos dados utilizando coordenadadas discriminantes em um arquyivo .png
png(file="resultado_dbscan.png", width=1000, height=700)#salva em png plot
plotcluster(Wine2.features, results$cluster, method = "dc")

results_to_save = data.frame(Wine2.features, results$cluster)

#gravação dos resultados em arquivos
write.csv(results_to_save, file = "resultado_dbscan.csv")
dev.off()
