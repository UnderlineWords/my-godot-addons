## 
## Moon
## 
class_name Moon extends ResourceManager

## NAME
## ay/uydu adı
@export var name: String

## RESOURCES
## gezegen/uydu/asteroit yüzeyindeki madenler
@export var resources: Array[Ore.List] = []

## WATER PRESENCE
## gezegen/uydu/asteroit yüzeyinde su var mı?
@export var water_presence: bool = false

## ICE PRESENCE
## gezegen/uydu/asteroit yüzeyinde buz var mı?
@export var ice_presence: bool = false

## DAY LENGTH
## gezegen/uydu/asteroit gün uzunluğu
@export var day_length: int = 24

## YEAR LENGTH
## gezegen/uydu/asteroit yıl uzunluğu
@export var year_length: int = 365
