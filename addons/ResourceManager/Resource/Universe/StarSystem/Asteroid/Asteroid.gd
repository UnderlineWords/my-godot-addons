## 
## Asteroid
## 
class_name Asteroid extends ResourceManager

## NAME
@export var name: String

## RESOURCES
## asteroit yüzeyindeki madenler
@export var resources: Array[Ore.List] = []

## WATER PRESENCE
## gezegen/uydu/asteroit yüzeyinde su var mı?
@export var water_presence: bool = false

## ICE PRESENCE
## gezegen/uydu/asteroit yüzeyinde buz var mı?
@export var ice_presence: bool = false
