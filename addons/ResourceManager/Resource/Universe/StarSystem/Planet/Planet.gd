## 
## Planet
## 
class_name Planet extends ResourceManager

## NAME
## gezegen adı
@export var name: String

## MOONS
## gezegene ait uydu sayısı
@export_range(GalaxyGenerator.MinMoon, GalaxyGenerator.MaxMoon) var moons: int

## ATMOSPHERE
## gezegenin atmosfer türü
@export var atmosphere = AtmosphereResource.Type.ARID

## RESOURCES
## gezegen yüzeyindeki madenler
@export var resources: Array[Ore.List] = []

## WATER PRESENCE
## gezegen yüzeyinde su var mı?
@export var water_presence: bool = false

## ICE PRESENCE
## gezegen yüzeyinde buz var mı?
@export var ice_presence: bool = false

## DAY LENGTH
## gezegen gün uzunluğu
@export var day_length: int = 24

## YEAR LENGTH
## gezegen yıl uzunluğu
@export var year_length: int = 365
