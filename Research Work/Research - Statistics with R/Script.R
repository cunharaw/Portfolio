#############################################
#1.1 - LER FICHEIRO EXCEL E MOSTRAR DADOS
install.packages("readxl")

dados<-readxl::read_excel("Dataset.xlsx")

ls()

dados

View(dados)
#############################################

#############################################
#1.2 - OUTLIERS VARIAVEIS CONTINUAS

Q1_MKM <- quantile(dados[[5]], probs = 0.25, names = FALSE)
Q3_MKM <- quantile(dados[[5]], probs = 0.75, names = FALSE)

IQR_MKM<- Q3_MKM-Q1_MKM

Lower_MKM = Q1_MKM-(1.5*IQR_MKM)
Upper_MKM = Q1_MKM+(1.5*IQR_MKM)

dados_MKM <- dados[dados$`Maximo KM`>Lower_MKM,]
dadosfinal <- dados_MKM[dados_MKM$`Maximo KM`<Upper_MKM,]

View(dadosfinal)

cat("Outliers moderados Máximo KM, são os valores que se encontram fora do 
intervalo: [", Lower_MKM, ",", Upper_MKM,"]")
#############################################

#############################################
#1.3 - TABELAS

#1.3.1 - TABELA FREQ. E GRÁFICO: TIPO CINEMA

niC = table(dadosfinal[1]) #freq. absolutas simples tipo cinema
fiC = niC /sum(niC) #freq. relativas simples tipo cinema
NiC = cumsum(niC) #freq. absolutas acumuladas tipo cinema
FiC = cumsum(fiC) #freq. relativas acumuladas tipo cinema

tabelaTipoCimema = cbind(niC, fiC, NiC, FiC)

tabelaTipoCimema 

grafico_tipoCin <- barplot(niC,main="Distribuição por Tipo Cinema", 
ylab= "Número de Jovens",xlab="Tipo de cinema", , border="black", col="pink")
text(grafico_tipoCin, 0, round(niC, 1),cex=1,pos=3) 


#1.3.2 - TABELA FREQ. E GRÁFICO: DIAS DE FÉRIAS

#1 - numero classes

sum(niC)
k=sqrt(sum(niC))
k

#2 - amplitude das classes

summary(dadosfinal[2])

h = round ((max(dadosfinal[2])-min(dadosfinal[2]))/k,0)
h

#3 - criar as classes

lim=seq(trunc(min(dadosfinal[2]),0),max(dadosfinal[2]+h),h) 
lim

#4 - criar vetor com os limites das classes

classesFerias<-c("[11 12[","[12 13[","[13 14[","[14 15[","[15 16[","[16 17["
,"[17 18[","[18 19[","[19 20[","[20 21[","[21 22[","[22 23[","[23 24["
,"[24 25[","[25 26[") 

classesFerias

#5 - criar freq. absolutas simples

TabelaFerias = table(cut(dadosfinal[[2]],breaks=lim,right=FALSE,
labels=classesFerias))
TabelaFerias 

#6 - criar freq. restantes

fiF=round(prop.table(TabelaFerias), digits = 3)
NiF=cumsum(TabelaFerias) 
FiF=cumsum(fiF)

#7 - finalizar tabela

TabelaFerias2=cbind(TabelaFerias,fiF,NiF,FiF)
colnames(TabelaFerias2)[1]<- "niF" 

TabelaFerias2

grafico_ferias <- barplot(TabelaFerias ,main="Distribuição Dias de Férias", 
ylab= "Número de Jovens",xlab="Dias de Férias", border="black", col="purple")
text(grafico_ferias , 0, round(TabelaFerias, 1),cex=1,pos=3) 


#1.3.3 - TABELA FREQ. E GRÁFICO: GRAU DE GOSTO DE CINEMA

niG = table(dadosfinal[3]) #freq. absolutas simples grau gosto
fiG = round(niG /sum(niG),digits = 2) #freq. relativas simples grau gosto
NiG = cumsum(niG) #freq. absolutas acumuladas grau gosto
FiG = cumsum(fiG) #freq. relativas acumuladas grau gosto

tabelaGrau = cbind(niG, fiG, NiG, FiG)

tabelaGrau 

grafico_grauGosto <- barplot(niG,main="Distribuição por Grau de Gosto de Cinema"
, ylab= "Número de Jovens",xlab="Grau de Gosto de Cinema"
,border="black", col="lightblue")

text(grafico_grauGosto, 0, round(niG, 1),cex=1,pos=3) 


#1.3.4 - TABELA FREQ. E GRÁFICO: IDAS SEMANAIS AO CINEMA

niI = table(dadosfinal[4]) #freq. absolutas simples idas cinema
fiI = round(niI/sum(niI), digits = 3) #freq. relativas simples idas cinema
NiI = cumsum(niI) #freq. absolutas acumuladas idas cinema
FiI = cumsum(fiI) #freq. relativas acumuladas idas cinema

tabelaIdas = cbind(niI, fiI, NiI, FiI)

tabelaIdas

grafico_idasSem <- barplot(niI,main="Distribuição por Idas Semanais ao Cinema"
, ylab= "Número de Jovens",xlab="Idas Semanais ao Cinema"
, border="black", col="lightgreen")

text(grafico_idasSem , 0, round(niI, 1),cex=1,pos=3) 


#1.3.5 - TABELA FREQ. E GRÁFICO: MAXIMO KM

#1 - numero classes

sum(niC)
k=sqrt(sum(niC))
k

#2 - amplitude das classes
summary(dadosfinal[5])

h = round ((max(dadosfinal[5])-min(dadosfinal[5]))/k,0)
h

#3 - criar as classes
lim=seq(trunc(min(dadosfinal[5]),0),max(dadosfinal[5])+h,h) 
lim

#4 - criar vetor com os limites das classes
classes1<-c("[351 389[","[389 427[","[427 465[","[465 503[","[503 541["
,"[541 579[","[579 617[","[617 655[","[655 693]","[693 731]") 
classes1

#5 - criar freq. absolutas simples
Tabela1 = table(cut(dadosfinal[[5]],breaks=lim,right=FALSE,labels=classes1))
Tabela1 

#6 - criar freq. restantes
fiM=round(prop.table(Tabela1), digits = 3)
NiM=cumsum(Tabela1) 
FiM=cumsum(fiM)

#7 - finalizar tabela
Tabela2=cbind(Tabela1,fiM,NiM,FiM)
colnames(Tabela2)[1]<- "niM" 

Tabela2

grafico_km <- barplot(Tabela1,main="Distribuição Máximo KM"
, ylab= "Número de Jovens",xlab="Máximo KM", border="black", col="orange")
text(grafico_km, 0, round(Tabela1, 1),cex=1,pos=3)  


#1.3.6 - TABELA FREQ. E GRÁFICO: PREÇO MAX BILHETE

#1 - numero classes

sum(niC)
k2=sqrt(sum(niC))
k2

#2 - amplitude das classes
summary(dadosfinal[6])

h2 = round ((max(dadosfinal[6])-min(dadosfinal[6]))/k2,0)
h2

#3 - criar as classes
lim2=seq(trunc(min(dadosfinal[6]),0),max(dadosfinal[6])+h2,h2) 
lim2

#4 - criar vetor com os limites das classes
classes2<-c("[250 298[","[298 346[","[346 394[","[394 442[","[442 490["
,"[490 538[","[538 586[","[586 634[","[634 682]","[682 730]") 
classes2

#5 - criar freq. absolutas simples
Tabela3 = table(cut(dados[[6]],breaks=lim,right=FALSE,labels=classes2))
Tabela3 

#6 - criar freq. restantes
fiB=round(prop.table(Tabela1), digits = 3)
NiB=cumsum(Tabela1) 
FiB=cumsum(fiB)

#7 - finalizar tabela
Tabela4=cbind(Tabela3,fiB,NiB,FiB)
colnames(Tabela4)[1]<- "niB" 

Tabela4

grafico_bil <- barplot(Tabela3,main="Distribuição Preço Máximo Bilhete"
, ylab= "Número de Jovens",xlab="Preço Máximo Bilhete"
, border="black", col="red")

text(grafico_bil, 0, round(Tabela3, 1),cex=1,pos=3)  
#############################################

#############################################
1.4 - MEDIDAS DESCRITIVAS

#1.4.1 - MEDIDAS DE LOCALIZAÇÃO CENTRAL E NAO CENTRAL
summary(dadosfinal[2]) 
summary(dadosfinal[4])	
summary(dadosfinal[5])	
summary(dadosfinal[6])	


#1.4.2 - MEDIDAS DE DISPERSÃO
var(dadosfinal[[2]]) 
sd(dadosfinal[[2]]) 
cv1=sd(dadosfinal[[2]])/mean(dadosfinal[[2]]) 
cv1

var(dadosfinal[[4]]) 
sd(dadosfinal[[4]]) 
cv2=sd(dadosfinal[[4]])/mean(dadosfinal[[4]]) 
cv2

var(dadosfinal[[5]]) 
sd(dadosfinal[[5]]) 
cv3=sd(dadosfinal[[5]])/mean(dadosfinal[[5]]) 
cv3

var(dadosfinal[[6]]) 
sd(dadosfinal[[6]]) 
cv4=sd(dadosfinal[[6]])/mean(dadosfinal[[6]]) 
cv4


#1.4.3 - MEDIDAS DE FORMA

#Package para calcular assimetria e curtose
install.packages("e1071")
library(e1071)

#ASSIMETRIA - Coeficiente de Assimetria de Pearson
skewness(dadosfinal[[2]])
skewness(dadosfinal[[4]])
skewness(dadosfinal[[5]])
skewness(dadosfinal[[6]])

#CURTOSE
kurtosis(dadosfinal[[2]])
kurtosis(dadosfinal[[4]])
kurtosis(dadosfinal[[5]])
kurtosis(dadosfinal[[6]])

#DIAGRAMA DE EXTREMOS E QUARTIS
boxplot(dadosfinal[2], main="Distribuição dos dias de férias", xlab="Dias de Férias", ylab="Jovens", col="cyan", horizontal=TRUE)
boxplot(dadosfinal[4], main="Distribuição das idas semanais ao cinema", xlab="Idas semanais ao cinema", ylab="Jovens", col="hotpink", horizontal=TRUE)
boxplot(dadosfinal[5], main="Distribuição do maximo de km", xlab="maximo de km", ylab="Jovens", col="midnightblue", horizontal=TRUE)
boxplot(dadosfinal[6], main="Distribuição do preço maximo do bilhete", xlab="Preço Maximo do bilhete", ylab="Jovens", col="orangered", horizontal=TRUE)                   
#############################################


#############################################
1.5 - CRIAR NOVA VARIAVEL

IdasAnuais=round(dadosfinal[4]*52.179, digits = 0) #multiplicar pelo numero de semanas num ano 

colnames(IdasAnuais)[1]<- "Idas Anuais ao cinema" 

dados1=cbind(dadosfinal,IdasAnuais)# junta a nova variável à base de dados

View(dados1)

niA = table(dados1[7]) 
fiA = niI/sum(niA)
NiA = cumsum(niA) 
FiA = cumsum(fiA) 

tabelaIdasAnuais = cbind(niA, fiA, NiA, FiA)

tabelaIdasAnuais 

grafico_idasAnuais <- barplot(niA,main="Distribuição por Idas Anuais ao Cinema"
, ylab= "Número de Jovens",xlab="Idas Anuais ao Cinema"
, border="black", col="yellow")

text(grafico_idasAnuais , 0, round(niA, 1),cex=1,pos=3) 

summary(dados1[7]) 

var(dados1[[7]]) 
sd(dados1[[7]]) 
cv=sd(dados1[[7]])/mean(dados1[[7]]) 
cv

skewness(dados1[[7]])
kurtosis(dados1[[7]])

boxplot(dados1[7], main="Distribuição das idas anuais ao cinema", xlab="Idas Anuais ao Cinema", ylab="Jovens", col="grey", horizontal=TRUE)
#############################################


#############################################
#1.6 - Comparar preço máximo disposto a pagar por um bilhete, em  euros,  por  tipo  de  cinema preferido

tapply(dadosfinal[[6]],dadosfinal[[1]],summary)  
tapply(dadosfinal[[6]],dadosfinal[[1]],sd)  
boxplot(dadosfinal[[6]]~dadosfinal[[1]],xlab="Preço Maximo Bilhete", ylab="Tipo de Cinema", main="Distribuição Tipo Cinema", col="violet", horizontal=TRUE) 
#############################################

#############################################
1.7 - coeficiente de correlação de Pearson

#Package para efetuar coeficiente de correlação de Pearson
install.packages("ggpubr")
library("ggpubr")

ggscatter(dadosfinal, x = "Dias de férias", y = "Idas semanais ao cinema", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Dias de férias", ylab = "Idas semanais ao cinema")

ggscatter(dadosfinal, x = "Maximo KM", y = "Preço Máximo Bilhete", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Maximo KM", ylab = "Preço Máximo Bilhete")
#############################################
