## 
## Food
## Oyunda yer alan tüm yiyecekler ve
## içecekler için ortak veri girdileri
## 
class_name Food
extends Goods

## tür/kategori
enum Category {
	MEAL,
	DRINK,
	MEAT,
	CANNED,
	CONDIMENT,
	DESSERT,
	SNACK
}

## adı
@export var name : String = "..."

## MANUFACTURER
## üretici firma
@export var manufacturer = Manufacturer.Food.GalacticPantry

## HUNGER RESTORE
## tüketildiğinde açlığa etkisi
@export var hunger_restore: float = 0.0

## THIRST RESTORE
## tüketildiğinde susuzluğa etkisi
@export var thirst_restore: float = 0.0

## HEALTH RESTORE
## tüketildiğinde genel sağlığa etkisi
@export var health_restore: float = 0.0

## SPOIL RATE
## bozulma süresi/oranı
@export var spoil_rate: float = 0.0

## açıklama
@export_multiline var description: String = "..."

@export_category("Category")
## CATEGORY
## ait olduğu tür/kategori
@export var category: Category = Category.MEAL
