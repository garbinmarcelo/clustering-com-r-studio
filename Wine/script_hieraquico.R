# Define pasta de trabalho e localização do arquivo dataset
setwd("D:/_dev/Web/www/_mestrado/agrupamento-com-r-studio/Wine")

#carragamento do dataset
Wine = read.csv("wine.data", h = T)
Wine2 = na.omit(Wine)
View(Wine2)

#preparação dos dados para clusterização: Atributo alvo = classe. (Atributo é removido do dataset para realizar a clusterização)
Wine2.features = Wine2
Wine2.features$class <- NULL
View(Wine2.features)

d <- dist(Wine2.features)
results <- hclust(d, "single")
plot(results)

rect.hclust(results, k = 4, border = "red")
clusters <- cutree(results, 4)
clusters

#pplotagem do resultados: neste exemplo (petal.length x petal.width)
plot(Wine2.features[], col = clusters)

#pplotagem do resultados: neste exemplo (petal.length x petal.width)
plot(Wine2.features[c("Alcohol", "Magnesium")], col = clusters)

