## 
## Vehicle
## 
class_name Vehicle extends Goods

## TYPE
## oyuna eklenecek olan araç türü
enum Type {
	## Oyundaki gemiler için
	Ship,
	## Gezegen, ay veya asteroit yüzeyinde
	## keşif, savunma ve madencilik amaçlı
	## kullanılabilen araçlar
	Exover
}

## NAME
@export var name: String

## MANUFACTURER
## üretici
@export var manufacturer = Manufacturer.Ship.Aurevo

## DECKS
## Sadece gemilere ait güverteler
enum Decks {
	## Gemi komutasının ve navigasyon 
	## sistemlerinin bulunduğu ana kontrol merkezi
	Bridge,
	## Geminin enerji sistemleri, motorları 
	## ve teknik altyapısının yönetildiği bakım güvertesi
	Engineering,
	## Bilimsel araştırma, sağlık hizmetleri ve hatta
	## topraksız tarım testlerinin yürütüldüğü güverte
	Lab,
	## Ticari yükler, kaynaklar veya
	## materyallerin depolandığı ana kargo güvertesi
	Cargo,
	## keşif gemilerinin iniş/kalkış yaptığı platform
	Hangar,
	## Personelin konakladığı ve dinlendiği güverte
	Quarters
}

## DECKS
## Gemide yer alacak güverteler
@export var decks: Decks = Decks.Bridge

## ENGINE
## entegreli maksimum güç kapasitesi
@export_enum(
	"Basic:75", 
	"Standard:100", 
	"Advanced:150",
	"Hyper:200", 
	"Quantum:250"
) var engine: int = 75

## TOP SPEED
## aracın maksimum hızı
@export var top_speed: float

## FUEL TANK
## yakıt tankı kapasitesi
@export var fuel_tank: float

## JUMP RANGE (sadece gemiler için)
## geminin galaksiler veya yıldız sistemleri 
## arasındaki maksimum atlayış/sıçrama mesafesi
@export var jump_range: float

## CARGO CAPACITY
## eğer gemi veya yüzey aracında kargo modülü varsa,
## taşıyabileceği yük kapasitesi (grid)
@export var cargo_capacity: int = 64

## DESCRIPTION
## açıklama
@export_multiline var description: String = "..."
