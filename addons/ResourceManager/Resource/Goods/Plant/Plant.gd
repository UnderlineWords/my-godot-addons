## 
## @class Plant
## Oyunda yer alan şifalı bitkiler, sebzeler 
## ve meyveler için ortak veri girdileri
## 
class_name Plant extends Goods

const PlantList := "res://addons/ResourceManager/Resource/Goods/Plant/Plants.json"

enum Type {
	HERB, 
	VEGETABLE,
	FRUIT
}

## NAME
## bitkinin adı
@export var name : String = "..."

## DESCRIPTION
## bitkinin açıklaması
@export_multiline var description: String = "..."

## TYPE
## bitkinin türü
@export var plant_type: Type = Type.HERB

## ATMOSPHERE TYPE
## bitkinin yetiştiği atmosfer türü
@export var atmosphere_type = AtmosphereResource.Type.ARID

## IS EDIBLE?
## yenilebilir mi?
@export var is_edible: bool = false

## IS MEDICINAL?
## tıbbi amaçla kullanılabilir mi?
@export var is_medicinal: bool = false

## IS TOXIC?
## zehirli mi?
@export var is_toxic: bool = false

## 
## @param filter
## @param order_by
## @example Plant.getList({"type": "herb"})
## 
## @return Array
## 
static func getList(filter = {}, order_by = "slug") -> Array:
	var plant_list = JsonKit.loadAndFilter(PlantList, filter)
	
	return JsonKit.values(plant_list, order_by)
