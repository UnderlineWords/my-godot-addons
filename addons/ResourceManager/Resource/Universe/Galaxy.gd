## 
## Galaxy
## 
class_name Galaxy extends ResourceManager

## NAME
## galaksi adı
@export var name: String

## DESCRIPTION
## galaksi açıklaması
@export_multiline var description: String = "..."

## STAR SYSTEM
## Bir galaksi içindeki
## maksimum yıldız sistemi sayısı
@export_range(GalaxyGenerator.MinSystem, GalaxyGenerator.MaxSystem) var star_system_count: int

## ASTEROID BELT
## Bir yıldız sistemi içindeki
## maksimum asteroit kuşak sayısı
@export_range(GalaxyGenerator.MinAsteroid, GalaxyGenerator.MaxAsteroid) var asteroid_belt_count: int

## PLANET
## Bir yıldız sistemi içindeki
## maksimum gezegen sayısı
@export_range(GalaxyGenerator.MinPlanet, GalaxyGenerator.MaxPlanet) var planet_count: int

## MOON
## Bir gezegene ait
## maksimum ay/uydu sayısı
@export_range(GalaxyGenerator.MinMoon, GalaxyGenerator.MaxMoon) var moon_count: int
