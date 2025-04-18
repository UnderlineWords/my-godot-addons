## 
## AmmoResource
## 
class_name AmmoResource
extends Goods

enum AmmoType {
	Energy,
	Explosive,
	Fusion,
	Laser,
	Lithium,
	Plasma,
	Standard
}

## mermi adı
@export var name: String

## mermi türü
@export var ammo_type: AmmoType = AmmoType.Energy

## standart mermiler veya enerji silahları için mermi biçimi/boyutu 
@export_enum("9mm", "7.62mm", "12 Gauge", "5.56mm", "Capsule", "Module", "Cartridge") var ammo_format: int

## merminin hasar çarpanı
@export var damage: float = 0.0
