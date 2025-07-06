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

## oluşturulan yıldız sistemlerine ait json
## dosyalarının kaydedileceği dizin adı
const STARSYSTEM_DIRNAME := "StarSystems"

## Veri Paketleri
## oluşturulan galaksilerin paketlendiği array
var galaxies = []
## oluşturulan yıldız sistemlerinin paketlendiği array
var star_systems = []

## Oyundaki maksimum galaksi sayısı
## boş bırakılırsa "MinGalaxy - MaxGalaxy" 
## değer aralığında rastgele bir sayı üretilir
@export_range(MinGalaxy, MaxGalaxy) var max_galaxy_count: int = randi_range(MinGalaxy, MaxGalaxy)

## Bir galaksideki maksimum yıldız sistemi sayısı
## boş bırakılırsa "MinSystem - MaxSystem" 
## değer aralığında rastgele bir sayı üretilir
@export_range(MinSystem, MaxSystem) var max_system_count: int = randi_range(MinSystem, MaxSystem)

## Bir yıldız sistemi içindeki en fazla gezegen sayısı
## boş bırakılırsa "MinPlanet - MaxPlanet" 
## değer aralığında rastgele bir sayı üretilir
@export_range(MinPlanet, MaxPlanet) var max_planet_count: int = randi_range(MinPlanet, MaxPlanet)

## Bir yıldız sistemi içindeki en fazla asteroit kuşak sayısı
## boş bırakılırsa "MinAsteroid - MaxAsteroid" 
## değer aralığında rastgele bir sayı üretilir
@export_range(MinAsteroid, MaxAsteroid) var max_asteroid_count: int = randi_range(MinAsteroid, MaxAsteroid)

## Bir gezegene ait en fazla uydu sayısı
## boş bırakılırsa "MinMoon ila MaxMoon" 
## değer aralığında rastgele bir sayı üretilir
@export_range(MinMoon, MaxMoon) var max_moon_count: int = randi_range(MinMoon, MaxMoon)

## 
## 
## 
func _ready():
	generate_galaxy()

## 
## 
## 
func generate_galaxy():
	var galaxy_count = randi_range(MinGalaxy, max_galaxy_count)

	for i in range(min(galaxy_count, NameProvider.getNames().size())):
		var entry = NameProvider.randomName(i)
		var galaxy = {
			"name": entry.get("name", "Unnamed Galaxy"),
			"slug": entry.get("slug", "unnamed"),
			"star_system_count": randi_range(MinSystem, max_system_count)
		}
		galaxies.append(galaxy)

	# JSON dosyasını yazdır
	var json_text = JSON.stringify(galaxies, "\t")
	var out_file = FileAccess.open(NameProvider.OUTPUT_PATH, FileAccess.WRITE)
	# kullanıcı dizinine kaydet
	out_file.store_string(json_text)
	out_file.close()

	print_rich("[color=green]%s adet galaksi başarıyla oluşturuldu ve json dosyasına kaydedildi.[/color]" % [galaxy_count])
	_generate_first_starsystem()

## 
## @param galaxy: {Dictionary}
## 
func generate_star_system(galaxy: Dictionary):
	var system_dir_path = "user://" + STARSYSTEM_DIRNAME
	var dir = DirAccess.open("user://")
	if dir and not dir.dir_exists(STARSYSTEM_DIRNAME):
		var make_dir = dir.make_dir(STARSYSTEM_DIRNAME)
		if make_dir == OK:
			print_rich("[color=green]%s klasörü başarıyla oluşturuldu.[/color]" % [STARSYSTEM_DIRNAME])
		else:
			push_error(STARSYSTEM_DIRNAME + " klasörü oluşturulamadı.")
			return
	
	var galaxy_slug = galaxy.get("slug", "unnamed")
	var star_count = galaxy.get("star_system_count", 1)

	for i in range(star_count):
		var system_name
		var system_slug
		var star_name = NameProvider.randomName()
		var suffix = NameProvider.randomSuffix()
		
		if suffix:
			system_name = "%s %s" % [star_name.name, suffix]
			system_slug = "%s_%s" % [star_name.slug, suffix.to_lower()]
		else:
			system_name = "%s" % [star_name.name]
			system_slug = "%s" % [star_name.slug]
	
		var star_data = {
			"name": system_name,
			"slug": system_slug,
			"planet_count": randi_range(MinPlanet, max_planet_count),
			"asteroid_count": randi_range(MinAsteroid, max_asteroid_count)
		}
		
		star_systems.append(star_data)

	# JSON dosyasını yazdır
	var get_systems = JSON.stringify(star_systems, "\t")
	var system_file = FileAccess.open(system_dir_path+"/"+galaxy_slug+".json", FileAccess.WRITE)
	# kullanıcı dizinine kaydet
	system_file.store_string(get_systems)
	system_file.close()

	print_rich("[color=green]%s galaksisi için %d adet yıldız sistemi üretildi.[/color]" % [galaxy_slug, star_count])

## 
## TODO
## 
func generate_planet():
	pass

## 
## oyunun başlangıcında galaksiler
## oluşturulduktan sonra çalışır
## 
func _generate_first_starsystem():
	# daha önce oluşturulmuş yıldız sistemleri dosyası veya dosyaları
	# varsa temizleyelim. beyaz bir sayfa açıyoruz.
	var system_dir = "user://" + STARSYSTEM_DIRNAME
	DirUtil.clearDirectory(system_dir)
	
	var galaxies = _load_generated_galaxies()
	if galaxies == null or galaxies.is_empty():
		push_error("Galaksi listesi bulunamadı.")
		return

	var first_galaxy = galaxies[0]
	print("İlk galaksi seçildi:", first_galaxy.name)
	generate_star_system(first_galaxy)

## 
## Daha önce oluşturulmuş galaksi listesini
## yükleme işlemi
## 
## @return Array
## 
func _load_generated_galaxies() -> Array:
	var file_path = NameProvider.OUTPUT_PATH
	if not FileAccess.file_exists(file_path):
		push_error("Galaksi dosyası yok: " + file_path)
		return []

	var f = FileAccess.open(file_path, FileAccess.READ)
	if f == null:
		push_error("Galaksi dosyası açılamadı.")
		return []

	var json_text = f.get_as_text()
	f.close()

	var parsed = JSON.parse_string(json_text)
	if parsed == null or not parsed is Array:
		push_error("Geçersiz galaksi JSON formatı.")
		return []

	return parsed
