##
##
##
class_name Dice extends Node

## 
## rastgele true/false
## değerini dönderir.
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
## @return int
## 
static func roll(max: int) -> int:
	return randi() % max + 1

## 
## gönderilen listeden "count"
## sayısı kadar rastgele veriyi dönderir
## 
## @param list: Dictionary
## @param count: int
## 
static func draw(list: Dictionary, count: int = 1):
	var keys = list.keys()
	keys.shuffle()
	
	count = min(count, keys.size())
	if count == 1:
		return keys[0]
	else:
		return keys.slice(0, count)

## 
## belirtilen min/max sayısı aralığı kadar
## rastgele bir sayı dönderir
## 
## NOT: bu metot Gdscript'in randi_range fonksiyonu
## için kısayoldur.
## 
## @param min: int
## @param max: int
## @return int
## 
static func range(min: int, max: int) -> int:
	return randi_range(min, max)

## 
## NameProvider.names() listesinden
## "number" sayısı kadar veri dönderir
## 
## @param number: int|null
## 
static func name(number = null):
	var name_list = NameProvider.names()
	name_list.shuffle()
	
	if number:
		return name_list[number] 
	
	return name_list[randi_range(1, name_list.size())]

## 
## NameProvider.Suffixes listesinden
## rastgele bir değer dönderir
## 
## @return String
## 
static func suffix() -> String:
	# her zaman suffix kullanılmasın
	# yüzde 60 oranında olasılık olsun
	var use_suffix = randf() < 0.6
	
	if use_suffix:
		return draw(NameProvider.Suffixes)
	
	return ""
