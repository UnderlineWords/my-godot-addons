##
##
##
class_name NameProvider extends Node

## isim listesi
const INPUT_PATH := "res://addons/ResourceManager/Resource/Universe/Names.json"

## sonekler
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
## 
## 
static func names():
	var file = FileAccess.open(INPUT_PATH, FileAccess.READ)
	
	if not file:
		push_error("İsim dosyası açılamadı.")
		return
		
	var names = JSON.parse_string(file.get_as_text())
	file.close()
	
	return names
