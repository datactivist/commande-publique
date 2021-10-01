### Cas d'étude - France Urbaine DECP


          ### Analyse des données de Nice 

# Import des données depuis DECP.info
library(tidyverse)
nice <- read_csv("https://decp.info/db/decp.csv?_sort=rowid&acheteur.id__exact=20003019500115&_size=max&_dl=1")

# Filtre pour être sûre de n'avoir que l'acheteur souhaité
nice <- nice %>% filter(acheteur.nom == "METROPOLE NICE COTE D'AZUR")

# Format de la variable de jonture : n° SIRET
nice <- nice %>% rename(siret = titulaire.id) 
nice$siret <- as.character(nice$siret)

# Sous-bases pour les années 2019 et 2020
nice$Year <- format(as.Date(nice$dateNotification, format="%Y/%m/%d"),"%Y")
df_19 <- nice %>% filter(Year == 2019)
df_20 <- nice %>% filter(Year == 2020)

# Import de la base SIREN
sirene <- read_csv("C:/Users/diane/Downloads/StockEtablissement_utf8.csv") #download
names(sirene)

# jointure par le numéro SIRET
jointure_19 <- left_join(df_19[,c(2,3,6:9,13:20,23)], sirene[,c(1,3,5,6,8,10,13,15:18,21,22,40:48)], by = "siret")
