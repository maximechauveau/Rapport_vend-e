#package pour la fonction read.dbf
library(foreign)
library(leaflet)
library(sf)
library(rgdal)
library(ggplot2)
library(maps)
library(sqldf)
library(plyr)
library(dplyr)


setwd()
## Map carreaux ##

# Chargement carreaux
df_carreaux <- read_sf(dsn = './data/carreaux_vendee.gpkg')
df_carreaux <- st_transform(df_carreaux, CRS("+proj=longlat +datum=WGS84"))

#filtre par rapport aux carreaux
df_carreaux_znieff <- df_carreaux[df_znieff1, , op = st_within]
df_carreaux_scap <- df_carreaux[df_scap, , op = st_within]
df_carreaux_cbnb <- df_carreaux[df_alerte_CBNB, , op = st_within]

#Ajout colonne booleen
df_carreaux_znieff['ind_znieff'] <- 1
df_carreaux_scap['ind_scap'] <- 1
df_carreaux_cbnb['ind_cbnb'] <- 1

#Supprimer colonne geo
df_carreaux_znieff <- as.data.frame(df_carreaux_znieff)
df_carreaux_scap <- as.data.frame(df_carreaux_scap)
df_carreaux_cbnb <- as.data.frame(df_carreaux_cbnb)

df_carreaux_znieff <- df_carreaux_znieff[,-c(3)]
df_carreaux_scap <- df_carreaux_scap[,-c(3)]
df_carreaux_cbnb <- df_carreaux_cbnb[,-c(3)]

#jointure avec df_carreaux
df_carreaux_all <- merge(df_carreaux,df_carreaux_znieff,by=c('id_carr_1km','idINSPIRE'),all.x = TRUE)
df_carreaux_all <- merge(df_carreaux_all,df_carreaux_scap,by=c('id_carr_1km','idINSPIRE'),all.x = TRUE)
df_carreaux_all <- merge(df_carreaux_all,df_carreaux_cbnb,by=c('id_carr_1km','idINSPIRE'),all.x = TRUE)

#Remplace Na par 0
df_carreaux_all[is.na(df_carreaux_all)] <- 0



df_carreaux_all['ind_total'] <- df_carreaux_all$ind_znieff + df_carreaux_all$ind_scap + df_carreaux_all$ind_cbnb


df_carreaux_all$ind_total <- as.factor(df_carreaux_all$ind_total)

# revalue
df_carreaux_all$ind_total <- revalue(df_carreaux_all$ind_total, c('0'='Absence',
                                     '1'='1 couche',
                                     '2'='2 couches',
                                     '3'='3 couches'))

# df_carreaux_all %>% 
#   mutate(ind_total)
  
#Map
# map_carreau <-  ggplot() +
#   geom_sf(aes(fill=(df_carreaux_all$ind_total)),
#           data = df_carreaux_all,
#           color = 'white',
#           size = 0.0000001)

map_carreau <-  ggplot() +
  geom_sf(aes(fill=(ind_total),color = ind_total),
          data = df_carreaux_all,
          size = 0.0000001)

map_carreau + labs(fill = 'Légende', color = 'Légende') +
scale_fill_manual(values = c('#40A497','#404AA4','#9E40A4','#A4406F')) +
scale_color_manual(values = c('#40A497','#404AA4','#9E40A4','#A4406F'))



title = 'Légende'
# ggplot(some.eu.maps, aes(x = long, y = lat)) +
#   geom_polygon(aes( group = group, fill = region))+
#   geom_text(aes(label = region), data = df_carreaux,  size = 3, hjust = 0.5)+
#   scale_fill_viridis_d()+
#   theme_void()+
#   theme(legend.position = "none")



# 
# map_carreau <- leaflet() %>%
#   addTiles()  %>%
#   addPolygons(data = df_carreaux)
# 
# 
# 
# map_carreau
# 
# 
# map_carreau <- leaflet(data = limite_vendee) %>%
#   addTiles() %>%
#   #addProviderTiles permet de choisir fond carte
#   addProviderTiles("CartoDB.Positron",
#                    group = "Map") %>%
#   addProviderTiles("Esri.WorldImagery",
#                    group = "Satellite") %>%
#   addProviderTiles("Esri.WorldShadedRelief",
#                    group = "Relief") %>%
#   #addScaleBar : Ã©chelle map
#   addScaleBar(position = "bottomleft")
# 
# map_carreau

save(df_carreaux_znieff, file = "df_carreaux_znieff.Rdata")
