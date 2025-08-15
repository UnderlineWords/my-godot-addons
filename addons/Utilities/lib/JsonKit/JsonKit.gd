## 
## @class JsonKit
## 
class_name JsonKit extends Node

## 
## Belirtilen dizinden JSON dosyasını yükler
## ve Array biçiminde döndürür
##
## @example JsonKit.load("res://sample.json")
## 
## @param file_path: String
## 
## @return Array
## 
static func load(file_path: String) -> Array:
	if not FileBox.has(file_path):
		push_error("Dosya bulunamadı: %s" % file_path)
		return []

	var file = FileBox.read(file_path)
	if file == null:
		push_error("Dosya açılamıyor: %s" % file_path)
		return []

	var json_data := JSON.parse_string(file.get_as_text())
	file.close()

	if typeof(json_data) != TYPE_ARRAY:
		push_error("Geçersiz JSON Formatı")
		return []

	return json_data

## 
## Json dosyasından alınan verileri,
## tekli veya çoklu olarak filtreler
##
## @example JsonKit.filter(names, {"name": "John"})
## @example JsonKit.filter(plants, {"name": "Sample", "type": "herb"})
## 
## @param items: Array
## @param filters: Dictionary
## 
## @return Array
## 
static func filter(items: Array, filters: Dictionary) -> Array:
	return items.filter(func(i):
		if typeof(i) != TYPE_DICTIONARY:
			return false
		for key in filters.keys():
			if not i.has(key) or i[key] != filters[key]:
				return false
		return true
	)

##
## load() ve filter() fonksiyonlarını
## tek bir fonksiyon altında çalıştırır
##
## @param file_path: String
## @param filters: Dictionary
##
## @example JsonKit.loadAndFilter(plants, {"type": "herb"})
##
## @return Array
## 
static func loadAndFilter(file_path: String, filters: Dictionary) -> Array:
	return JsonKit.filter(JsonKit.load(file_path), filters)

## 
## bir array listesinde belirtilen kıstaslara göre
## arama yapar ve sonuçları array olarak döndürür
## 
## @param items: Array
## @param key: String
## @param query: String
##
## @example JsonKit.search(plants, "description", "Freezing")
## 
## @return Array
## 
static func search(items: Array, key: String, query: String) -> Array:
	var results: Array = []

	for i in items:
		if typeof(i) != TYPE_DICTIONARY or not i.has(key):
			continue
		var value_str = str(i[key])
		if value_str.find(query) != -1:
			results.append(i)

	return results

## 
## @param items: Array
##
## @return Array
## 
static func values(items: Array, key: String) -> Array:
	var values = []

	for item in items:
		if item.has(key) and not values.has(item[key]):
			values.append(item[key])

	return values
