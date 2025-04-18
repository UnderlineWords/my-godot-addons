## 
## Goods
## Oyunda kullanılacak olan 
## tüm bileşenler/ürünler için ortak veri
## girdilerinin bulunduğu "üst ana" sınıf
## 
class_name Goods
extends ResourceManager

enum Classification { 
	AMMO,
	ARMOR,
	COMPONENT,
	CONSUMABLE,
	DOCUMENT,
	MISC,
	TOOL,
	WEAPON
}

## nesnenin ait olduğu sınıf
@export var classification: Classification = Classification.CONSUMABLE

## Nesnenin oyundaki değeri/fiyatı
## oyun içi para birimi; exo
@export var price: int = 200

## Nesneye oyun içinde denk gelme oranı
@export var rarity: float = 1.0

## Nesne satın alınabilir mi?
@export var buyable: bool = true

## Nesne satılabilir mi?
@export var sellable: bool = true

## Oyun içinde nesne ortaya çıkabilir mi?
## false ise sadece tüccarlarda bulunabilir.
@export var spawnable: bool = true

## Nesne geliştirilebilir mi?
@export var upgradable: bool = false

## Nesne istiflenebilir mi?
@export var stackable: bool = true

## Nesnenin maksimum istiflenme sayısı
@export var max_stack: int = 5

@export_category("Textures")
## Nesneye ait görsel dosyası
@export var image: Texture2D

## Nesneyi tanımlayan ikon dosyası
@export var icon: Texture2D
