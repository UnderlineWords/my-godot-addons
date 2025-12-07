## 
## @class Ore
## Oyunda yer alan tüm maden
## kaynakları için ortak veri girdileri
## 
class_name Ore extends Goods

## maden listesi ve detaylarının
## kayıtlı olduğu json dosyası
const OreList := "res://addons/ResourceManager/Resource/Goods/Ore/Ores.json"

## maden isimleri (json dosyasındaki id'ler)
enum List {
	antimony,
	bauxite,
	beryllium,
	bismuth,
	cadmium,
	cesium,
	chromium,
	cobalt,
	copper,
	dysprosium,
	europium,
	gallium,
	graphite,
	hafnium,
	holmium,
	iridium,
	iron,
	lead,
	lithium,
	magnesium,
	manganese,
	molybdenum,
	neodymium,
	nickel,
	niobium,
	osmium,
	platinum,
	rareearth,
	rhodium,
	ruthenium,
	samarium,
	scandium,
	selenium,
	silicon,
	tantalum,
	tellurium,
	terbium,
	thorium,
	titanium,
	tungsten,
	uranium,
	vanadium,
	yttrium,
	zinc,
	zirconium
}

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
