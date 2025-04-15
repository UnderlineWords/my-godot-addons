## 
## FoodResource
## Oyunda yer alan tüm yiyecekler ve
## içecekler için ortak veri girdileri
## 
class_name FoodResource
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

## açıklama
@export_multiline var description: String = "..."

@export_category("Category")
## ait olduğu tür/kategori
@export var category: Category = Category.MEAL
