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

## bir gezegenin toplam gün uzunluğu aralığı
## dünyaya göre ±%20'lik sapma
const MinDayLenght: int = 19
const MaxDayLenght: int = 29
## bir gezegenin toplam yıl uzunluğu aralığı
## dünyaya göre ±%20'lik sapma
const MinYearLenght: int = 292
const MaxYearLenght: int = 438

## oluşturulan yıldız sistemlerine ait json
## dosyalarının kaydedileceği dizin adı
const STARSYSTEM_DIRNAME := "StarSystems"

## @link https://docs.godotengine.org/en/latest/tutorials/io/data_paths.html
const OUTPUT_PATH := "user://Galaxies.json"

## Veri Paketleri
var galaxies = []
var star_systems = []
var planets = []

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
	generate_galaxy()

## 
## 
## 
func generate_galaxy():
	var galaxy_count = Dice.range(MinGalaxy, max_galaxy_count)

	for i in range(min(galaxy_count, NamePool.take().size())):
		var entry = Dice.name(i)
		var galaxy = {
			"name": entry.get("name", "Unnamed Galaxy"),
			"slug": entry.get("slug", "unnamed"),
			"star_system_count": Dice.range(MinSystem, max_system_count)
		}
		galaxies.append(galaxy)

	var json_text = JSON.stringify(galaxies, "\t")
	var out_file = FileBox.write(OUTPUT_PATH)
	out_file.store_string(json_text)
	out_file.close()

	print_rich("[color=green]%s adet galaksi başarıyla oluşturuldu ve json dosyasına kaydedildi.[/color]" % [galaxy_count])
	_generate_first_starsystem()

## 
## @param galaxy: {Dictionary}
## 
func generate_starsystem(galaxy: Dictionary):
	var system_dir_path = "user://" + STARSYSTEM_DIRNAME
	var directory = DirAccess.open("user://")
	if directory and not directory.dir_exists(STARSYSTEM_DIRNAME):
		var create_directory = directory.make_dir(STARSYSTEM_DIRNAME)
		if create_directory == OK:
			print_rich("[color=green]%s klasörü başarıyla oluşturuldu.[/color]" % [STARSYSTEM_DIRNAME])
		else:
			push_error(STARSYSTEM_DIRNAME + " klasörü oluşturulamadı.")
			return
	
	var galaxy_slug = galaxy.get("slug", "unnamed")
	var star_count = galaxy.get("star_system_count", 1)

	for i in range(star_count):
		var system_name
		var system_slug
		var star_name = Dice.name()
		var suffix = Dice.suffix()
		
		if suffix:
			system_name = "%s %s" % [star_name.name, suffix]
			system_slug = "%s_%s" % [star_name.slug, suffix.to_lower()]
		else:
			system_name = "%s" % [star_name.name]
			system_slug = "%s" % [star_name.slug]
	
		var star_data = {
			"name": system_name,
			"slug": system_slug,
			"planet_count": Dice.range(MinPlanet, max_planet_count),
			"asteroid_count": Dice.range(MinAsteroid, max_asteroid_count)
		}
		
		star_systems.append(star_data)
		
	var get_systems = JSON.stringify(star_systems, "\t")
	var system_file = FileBox.write(system_dir_path+"/"+galaxy_slug+".json")
	system_file.store_string(get_systems)
	system_file.close()

	print_rich("[color=green]%s galaksisi için %d adet yıldız sistemi üretildi.[/color]" % [galaxy_slug, star_count])

## 
## @param starsystem_slug: String
## @param planet_count: int
## 
func generate_planet(starsystem_slug: String, planet_count: int):	
	for i in range(planet_count):
		var planet_name
		var planet_slug
		var get_name = Dice.name()
		var get_suffix = Dice.suffix()
		
		if get_suffix:
			planet_name = "%s %s" % [get_name.name, get_suffix]
			planet_slug = "%s_%s" % [get_name.slug, get_suffix.to_lower()]
		else:
			planet_name = "%s" % [get_name.name]
			planet_slug = "%s" % [get_name.slug]
		
		var planet_data = {
			"name": planet_name,
			"slug": planet_slug,
			"star_system": starsystem_slug,
			"atmosphere": Dice.draw(AtmosphereResource.Type),
			"resources": Dice.draw(Ore.List, Dice.range(0, 4)),
			#"plants": Dice.draw(Plant.Type, Dice.range(0,5)), # TODO
			"water_presence": Dice.flip(),
			"ice_presence": Dice.flip(),
			"day_length": Dice.range(MinDayLenght, MaxDayLenght),
			"year_length": Dice.range(MinYearLenght, MaxYearLenght),
			"moons_count": Dice.range(MinMoon, MaxMoon)
		}
		
		planets.append(planet_data)
		print(planet_data)
		_generate_moon(planet_data)

## 
## TODO
## 
func _generate_moon(planet: Dictionary):
	pass

## 
## 
## 
func _generate_first_starsystem():
	var system_dir = "user://" + STARSYSTEM_DIRNAME
	FileBox.clear(system_dir)
	
	var galaxies = _load_generated_galaxies()
	if galaxies == null or galaxies.is_empty():
		push_error("Galaksi listesi bulunamadı.")
		return

	var first_galaxy = galaxies[0]
	print("İlk galaksi seçildi:", first_galaxy.name)
	generate_starsystem(first_galaxy)

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
