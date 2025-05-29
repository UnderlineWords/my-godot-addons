## 
## Vehicle
## 
class_name Vehicle
extends Goods

enum Type {
	Ship,
	Exover
}

## NAME
@export var name: String

## MANUFACTURER
## üretici
@export var manufacturer = Manufacturer.Ship.Aurevo

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
## taşıyabileceği yük kapasitesi (grid)
@export var cargo_capacity: int = 64

## DESCRIPTION
## açıklama
@export_multiline var description: String = "..."
