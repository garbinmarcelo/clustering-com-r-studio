# Define pasta de trabalho e localização do arquivo dataset
setwd("D:/_dev/Web/www/_mestrado/agrupamento-com-r-studio/Iris")

# Instala pacotes
#install.packages("factoextra")
# Chama pacotes
library(factoextra)

# Carragamento do dataset, informa que o dataset possui cabeçalho
Iris = read.csv("iris_data.csv", header = T)

# É realizada cópia do dataset em uma nova variável 
# omitindo possíveis erros de dados (ausencia de valores, not-a-number, etc..)
Iris2 = na.omit(Iris)

# É chamada a visualização do dataset
View(Iris2)

# Preparação dos dados para clusterização: Atributo alvo = classe. 
# (Atributo é removido do dataset para realizar a clusterização)
Iris2.features = Iris2
Iris2.features$class <- NULL
View(Iris2.features)

# Definir quantidade ideal de cluster
fviz_nbclust(Iris2.features, kmeans, "wss")

# Clusterização dos dados utilizando o algoritmo kmeans
results <- kmeans(Iris2.features, 3, iter.max = 5)
results

# Visualização das informações do clusters resultantes
table(Iris2$class, results$cluster)

# Plotagem do resultados: neste exemplo (petal.length x petal.width)
plot(Iris2.features[], col = results$cluster)

# Plotagem do resultados: neste exemplo (petal.length x petal.width)
plot(Iris2.features[c("petal.length", "petal.width")], col = results$cluster)

# 3D
#install.packages("scatterplot3d")
require("scatterplot3d")

scatterplot3d(Iris2.features[])

#install.packages("rgl")
library(rgl)
plot3d(Iris[,1:3], col=results$cluster, main="k-means clusters")
