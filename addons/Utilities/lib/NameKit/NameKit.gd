## 
## @class NameKit
## Rastgele ve kurallı isim üretimi yapan yardımcı sınıf.
##
## Harf tipleri, geçiş kuralları ve uzunluk limitlerine göre rastgele isimler üretir.
## İsimler havuz sistemi ile saklanır, böylece tekrar etmeden benzersiz isimler alınabilir.
##
class_name NameKit extends Utilities

## Üretilecek isimlerin minimum uzunluğu.
const MIN_LENGTH = 4

## Üretilecek isimlerin maksimum uzunluğu.
const MAX_LENGTH = 10

## Harf tiplerini ve bunlara ait karakter gruplarını tanımlar.
const LETTERS = {
	# Tek ünlüler
	"VOYELLE": ['a', 'e', 'i', 'o', 'u', 'y'],
	# Çift ünlüler
	"DOUBLE_VOYELLE": ['oi', 'ai', 'ou', 'ei', 'ae', 'eu', 'ie', 'ea'],
	# Tek ünsüzler
	"CONSONNE": ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 
				'p', 'r', 's', 't', 'v', 'w', 'x', 'z'],
	# Çift ünsüzler
	"DOUBLE_CONSONNE": ['mm', 'nn', 'st', 'ch', 'll', 'tt', 'ss'],
	# Özel bileşikler
	"COMPOSE": ['qu', 'gu', 'cc', 'sc', 'tr', 'fr', 'pr',
				'br', 'cr', 'ch', 'll', 'tt', 'ss', 'gn']
}

## Her harf tipinden sonra hangi harf tiplerinin 
## gelebileceğini tanımlar. Bu yapı, isim üretimi 
## sırasında karakter dizilimlerinin mantıklı ve 
## okunabilir olmasını sağlar.
const TRANSITION = {
	"INITIAL": ['VOYELLE', 'CONSONNE', 'COMPOSE'], 
	"VOYELLE": ['CONSONNE', 'DOUBLE_CONSONNE', 'COMPOSE'], 
	"DOUBLE_VOYELLE": ['CONSONNE', 'DOUBLE_CONSONNE', 'COMPOSE'], 
	"CONSONNE": ['VOYELLE', 'DOUBLE_VOYELLE'], 
	"DOUBLE_CONSONNE": ['VOYELLE', 'DOUBLE_VOYELLE'], 
	"COMPOSE": ['VOYELLE']
}

## Rastgele sayı üreteci (tekil static instance).
static var random_number := RandomNumberGenerator.new()

## Önceden üretilmiş ve henüz kullanılmamış isim havuzu.
static var available_names: Array = []

## genel sonekler
enum Suffixes {
	# Roma rakamları
	I, II, III, IV, V, VI, VII, VIII, IX, X, XI, XII, XIII, XIV, 
	XV, XVI, XVII, XVIII, XIX, XX,

	# Yunan harfleri
	Alfa, Beta, Gamma, Delta, Epsilon, Zeta, Eta, Theta, Iota, Kappa, Lambda,
	Mu, Nu, Xi, Omikron, Pi, Rho, Sigma, Tau, Upsilon, Phi, Chi, Psi, Omega,

	# Bilimkurgu / astronomi odaklı
	Prime, Primeval, Secundus, Proxima, Ultima, Terminus, Nexus, Aegis,
	Centauri, Lyrae, Orionis, Draconis, Andromedae, Aquilae, Perseus,

	# Güçlü/epik tanımlamalar
	Major, Minor, Supra, Infra, Zenith, Apex, Horizon, Obsidian, Nova
}

## uzay istasyonları için tipik sonekler
enum StationSuffixes {
	Station, Spacedock,	Habitat, Citadel, Outpost, Hub,
	Colony, Arcology, Platform, Stronghold, Command, Relay,
	Depot, Sanctuary, Haven
}

