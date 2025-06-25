## 
## Ammo
## 
class_name Ammo extends Goods

enum AmmoType {
	Energy,
	Explosive,
	Fusion,
	Laser,
	Lithium,
	Plasma,
	Standard
}

## NAME
## mermi adı
@export var name: String

## AMMO TYPE
## mermi türü
@export var ammo_type: AmmoType = AmmoType.Energy

## AMMO FORMAT / CALIBER
## standart mermiler veya enerji silahları için mermi biçimi/boyutu/kalibre 
@export_enum("9mm", "7.62mm", "12 Gauge", "5.56mm", "Capsule", "Module", "Cartridge") var ammo_format: int

## DAMAGE
## merminin hasar çarpanı
@export var damage: float = 0.0
