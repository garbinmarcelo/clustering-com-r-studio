# Define pasta de trabalho e localização do arquivo dataset
setwd("D:/_dev/Web/www/_mestrado/agrupamento-com-r-studio/Iris")

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

# É construída a matriz de distancias entre cada elemento da base de dados Iris2.features
d <- dist(Iris2.features)
# É aplicado o algoritmo de clusterização hierárquica na matriz de distâncias d utilizando o método "single".
# Pode-se utilizar outros métodos como "complete" e "average".
results <- hclust(d, "single")

# Plotagem do dendograma originado pelos resultados (results).
plot(results)

# Realiza um recorte no dendograma originado de results, separando o dendograma em k grupos (k = 4).
# A tag border define a cor dos retângulos que realizam o recorte.
rect.hclust(results, k = 4, border = "red")
clusters <- cutree(results, 4)

# Gera uma estrutura que indica a qual cluster pertence cada elemento da base de dados, 
# referenciando pelo índice da estrutura.
clusters

# Plotagem do resultados: neste exemplo (petal.length x petal.width)
plot(Iris2[], col = clusters)

# Plotagem do resultados: neste exemplo (petal.length x petal.width)
plot(Iris2[c("petal.length", "petal.width")], col = clusters)