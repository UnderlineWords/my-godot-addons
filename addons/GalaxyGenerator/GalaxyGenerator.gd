## 
## @class GalaxyGenerator
## 
class_name GalaxyGenerator extends Node

## oyundaki minimum ve maksimum galaksi sayısı
const MinGalaxy: int = 7
const MaxGalaxy: int = 25
## galaksi içindeki minimum ve maksimum yıldız sistemi sayısı
const MinSystem: int = 10
const MaxSystem: int = 50
## yıldız sistemi içindeki minimum ve maksimum gezegen sayısı
const MinPlanet: int = 3
const MaxPlanet: int = 20
## yıldız sistemi içindeki minimum ve maksimum asteroit kuşak sayısı
const MinAsteroid: int = 0
const MaxAsteroid: int = 3
## bir gezegene ait minimum ve maksimum ay/uydu sayısı
const MinMoon: int = 0
const MaxMoon: int = 4

## bir gezegenin toplam gün uzunluğu (saat)
## dünyaya göre ±%20'lik sapma
const MinDayLenght: int = 19
const MaxDayLenght: int = 29
## bir gezegenin toplam yıl uzunluğu (gün)
## dünyaya göre ±%20'lik sapma
const MinYearLenght: int = 292
const MaxYearLenght: int = 438

##
## @link https://docs.godotengine.org/en/latest/tutorials/io/data_paths.html#accessing-persistent-user-data-user
## oluşturulan Galaxies.json
## dosyasının kaydedileceği dizin adı
const GALAXY_DIRNAME := "Galaxies"
## dosyanın yer alacağı dizin yolu
const GALAXY_PATH = "user://"+GALAXY_DIRNAME
## galaksi listesinin yer aldığı dizin yolu
const OUTPUT_PATH := GALAXY_PATH+"/Galaxies.json"

## Veri Paketleri
var galaxies = []
var star_systems = []
var planets = []
var moons = []
var asteroids = []

## Oyundaki maksimum galaksi sayısı
@export_range(MinGalaxy, MaxGalaxy) var max_galaxy_count: int = Dice.range(MinGalaxy, MaxGalaxy)

## Bir galaksideki maksimum yıldız sistemi sayısı
@export_range(MinSystem, MaxSystem) var max_system_count: int = Dice.range(MinSystem, MaxSystem)

## Bir yıldız sistemi içindeki en fazla gezegen sayısı
@export_range(MinPlanet, MaxPlanet) var max_planet_count: int = Dice.range(MinPlanet, MaxPlanet)

## Bir yıldız sistemi içindeki en fazla asteroit kuşak sayısı
@export_range(MinAsteroid, MaxAsteroid) var max_asteroid_count: int = Dice.range(MinAsteroid, MaxAsteroid)

## Bir gezegene ait en fazla uydu sayısı
@export_range(MinMoon, MaxMoon) var max_moon_count: int = Dice.range(MinMoon, MaxMoon)

## 
## 
## 
func _ready():
	randomize()
	# varsa önceki dizin ve alt dizinleri sil
	FileBox.clear(GALAXY_PATH)
	# galaksiler için yeni dizini oluştur
	FileBox.makeDir("user://", GALAXY_DIRNAME)
	# galaksileri oluştur
	generate_galaxy()
	
## 
## Adım 1
## oyun başlangıcında çalışır
## ve oyunda yer alacak tüm galaksileri
## "max_galaxy_count" sayısı kadar oluşturur
## 
func generate_galaxy():
	var galaxy_count = Dice.range(MinGalaxy, max_galaxy_count)

	for i in galaxy_count:
		var galaxy_name = NameGenerator.unique()
		var galaxy_slug = galaxy_name.to_lower()
		var galaxy = {
			"name": galaxy_name,
			"slug": galaxy_slug,
			"star_system_count": Dice.range(MinSystem, max_system_count)
		}
		galaxies.append(galaxy)
		# galaksilere ait dizinleri oluştur
		FileBox.makeDir(GALAXY_PATH, galaxy_slug)

	var json_text = JSON.stringify(galaxies, "\t")
	var out_file = FileBox.write(OUTPUT_PATH)
	out_file.store_string(json_text)
	out_file.close()

	print_rich("[color=green]%s adet galaksi başarıyla oluşturuldu ve json dosyasına kaydedildi.[/color]" % [galaxy_count])
	
	# 2.Adıma Geç
	# tüm galaksiler oluşturulduktan sonra,
	# listedeki ilk galaksi için ilk 
	# yıldız sistemini oluşturuyoruz.
	_generate_first_starsystem()

## 
## Adım 2
## bu fonksiyon oyun başlangıcında,
## galaksiler oluşturulduktan sonra çalışır
## ve oyunun ilk yıldız sistemini oluşturur
## 
func _generate_first_starsystem():
	# önce galaksi listesini yükle
	var galaxies = _load_generated_galaxies()
	if galaxies == null or galaxies.is_empty():
		push_error("Galaksi listesi bulunamadı.")
		return

	# listedeki ilk galaksiyi seç
	var first_galaxy = galaxies[0]
	print("Listeden seçilen ilk galaksi: ", first_galaxy.name)
	# ve seçilen galaksi için ilk yıldız sistemini oluştur
	generate_starsystem(first_galaxy)

