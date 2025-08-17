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

## bir gezegenin/uydunun toplam gün uzunluğu (saat)
## dünyaya göre ±%20'lik sapma
const MinDayLenght: int = 19
const MaxDayLenght: int = 29
## bir gezegenin/uydunun toplam yıl uzunluğu (gün)
## dünyaya göre ±%20'lik sapma
const MinYearLenght: int = 292
const MaxYearLenght: int = 438

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
	FileKit.clear(GALAXY_PATH)
	# galaksiler için yeni dizini oluştur
	FileKit.makeDir("user://", GALAXY_DIRNAME)
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
		var galaxy_name = NameKit.unique()
		var galaxy_slug = galaxy_name.to_lower()
		var galaxy = {
			"name": galaxy_name,
			"slug": galaxy_slug,
			"star_system_count": Dice.range(MinSystem, max_system_count)
		}
		galaxies.append(galaxy)
		# galaksilere ait dizinleri oluştur
		FileKit.makeDir(GALAXY_PATH, galaxy_slug)

	var json_text = JSON.stringify(galaxies, "\t")
	var out_file = FileKit.write(OUTPUT_PATH)
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
	var file_path = GALAXY_PATH+"/"+galaxy_slug
	for i in range(star_count):
		var system_name
		var system_slug
		var star_name = NameKit.unique()
		var suffix = NameKit.suffix()
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
	
	# ilk yıldız sistemi için gezegenleri ve asteroit kuşakları oluştur
	print_rich("[color=green]%s galaksisi için, %d adet yıldız sistemi üretildi.[/color]" % [galaxy_slug, star_count])
	print("listeden seçilen ilk yıldız sistemi: ", first_starsystem.name)
	
	# yıldız sistemine ait gezegenlerin oluşturulması
	if first_starsystem.planet_count > 0:
		generate_planet(first_starsystem)
		print_rich("[color=green]%s yıldız sistemi için, %d adet gezegen oluşturuldu.[/color]" % [first_starsystem.name, first_starsystem.planet_count])
	
	# yıldız sistemine ait asteroit kuşakların oluşturulması
	if first_starsystem.asteroid_count > 0:
		generate_asteroid(first_starsystem, file_path)
		print_rich("[color=green]%s yıldız sistemi için, %d adet asteroit kuşağı oluşturuldu.[/color]" % [first_starsystem.name, first_starsystem.asteroid_count])
	
	# oluşturulan tüm yıldız sistemlerini 
	# starsystems.json dosyasına kaydet
	var system_file = FileKit.write(file_path+"/starsystems.json")
	system_file.store_string(get_systems)
	system_file.close()
	
## 
## bir yıldız sistemine ait
## tüm gezegenleri oluşturmak için
## kullanılan fonksiyon
## 
## @param starsystem
## 
func generate_planet(starsystem: Dictionary):
	# yıldız sistemi için klasör oluştur
	var file_path = GALAXY_PATH+"/"+starsystem.galaxy+"/"+starsystem.slug
	var planet_file = file_path+"/planets.json"
	FileKit.makeDir(GALAXY_PATH+"/"+starsystem.galaxy, starsystem.slug)
	
	# "planet_count" sayısınca gezegen oluştur
	for i in range(starsystem.planet_count):
		var planet_name
		var planet_slug
		var get_name = NameKit.unique()
		var get_suffix = NameKit.suffix()
		
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
			"moon_count": Dice.range(MinMoon, MaxMoon)
		}
		
		planets.append(planet_data)
		# gezegene ait uyduları oluştur
		_generate_moon(planet_data, file_path)
	
	var get_planets = JSON.stringify(planets, "\t")
	var planet_json = FileKit.write(planet_file)
	planet_json.store_string(get_planets)
	planet_json.close()

## 
## @param starsystem: Dictionary
## @paran path: String
## 
func generate_asteroid(starsystem: Dictionary, path: String):
	# asteroit kayıtları için json dosyası
	var asteroid_file = FileKit.write(path+"/"+starsystem.slug+"/asteroids.json")
	
	# "asteroid_count" sayısınca asteroit kuşağı oluştur
	for i in range(starsystem.asteroid_count):
		var asteroid_name
		var asteroid_slug
		var get_name = NameKit.unique()
		var get_suffix = NameKit.suffix()
		
		if get_suffix:
			asteroid_name = "%s %s" % [get_name, get_suffix]
			asteroid_slug = "%s_%s" % [get_name.to_lower(), get_suffix.to_lower()]
		else:
			asteroid_name = "%s" % [get_name]
			asteroid_slug = "%s" % [get_name.to_lower()]
		
		var asteroid_data = {
			"name": asteroid_name,
			"slug": asteroid_slug,
			"star_system": starsystem.slug,
			"resources": Dice.fromArray(Ore.getList(), Dice.range(0, 4)),
			"water_presence": Dice.flip(),
			"ice_presence": Dice.flip()
		}
		
		asteroids.append(asteroid_data)
	
	var get_asteroids = JSON.stringify(asteroids, "\t")
	# asteroit kuşaklarına ait dosyayı kaydet
	asteroid_file.store_string(get_asteroids)
	asteroid_file.close()

## 
## @param planet: Dictionary
## @paran path: String
## 
func _generate_moon(planet: Dictionary, path: String):
	# "moon_count" sayısınca uydu oluştur
	for i in range(planet.moon_count):
		var moon_name
		var moon_slug
		var get_name = NameKit.unique()
		var get_suffix = NameKit.suffix()
		
		if get_suffix:
			moon_name = "%s %s" % [get_name, get_suffix]
			moon_slug = "%s_%s" % [get_name.to_lower(), get_suffix.to_lower()]
		else:
			moon_name = "%s" % [get_name]
			moon_slug = "%s" % [get_name.to_lower()]
		
		var moon_data = {
			"name": moon_name,
			"slug": moon_slug,
			"planet": planet.slug,
			"resources": Dice.fromArray(Ore.getList(), Dice.range(0, 4)),
			"water_presence": Dice.flip(),
			"ice_presence": Dice.flip(),
			"day_length": Dice.range(MinDayLenght, MaxDayLenght),
			"year_length": Dice.range(MinYearLenght, MaxYearLenght)
		}
		moons.append(moon_data)

	var get_moons = JSON.stringify(moons, "\t")
	# uydulara ait dosyayı kaydet
	var moon_file = FileKit.write(path+"/moons.json")
	moon_file.store_string(get_moons)
	moon_file.close()
	
## 
## daha önce oluşturulmuş galaksilere
## ait json dosyasını array olarak dönderir
## 
## @return Array
## 
func _load_generated_galaxies() -> Array:
	if not FileKit.has(OUTPUT_PATH):
		push_error("Galaksi dosyası yok: " + OUTPUT_PATH)
		return []

	var file = FileKit.read(OUTPUT_PATH)
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
