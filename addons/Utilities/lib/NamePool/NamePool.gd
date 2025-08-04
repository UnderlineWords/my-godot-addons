## 
## 
## 
class_name NamePool extends Utilities

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
static func take():
	var file = FileBox.read(INPUT_PATH)
	
	if not file:
		push_error("İsim dosyası açılamadı.")
		return
		
	var names = JSON.parse_string(file.get_as_text())
	file.close()
	
	return names
