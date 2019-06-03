# Define pasta de trabalho e localização do arquivo dataset
setwd("D:/_dev/Web/www/_mestrado/agrupamento-com-r-studio/Iris")

# Instala pacotes
#install.packages("fpc")
#install.packages("dbscan")
# Chama pacotes
library(fpc)
library(dbscan)

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

# Calcular e traçar a distância vizinha mais próxima de k
# O gráfico pode ser usado para ajudar a encontrar um valor adequado para a vizinhança do eps
kNNdistplot(Iris2.features, k = 3)

results <- dbscan(Iris2.features, eps = 0.6, minPts = 4)
results

# Plotagem do resultados: neste exemplo (petal.length x petal.width)
plot(Iris2[], col = results$cluster)

# Plotagem do resultados: neste exemplo (petal.length x petal.width)
plot(Iris2[c("sepal.length", "sepal.width")], col = results$cluster)

# Plotagem dos dados utilizando coordenadadas discriminantes em um arquivo .png
# Salva em png plot
png(file="resultado_dbscan.png", width=1000, height=700)
plotcluster(Iris2.features, results$cluster, method = "dc")

results_to_save = data.frame(Iris2.features, results$cluster)

# Gravação dos resultados em arquivos
write.csv(results_to_save, file = "resultado_dbscan.csv")
dev.off()
