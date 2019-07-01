# Define pasta de trabalho e localização do arquivo dataset
setwd("D:/_dev/Web/www/_mestrado/agrupamento-com-r-studio/Truco")

# Instala pacotes
install.packages("factoextra")
install.packages("rgl")
install.packages("RMySQL")
# Chama pacotes
library(factoextra)
library(rgl)
library(DBI)


# Conexão com MySQL
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "dbtrucocbrweb",
                 host = "127.0.0.1",
                 port = 3306,
                 user = "root",
                 password = "root")

# Lista as tabelas presentes no db
dbListTables(con)

# Retornar todos resultados da tabela maos
dados <- dbGetQuery(con, "SELECT * FROM maos;")

# Visualização dos dados da tabela
View(dados)

# Mostra as colunas contidas no retorno da query
colnames(dados)

# Mostra as colunas e os tipos de dados contidas no retorno da query
str(dados)

#
# Remover colunas (colunas que permanecem nos dados)
#
# Aqui duas formas para retornar as colunas que gostariam
# 1ª Nesta forma é selecionado o intervalo com base no array da dados
# neste exemplo estamos selecionando
# a coluna 1 até a 5 para retornar os dados é definida uma nova variavel
# e visualizado o retorno através dos metodos head e str
dadosFiltrados <- dados[1:5]
head(dadosFiltrados)
str(dadosFiltrados)
# 2ª Neste outra forma, utilizamos o metodo subset, passando nossos dados originais e selecionando
# apenas as colunas de dados que gostariamos de utilizar em nosso script
# é definida uma nova variavel e visualizado o retorno através dos metodos head e str
dadosFiltrados <- subset(dados, select = c(
  primeiraCartaRobo,
  primeiraCartaHumano,
  segundaCartaRobo,
  segundaCartaHumano,
  terceiraCartaRobo,
  terceiraCartaHumano)
)

# Retornar a primeira ou última parte de um objeto
head(dadosFiltrados)

# Mostra as colunas contidas no retorno da query
colnames(dadosFiltrados)

# Mostra as colunas e os tipos de dados contidas no retorno da query
str(dadosFiltrados)

# Podemos visualizar na tabela
View(dadosFiltrados)

# Verifica se possui valores NULL
dadosFiltrados[is.na(dadosFiltrados)]

# Seta valor 0 nos campos onde está como NULL
dadosFiltrados[is.na(dadosFiltrados)] <- 0

# Verifica novamente se possui valores NULL
dadosFiltrados[is.na(dadosFiltrados)]

# Fazer a checagem dos valores se estão de acordo na visualização da tabela
View(dadosFiltrados)

# Definir quantidade ideal de cluster
fviz_nbclust(dadosFiltrados, kmeans, "wss")

# Clusterização dos dados utilizando o algoritmo kmeans
results <- kmeans(dadosFiltrados, 4, iter.max = 5)
results

# Visualização das informações do clusters resultantes
table(dados$ganhadorMao, results$cluster)

# Plotagem do resultados
plot(dadosFiltrados[], col = results$cluster)

# Plotagem do resultados de atributos
plot(dadosFiltrados[c("primeiraCartaRobo", "primeiraCartaHumano")], col = results$cluster)

# Gera o plot em 3D
plot3d(dadosFiltrados, col=results$cluster, main="k-means clusters")

# Gera o arquivo em csv
# Salva os resultados em uma nova variavel
results_to_save = data.frame(dadosFiltrados, results$cluster)

# Gravação dos resultados em arquivo
write.csv(results_to_save, file = "resultado_kmeans.csv")

# Encerra conexão
dbDisconnect(con)
