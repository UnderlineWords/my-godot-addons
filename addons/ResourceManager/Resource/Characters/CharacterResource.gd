##
## CharacterResource
## Tüm NPC & Player için ortak veri
## girdilerinin bulunduğu "üst ana" sınıf
##
class_name CharacterResource
extends Resource

## Bazı meslekler/uzmanlıklar sadece NPC'lere özgüdür.
## Oyuncu, oyun başlangıcında farklı özelliklere ve 
## uzmanlıklara sahip ön tanımlı 12 karakterden
## (6 Kadın / 6 Erkek) birini seçerek oyuna başlar.
enum Occupation {
	ARTIST,
	BANDIT,
	CHEF,
	CHEMIST,
	CLERK,
	COMMANDER,
	COMMONER,
	DESIGNER,
	DOCTOR,
	ENGINEER,
	EXPLORER,
	FARMER,
	FIXER,
	GUARD,
	HACKER,
	HAULER,
	INVENTOR,
	JOURNALIST,
	MECHANIC,
	MINER,
	PILOT,
	PIRATE,
	PROFESSOR,
	SCIENTIST,
	SOLDIER,
	STUDENT,
	THIEF,
	TRADER,
	WRITER
}

enum Gender {
	FEMALE, 
	MALE
}

## player/npc görsel dosyası (portrait)
@export var photo: Texture2D

## player/npc adı
@export var name: String

## player/npc mesleği/uzmanlığı
@export var occupation: Occupation = Occupation.ENGINEER

## player/npc'nin cinsiyeti
@export var gender: Gender = Gender.MALE

## player/npc'nin oyun başındaki sağlık üst değeri. 
## Bu değer, karakter seviye atladıkça artabilir (player için).
@export var health: int = 100

## player/npc'nin oyun başındaki dayanıklılık üst değeri. 
## Bu değer, karakter seviye atladıkça artabilir (player için).
@export var stamina: int = 100

## player/npc'nin tüm silahlarla verebileceği hasar çarpanı. 
## Bu çarpan, silahların kendi hasar çarpanıyla birlikte hesaplanır.
@export var damage: float = 1.0

## player/npc'nin hareket hızı çarpanı
@export var speed: float = 1.0

## player/npc'nin oyundaki genel başlangıç seviyesi
@export var level: int = 1

## player/npc'nin varsayılan taşıma kapasitesi (grid)
## npc'ler sadece ticaret amaçlı kullanacak
@export var inventory_size: int = 24

## player/npc'nin oyundaki başlangıç parası
## oyun içi para birimi; exo
@export var money: int = 0

## Karakterin biyografisi
@export_multiline var profile: String = "profile..."
