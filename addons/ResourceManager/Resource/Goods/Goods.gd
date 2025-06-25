## 
## Goods
## Oyunda kullanılacak olan 
## tüm bileşenler/ürünler için ortak veri
## girdilerinin bulunduğu "üst ana" sınıf
## 
class_name Goods extends ResourceManager

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

## CLASSIFICATION
## nesnenin ait olduğu sınıf
@export var classification: Classification = Classification.CONSUMABLE

## PRICE
## Nesnenin oyundaki değeri/fiyatı
## oyun içi para birimi; exo
@export var price: int = 200

## RARITY
## Nesneye oyun içinde denk gelme oranı
## "spawnable" false ise "rarity" yalnızca
## nesnenin tüccarlarda bulunabilme şansını etkiler
@export var rarity: float = 1.0

## IS BUYABLE?
## Nesne satın alınabilir mi?
@export var buyable: bool = true

## IS SELLABLE?
## Nesne satılabilir mi?
@export var sellable: bool = true

## IS SPAWNABLE?
## Oyun içinde nesne ortaya çıkabilir mi?
## false ise nesne ya tüccarlarda bulunabilir ya da
## üretilebilir bir nesnedir
@export var spawnable: bool = true

## IS UPGRADABLE?
## Nesne geliştirilebilir mi?
@export var upgradable: bool = false

## IS REPAIRABLE?
## Nesne tamir edilebilir mi?
@export var repairable: bool = false

## IS CRAFTABLE?
## Nesne üretilebilir mi?
@export var craftable: bool = false

## IS STACKABLE?
## Nesne istiflenebilir mi?
@export var stackable: bool = true

## MAXIMUM STACK SIZE
## Nesnenin maksimum istiflenme sayısı
@export var max_stack: int = 5

@export_category("Textures")
## IMAGE
## Nesneye ait görsel dosyası
@export var image: Texture2D

## ICON
## Nesneyi tanımlayan ikon dosyası
@export var icon: Texture2D
