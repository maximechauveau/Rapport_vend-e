getwd()

#package pour la fonction read.dbf
library(foreign)
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
lati = 46.6667
longi = -1.4333

map_vendee <- leaflet() %>%
  addTiles() %>%
  addProviderTiles("CartoDB.Positron",
                   group = "Map") %>%
  addProviderTiles("Esri.WorldImagery",
                   group = "Satellite") %>%
  addProviderTiles("Esri.WorldShadedRelief",
                   group = "Relief") %>%
  addPolygons(data=df_znieff1,
              color = '#3FADCB',
              group = 'ZNIEFF1') %>%
  addPolygons(data=df_scap,
              color = '#84AAE6',
              group = 'SCAP') %>%
  addPolygons(data=df_alerte_CBNB,
              color = '#8DA9CD',
              group = 'Alerte CBNB') %>%
  setView(lat = lati, lng = longi, zoom = 7) %>%
  addLayersControl(overlayGroups = c('ZNIEFF1','Alerte CBNB','SCAP'),baseGroups = c("Map", "Satellite", "Relief"))
map_vendee





