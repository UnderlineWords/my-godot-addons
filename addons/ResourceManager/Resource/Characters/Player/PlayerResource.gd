## 
## PlayerResource
## Sadece "player"a özgü veri girdileri
## 
class_name PlayerResource
extends CharacterResource

@export_group("General")
## Karakterin açlık çarpanı. Yüksek değerler çabuk acıkmasına yol açar. 
## Bu değer, oyuncu seviye atladıkça değişebilir.
@export var starvation: float = 1.0

## Karakterin susuzluk çarpanı. Yüksek değerler çabuk susamasına yol açar. 
## Bu değer, oyuncu seviye atladıkça değişebilir.
@export var dehydration: float = 1.0

@export_group("Settings")
## Oyuncunun aşağıdaki "perks" listesinden
## seçebileceği maksimum özellik sayısı
@export var max_selectable_skills: int = 2

## Oyuncu, aşağıdaki ekstra özellikleri sadece oyun
## başlangıcında seçebilir ve daha sonra değiştiremez
## WARNING: sayısı artabilir/azalabilir
@export_group("Perks")
## Demolition Man
## Oyuncu, 25% daha fazla hasar verir
## Etkilediği değer; CharacterResource.damage
@export var demolition_man: bool = false

## Desert Lion
## Oyuncunun açlık çarpanı 25% azalır
## Etkilediği değer; starvation
@export var desert_lion: bool = false

## Desert Rat
## Oyuncunun susuzluk çarpanı 25% azalır
## Etkilediği değer; dehydration
@export var desert_rat: bool = false

## Fast Healer
## Oyuncunun sağlık değeri düştüğünde daha çabuk iyileşir 
## Etkilediği değer; CharacterResource.health
@export var fast_healer: bool = false

## Fast Learner
## Karakter, 25% daha fazla deneyim puanı kazanır
## Etkilediği değer; CharacterResource.level
@export var fast_learner: bool = false

## Heavy Carrying
## Oyuncunun taşıma kapasitesi +5 (grid) artar
## Etkilediği değer; CharacterResource.inventory_size
@export var heavy_carrying: bool = false

## Runner
## Oyuncunun koşma/hareket hızı 25% artar
## Etkilediği değer; CharacterResource.speed
@export var runner: bool = false

## Solid Wall
## Oyuncunun dayanıklılık değeri 25% artar
## Etkilediği değer; CharacterResource.stamina
@export var solid_wall: bool = false

## Yetenek değerleri, karakterin mesleğiyle
## doğrudan bağlantılıdır. Meslek/uzmanlık listesi
## CharacterResource dosyasında kayıtlıdır.
## TODO: Liste tamamlanacak ve sayısı çoğaltılacak
@export_group("Skills")
## Oyuncunun NPC'lerce farkedilme range çarpanı
@export var stealth: float = 1.0

## Oyuncunun kilitleri açma şansı çarpanı
@export var lockpicking: float = 1.0
