## 
## Weapon
## 
class_name Weapon
extends Goods

enum WeaponType {
	AssaultRifle,
	Energy,
	Laser,
	Melee,
	MiningTool,
	Pistol,
	Plasma,
	Shotgun,
	Torpedo
}

enum Usage {
	## yüzey araçlarına entegre edilebilen silahlar
	Exover,
	## elde kolayca taşınabilen türde silahlar
	Handheld,
	## bir uzay gemisine entegre edilebilen silahlar
	Ship
}

## NAME
## Silah/model adı
@export var name: String

## MANUFACTURER
## Silah/model üreticisi
@export var manufacturer = Manufacturer.Weapon.Defensys

## WEAPON TYPE
## Silah türü
@export var type: WeaponType = WeaponType.Pistol

## USAGE
## Silahın kullanım şekli/amacı
@export var usage: Usage = Usage.Handheld

## AMMO
## Kullandığı mermi
@export var ammo: Ammo.AmmoType

## MAGAZINE SIZE
## şarjör kapasitesi
@export var magazine_size: int = 8

## RELOAD TIME
## Şarjör değiştirme süresi
@export var reload_time: float = 0.0

## FIRE RATE
## Atış hızı
@export var fire_rate: float = 0.0

## DAMAGE
## Verdiği hasar
@export var damage: float = 0.0

## DURABILITY
## Silahın dayanıklılığı, yıpranma çarpanı
@export var durability: float = 0.0

## DESCRIPTION
## Silah açıklaması
@export_multiline var description: String = "..."