## 
## bir galaksiye ait tüm yıldız sistemlerini
## oluşturmak için kullanılan fonksiyon
## 
## @param galaxy: {Dictionary}
## 
func generate_starsystem(galaxy: Dictionary):		
	var galaxy_slug = galaxy.get("slug", "unnamed")
	var star_count = galaxy.get("star_system_count", 1)
	for i in range(star_count):
		var system_name
		var system_slug
		var star_name = NameGenerator.unique()
		var suffix = Dice.suffix()
		if suffix:
			system_name = "%s %s" % [star_name, suffix]
			system_slug = "%s_%s" % [star_name.to_lower(), suffix.to_lower()]
		else:
			system_name = "%s" % [star_name]
			system_slug = "%s" % [star_name.to_lower()]
	
		var star_data = {
			"name": system_name,
			"slug": system_slug,
			"galaxy": galaxy_slug,
			"planet_count": Dice.range(MinPlanet, max_planet_count),
			"asteroid_count": Dice.range(MinAsteroid, max_asteroid_count)
		}
		star_systems.append(star_data)
		
	var get_systems = JSON.stringify(star_systems, "\t")
	var first_starsystem = star_systems[0]
	
	# ilk yıldız sistemi için gezegenleri oluştur
	print_rich("[color=green]%s galaksisi için %d adet yıldız sistemi üretildi.[/color]" % [galaxy_slug, star_count])
	print("listeden seçilen ilk yıldız sistemi: ", first_starsystem.name)
	generate_planet(first_starsystem)
	print_rich("[color=green]%s yıldız sistemi için %d adet gezegen oluşturuldu.[/color]" % [first_starsystem.name, first_starsystem.planet_count])

	# oluşturulan tüm yıldız sistemlerini 
	# starsystems.json dosyasına kaydet
	var system_file = FileBox.write(GALAXY_PATH+"/"+galaxy_slug+"/starsystems.json")
	system_file.store_string(get_systems)
	system_file.close()

## 
## bir yıldız sistemine ait
## tüm gezegenleri oluşturmak için
## kullanılan fonksiyon
## 
## @param starsystem
## 
func generate_planet(starsystem):
	# "planet_count" sayısınca gezegen oluştur
	for i in range(starsystem.planet_count):
		var planet_name
		var planet_slug
		var get_name = NameGenerator.unique()
		var get_suffix = Dice.suffix()
		
		if get_suffix:
			planet_name = "%s %s" % [get_name, get_suffix]
			planet_slug = "%s_%s" % [get_name.to_lower(), get_suffix.to_lower()]
		else:
			planet_name = "%s" % [get_name]
			planet_slug = "%s" % [get_name.to_lower()]
		
		var planet_data = {
			"name": planet_name,
			"slug": planet_slug,
			"star_system": starsystem.slug,
			"atmosphere": Dice.fromDictionary(AtmosphereResource.Type),
			"resources": Dice.fromArray(Ore.getList(), Dice.range(0, 4)),
			"plants": Dice.fromArray(Plant.getList(), Dice.range(0, 5)),
			"water_presence": Dice.flip(),
			"ice_presence": Dice.flip(),
			"day_length": Dice.range(MinDayLenght, MaxDayLenght),
			"year_length": Dice.range(MinYearLenght, MaxYearLenght),
			"moons_count": Dice.range(MinMoon, MaxMoon)
		}
		
		planets.append(planet_data)
		_generate_moon(planet_data.slug, planet_data.moons_count)
	
	var get_planets = JSON.stringify(planets, "\t")
	# yıldız sistemi için klasör oluştur
	FileBox.makeDir(GALAXY_PATH+"/"+starsystem.galaxy, starsystem.slug)
	var planet_file = FileBox.write(GALAXY_PATH+"/"+starsystem.galaxy+"/"+starsystem.slug+"/planets.json")
	planet_file.store_string(get_planets)
	planet_file.close()

## 
## TODO
## 
func _generate_moon(planet_slug: String, moon_count: int):
	pass
	
## 
## TODO
## 
func generate_asteroid(starsystem_slug: String, asteroid_count: int):
	pass

## 
## daha önce oluşturulmuş galaksilere
## ait json dosyasını array olarak dönderir
## 
## @return Array
## 
func _load_generated_galaxies() -> Array:
	if not FileBox.has(OUTPUT_PATH):
		push_error("Galaksi dosyası yok: " + OUTPUT_PATH)
		return []

	var file = FileBox.read(OUTPUT_PATH)
	if file == null:
		push_error("Galaksi dosyası açılamadı.")
		return []

	var json_text = file.get_as_text()
	file.close()

	var parsed = JSON.parse_string(json_text)
	if parsed == null or not parsed is Array:
		push_error("Geçersiz galaksi JSON formatı.")
		return []

	return parsed
