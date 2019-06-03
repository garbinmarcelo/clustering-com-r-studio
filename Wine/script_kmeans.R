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

#clusterização dos dados utilizando o algoritmo kmeans
results <- kmeans(Wine2.features, 3, iter.max = 10)
results

#visualização das informações do clusters resultantes
table(Wine2$class, results$cluster)


#pplotagem do resultados: neste exemplo (petal.length x petal.width)
plot(Wine2.features[], col = results$cluster)

#pplotagem do resultados: neste exemplo (petal.length x petal.width)
plot(Wine2.features[c("Alcohol", "Magnesium")], col = results$cluster)
