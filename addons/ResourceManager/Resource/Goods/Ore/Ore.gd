## 
## @class Ore
## Oyunda yer alan tüm maden
## kaynakları için ortak veri girdileri
## 
class_name Ore extends Goods

## maden listesi
const OreList := "res://addons/ResourceManager/Resource/Goods/Ore/Ores.json"

## 
## @param filter
## @param order_by
## @example Ore.getList({"rarity": "common"})
## 
## @return Array
## 
static func getList(filter = {}, order_by = "name") -> Array:
	var ore_list = JsonKit.loadAndFilter(OreList, filter)
	
	return JsonKit.values(ore_list, order_by)
