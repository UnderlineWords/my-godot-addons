## 
## Cave
## Çıkarılabilir cevherler, yabancı bitki örtüsü veya
## gizli yapılar içeren yeraltı bölgeleri
## 
class_name Cave extends UndergroundLocation

## WATER PRESENCE
## mağarada su bulunma durumu 
@export var water_presence: bool = false

## ICE PRESENCE
## mağara buz bulunma durumu
@export var ice_presence: bool = false

## ORES
## mağarada yer alan madenler
@export var ores:Array[Ore.List] = []
