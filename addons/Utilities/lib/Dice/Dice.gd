##
## @class Dice
##
class_name Dice extends Utilities
	
## 
## rastgele true/false
## değerini dönderir.
## 
## @example Dice.flip()
## 
## @return bool
## 
static func flip() -> bool:
	return randi() % 2 == 0

## 
## en fazla "max" değeri kadar rastgele
## "tek" bir pozitif tam sayı dönderir.
## 
## @param max: int
## @example Dice.roll(6)
## 
## @return int
## 
static func roll(max: int) -> int:
	return randi() % max + 1

## 
## gönderilen dictionary listesinden "count"
## sayısı kadar rastgele veriyi dönderir
## 
## @param list: Dictionary
## @param count: int
## @example Dice.draw(Ore.List, 2)
## 
static func fromDictionary(list: Dictionary, count: int = 1):
	var keys = list.keys()
	keys.shuffle()
	
	count = min(count, keys.size())
	if count == 1:
		return keys[0]
	else:
		return keys.slice(0, count)

##
## gönderilen array listesinden "count"
## sayısı kadar rastgele veriyi dönderir
## 
## @param list: Array
## @param count: int
## @example Dice.pick(Arraylist, 2)
## 
## @return Array
## 
static func fromArray(list: Array, count: int) -> Array:
	var shuffled_list := list.duplicate()
	shuffled_list.shuffle()
	
	return shuffled_list.slice(0, count)


## 
## min ile max aralığı kadar
## rastgele bir sayı dönderir
## 
## NOT: bu metot Gdscript'in randi_range fonksiyonu
## için kısayoldur.
## 
## @param min: int
## @param max: int
## @example Dice.range(0, 4)
## 
## @return int
## 
static func range(min: int, max: int) -> int:
	return randi_range(min, max)
	
## 
## NameGenerator.Suffixes listesinden
## rastgele bir sonek dönderir
## 
## @example Dice.suffix()
## @return String
## 
static func suffix() -> String:
	# her zaman suffix kullanılmasın
	# yüzde 60 oranında olasılık olsun
	var use_suffix = randf() < 0.6
	
	if use_suffix:
		return Dice.fromDictionary(NameGenerator.Suffixes)
	
	return ""