## POI (Point of Interest) lokasyon sonekleri
enum PoiSuffixes {
	Base, Complex, Vault, Lab, Observatory, Archive,
	Nexus, Crypt, Wreck, Derelict, Ruins, Monolith, Temple,
	Shrine, Forge, Mine, Refinery, Outlands, Frontier, Facility
}

## Üretici firmalar için tipik sonekler
enum ManufacturerSuffixes {
	Core, Corp,	Tech, Dynamics, Industries, Systems,
	Forge, Assembly, Collective, Consortium, Syndicate,
	Conglomerate, Union, Alliance, Combine, Guild, Order
}

## 
## Havuzdan benzersiz bir isim döndürür, 
## yoksa yeni isimler üretir.
## 
## @example NameKit.unique()
## 
## @return String|void
## 
static func unique() -> String:
	NameKit._init_pool(Dice.roll(100))
	
	if available_names.is_empty():
		push_error("Tüm isimler kullanıldı!")
		return ""
		
	var idx := random_number.randi_range(0, available_names.size() - 1)
	var name: String = available_names[idx]
	available_names.remove_at(idx)
	
	return name

## 
## Suffixes listesinden
## rastgele bir sonek dönderir
## 
## @example NameKit.suffix()
## @return String
## 
static func suffix() -> String:
	# her zaman suffix kullanılmasın
	# yüzde 60 oranında olasılık olsun
	var use_suffix = randf() < 0.6
	
	if use_suffix:
		return Dice.fromDictionary(NameKit.Suffixes)
	
	return ""

## 
## rastgele isim ve soyisim oluşturma.
## özellikle karakter oluşturma (NPC veya değil)
## sırasında kullanılabilir.
## 
## @example NameKit.fullname()
## 
## @return String
## 
static func fullname() -> String:
	return NameKit.unique() + " " + NameKit.unique()


## 
## İsim havuzunu belirtilen sayıda isimle doldurur (eğer boşsa).
## 
## @param int count: Havuzda üretilecek isim sayısı.
## 
## @return void
## 
static func _init_pool(count: int) -> void:
	if available_names.is_empty():
		for i in range(count):
			available_names.append(NameKit._generate_raw())

## 
## Belirtilen uzunluk aralığında tek bir rastgele isim üretir.
## 
## @param int min_length: Minimum uzunluk (varsayılan: MIN_LENGTH).
## @param int max_length: Maksimum uzunluk (varsayılan: MAX_LENGTH).
## 
## @return String : Üretilen isim (ilk harfi büyük).
## 
static func _generate_raw(min_length: int = MIN_LENGTH, max_length: int = MAX_LENGTH) -> String:
	if random_number.seed == 0:
		random_number.randomize()

	var length := random_number.randi_range(min_length, max_length)
	var name: String = ""
	var index := 0
	var state := "INITIAL"

	while index < length:
		var obj := NameKit._get_letter(state, length - index)
		state = obj[0]
		var letter: String = obj[1]
		name += letter
		index += len(letter)

	return name.capitalize()

## 
## Mevcut harf tipi ve kalan uzunluğa göre 
## rastgele bir harf veya harf grubu seçer.
## 
## @param String state: Mevcut harf tipi.
## @param int remaining_length: İsimde kalan maksimum karakter sayısı.
## 
## @return Array: [state, letter]
## 
static func _get_letter(state: String, remaining_length: int) -> Array:
	var transitions: Array = TRANSITION[state].duplicate()

	if remaining_length < 3:
		transitions.erase("COMPOSE")
		transitions.erase("DOUBLE_CONSONNE")
		transitions.erase("DOUBLE_VOYELLE")
	
	if transitions.is_empty():
		return [state, ""]

	state = transitions[random_number.randi_range(0, transitions.size() - 1)]
	var letters_list: Array= LETTERS[state]
	var letter: String = letters_list[random_number.randi_range(0, letters_list.size() - 1)]

	return [state, letter]
