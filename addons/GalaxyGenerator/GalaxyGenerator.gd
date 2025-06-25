## 
## Oyun evreni, prosedürel oluşturma
## yöntemini kullanır. Oyundaki galaksi,
## yıldız sistemi ve sistemlere ait
## gezegen/ay/asteroit sayılarını oyuncu belirler 
## (veya varsayılan olarak sistem rastgele üretir)
## 
class_name GalaxyGenerator extends Node

## MIN/MAX SABİT DEĞERLERİ
## [Sabit değerler, sistemin tüm genelinde kullanılır
## ve prosedürel oluşturma yapısını etkiler]
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

## PATHS
## @link https://docs.godotengine.org/en/latest/tutorials/io/data_paths.html
## isim listesinin yer aldığı kaynak dosya
const INPUT_PATH := "res://addons/ResourceManager/Resource/Universe/Names.json"
## oluşturulan galaksi bilgilerinin yer aldığı
## json dosyasının kaydedileceği dizin yolu ve dosya adı
const OUTPUT_PATH := "user://Galaxies.json"

var galaxies = []
## TODO: star_systems ve planets ikinci adımda yapılacak
#var star_systems = []
#var planets = []

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
## Step 1
## İlk adımımız galaksilerin oluşturulması
## 
func generate_galaxy():
	var file = FileAccess.open(INPUT_PATH, FileAccess.READ)
	if not file:
		push_error("Galaksi isim dosyası açılamadı.")
		return

	var names_data = JSON.parse_string(file.get_as_text())
	file.close()

	if names_data == null or names_data.is_empty():
		push_error("Galaksi isim verisi okunamadı veya boş.")
		return

	var galaxy_count = randi_range(MinGalaxy, max_galaxy_count)
	names_data.shuffle()

	for i in range(min(galaxy_count, names_data.size())):
		var entry = names_data[i]
		var galaxy = {
			"name": entry.get("name", "Unnamed Galaxy"),
			"slug": entry.get("slug", "unnamed"),
			"star_system_count": randi_range(MinSystem, max_system_count)
		}
		galaxies.append(galaxy)

	# JSON dosyasını yazdır
	var json_text = JSON.stringify(galaxies, "\t")
	var out_file = FileAccess.open(OUTPUT_PATH, FileAccess.WRITE)
	# kullanıcı dizinine kaydet
	out_file.store_string(json_text)
	out_file.close()

	print(galaxy_count, " adet galaksi başarıyla oluşturuldu ve json dosyasına kaydedildi.")
	print(galaxies)
