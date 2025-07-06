## 
## Moon
## 
class_name Moon extends ResourceManager

## NAME
## ay/uydu adı
@export var name: String

## RESOURCES
## uydu yüzeyindeki madenler
@export var resources: Array[Ore.List] = []

## WATER PRESENCE
## uydu yüzeyinde su var mı?
@export var water_presence: bool = false

## ICE PRESENCE
## uydu yüzeyinde buz var mı?
@export var ice_presence: bool = false

## DAY LENGTH
## uydu gün uzunluğu
@export var day_length: int = 24

## YEAR LENGTH
## uydu yıl uzunluğu
@export var year_length: int = 365
