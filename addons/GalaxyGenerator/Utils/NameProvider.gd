##
##
##
class_name NameProvider extends Node

## isim listesinin yer aldığı kaynak dosya
## @link https://docs.godotengine.org/en/latest/tutorials/io/data_paths.html
const INPUT_PATH := "res://addons/ResourceManager/Resource/Universe/Names.json"

## galaksilerin listelendiği json dosyasının
## kaydedileceği dizin yolu ve dosya adı
## @link https://docs.godotengine.org/en/latest/tutorials/io/data_paths.html
const OUTPUT_PATH := "user://Galaxies.json"

## isimler için sonekler
enum Suffixes {
	I,
	II,
	III,
	IV,
	V,
	VI,
	VII,
	VIII,
	IX,
	X,
	XI,
	XII,
	Alfa,
	Beta,
	Delta,
	Epsilon,
	Eta,
	Gamma,
	Kappa,
	Lambda,
	Major,
	Minor,
	Omega,
	Omikron,
	Prime,
	Primeval,
	Proxima,
	Secundus,
	Sigma,
	Theta,
	Upsilon,
	Zeta
}

## 
## İsim listesini yükle
## 
static func getNames():
	var file = FileAccess.open(INPUT_PATH, FileAccess.READ)
	
	if not file:
		push_error("İsim dosyası açılamadı.")
		return
		
	var names = JSON.parse_string(file.get_as_text())
	file.close()
	
	return names
	
## 
## İsim listesinden rastgele bir isim al
##
## @param number: int
## 
static func randomName(number = null):
	var name_list = getNames()
	name_list.shuffle()
	
	if number:
		return name_list[number] 
		
	return name_list[randi_range(1, name_list.size())]

## 
## Suffix listesi
## 
static func randomSuffix() -> String:
	# her zaman suffix kullanılmasın
	# yüzde 60 oranında olasılık olsun
	var use_suffix = randf() < 0.6
	
	if use_suffix:
		var keys = Suffixes.keys()
		return keys[randi() % keys.size()]
	
	return ""
