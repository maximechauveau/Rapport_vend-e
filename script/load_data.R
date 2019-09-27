getwd()

#package pour la fonction read.dbf

library(leaflet)
library(sf)

#dossier ONF
df_foret <- read.dbf("./data/ONF/SHAPE/FORET_DOMANIALE_ONF.dbf")

#dossier MESURE DE PROTECTION
df_protection_biotope <- read.dbf("./data/MESURE DE PROTECTION/SHAPE/ARRETES_PROTECTION_BIOTOPE.dbf")

df_CEL_INPH <- read.dbf("./data/MESURE DE PROTECTION/SHAPE/CEL_INPH.dbf")

df_RESERVE_BIO <- read.dbf("./data/MESURE DE PROTECTION/SHAPE/RESERVE_BIOLOGIQUE.dbf")

df_RESERVE_NATURELLE_NATIONALE <- read.dbf("./data/MESURE DE PROTECTION/SHAPE/RESERVE_NATURELLE_NATIONALE.dbf")

df_RESERVE_NATURELLE_REGIONALE <- read.dbf("./data/MESURE DE PROTECTION/SHAPE/RESERVE_NATURELLE_REGIONALE.dbf")

sf_oiseau_nicheur <- read_sf(dsn = './data/LPO/SHAPE/OISEAU_NICHEUR.shp')
sf_oiseau_nicheur <- st_transform(sf_oiseau_nicheur, CRS("+proj=longlat +datum=WGS84"))

#map_foret

library(sf)
sf_mesure_protect <- read_sf(dsn = './data/MESURE DE PROTECTION/SHAPE/RESERVE_NATURELLE_NATIONALE.shp')
sf_mesure_protect <- st_transform(sf_mesure_protect, CRS("+proj=longlat +datum=WGS84"))

leaflet(data=sf_oiseau_nicheur) %>%
  addTiles() %>%
  addPolygons() %>%
  setView(lat = 47, lng = -1.5, zoom = 7)







# Coordonnee la Roche/Yon
lati = 46.4029
longi = 1.1752


map_vendee <- leaflet() %>%
  addTiles() %>%
  #addProviderTiles permet de choisir fond carte
  addProviderTiles("CartoDB.Positron",
                   group = "Map") %>%
  addProviderTiles("Esri.WorldImagery",
                   group = "Satellite") %>%
  addProviderTiles("Esri.WorldShadedRelief",
                   group = "Relief") %>%
  #addScaleBar : échelle map
  addScaleBar(position = "bottomleft") %>%
  addLegend("bottomright",
            colors = c("#3FADCB",
                       "#84AAE6",
                       "#8DA9CD",
                       "#7CFC00",
                       "#FF4500"),
            labels = c("ZNIEFF1",
                       "SCAP",
                       "CBNB",
                       "ENS",
                       "ZPENS"),
            opacity = 1) %>%
  #addPolygons ajout couche aire
  addPolygons(data = limite_vendee,
              fillColor = FALSE,
              color = "#000000",
              opacity = 1,
              fillOpacity = 0,
              weight = 1.5) %>%
  addPolygons(data=df_znieff1,
              color = '#3FADCB',
              group = 'ZNIEFF1',
              popup = df_znieff1$NOM) %>%
  addPolygons(data=df_scap,
              color = '#84AAE6',
              group = 'SCAP',
              popup = df_scap$NOM) %>%
  addPolygons(data=df_alerte_CBNB,
              color = '#8DA9CD',
              group = 'Alerte CBNB') %>%
  addPolygons(data=df_ENS,
              color = '#7CFC00',
              group = 'ENS',
              popup = df_ENS$NOM_SITE) %>%
  addPolygons(data=df_ZPENS,
              color = '#FF4500',
              group = 'ZPENS',
              popup = df_ZPENS$NOM_SITE) %>%
  setView(lat = lati, lng = longi, zoom = 9) %>%
  #addLayersControl : choix des vues
  addLayersControl(overlayGroups = c('ZNIEFF1','Alerte CBNB','SCAP','ENS','ZPENS'),baseGroups = c("Map", "Satellite", "Relief"))

map_vendee

## Map carreaux ##

# Chargement carreaux
df_ZPENS <- read_sf(dsn = './data/ENS/SHAPE/ZPENS.shp')
df_ZPENS <- st_transform(df_ZPENS, CRS("+proj=longlat +datum=WGS84"))

map_carreau <- leaflet(data = limite_vendee) %>%
  addTiles() %>%
  #addProviderTiles permet de choisir fond carte
  addProviderTiles("CartoDB.Positron",
                   group = "Map") %>%
  addProviderTiles("Esri.WorldImagery",
                   group = "Satellite") %>%
  addProviderTiles("Esri.WorldShadedRelief",
                   group = "Relief") %>%
  #addScaleBar : échelle map
  addScaleBar(position = "bottomleft")



