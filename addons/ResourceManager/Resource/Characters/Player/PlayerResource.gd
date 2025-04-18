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
## Oyun başlangıcında, oyuncunun aşağıdaki "perks"
## listesinden seçebileceği maksimum özellik sayısı
@export var max_selectable_perks: int = 2

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
## Oyuncu, 25% daha fazla deneyim puanı kazanır
## Etkilediği değer; CharacterResource.level
@export var fast_learner: bool = false

## Heavy Carrying
## Oyuncunun taşıma kapasitesi +6 (grid) artar
## Etkilediği değer; CharacterResource.inventory_size
@export var heavy_carrying: bool = false

## Runner
## Oyuncunun koşma/hareket hızı 25% artar
## Etkilediği değer; CharacterResource.speed
@export var runner: bool = false

## Charismatic
## Oyuncunun tüccarlardan aldığı ürünler 25% daha ucuz olur 
@export var charismatic: bool = false

## Solid Wall
## Oyuncunun dayanıklılık değeri 25% artar
## Etkilediği değer; CharacterResource.stamina
@export var solid_wall: bool = false

## Yetenek değerleri, karakterin mesleğiyle
## doğrudan bağlantılıdır. Meslek/uzmanlık listesi
## CharacterResource dosyasında kayıtlıdır.
## TODO: Liste tamamlanacak ve sayısı çoğaltılacak
@export_group("Skills")
## Barter
## Tüccarlardan daha iyi fiyat alma çarpanı
@export var barter: float = 0.0

## Crafting
## Oyuncunun üretim hızı ve verimlilik çarpanı
@export var crafting: float = 0.0

## Engineering
## Gemi/araç/cihaz tamiri ve modifikasyon hızı/başarısı
@export var engineering: float = 0.0

## Environmental Resistance 
## Oyuncunun radyasyon, oksijen tüketimi ve aşırı sıcaklıklar
## gibi farklı atmosferlere özgü çevresel tehlikelere karşı genel direnci
## (oxygen_efficiency + radiation_resistance + temperature_resistance)
@export var environmental_resistance: float = 0.0

## Hacking
## Oyuncunun dijital sistemleri kırma şansı çarpanı
@export var hacking: float = 0.0

## Lockpicking
## Oyuncunun fiziksel kilitleri açma şansı çarpanı
@export var lockpicking: float = 0.0

## Melee
## Yakın dövüşte isabet ve hasar çarpanı
@export var melee: float = 0.0

## Mining
## Maden toplama hızı ve verimliliği çarpanı
@export var mining: float = 0.0

## Scavenging
## Loot kalitesi ve bulunabilirliği çarpanı
@export var scavenging: float = 0.0

## Stealth
## Oyuncunun Düşman/NPC'lerce fark edilme mesafesi çarpanı
@export var stealth: float = 0.0
