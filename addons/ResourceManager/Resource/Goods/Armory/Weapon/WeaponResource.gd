## 
## WeaponResource
## 
class_name WeaponResource
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
	Handheld,
	Rover
}

## Silah ya da model adı
@export var name: String

## Silah türü
@export var type: WeaponType = WeaponType.Pistol

## Silahın kullanım şekli/amacı
@export var usage: Usage = Usage.Handheld

## Kullandığı mermi
@export var ammo: AmmoResource.AmmoType

## şarjör kapasitesi
@export var magazine_size: int = 8

## Şarjör değiştirme süresi
@export var reload_time: float = 0.0

## Atış hızı
@export var fire_rate: float = 0.0

## Verdiği hasar
@export var damage: float = 0.0

## Silahın dayanıklılığı, yıpranma çarpanı
@export var durability: float = 0.0

## Silah açıklaması
@export_multiline var description: String = "..."
