## 
## 
## 
class_name ResourceManager extends Resource

## 
## Kaynak dosyalarına ait bilgileri
## tekli biçimde kaydetme işlemi
## 
## @param file : string
## @example ResourceManager.saveFile(file)
## 
func saveFile(file: String):
	ResourceSaver.save(self, file)

## 
## Kaynak dosyalarına ait bilgileri
## tekli biçimde yükleme işlemi
## 
## @param file : string
## @example ResourceManager.loadFile(file)
## @return ResourceManager
## 
static func loadFile(file: String) -> ResourceManager:
	return ResourceLoader.load(file) as ResourceManager

## 
## Belirli bir dizindeki tüm kaynakları
## (.tres dosyalarını) yükler
## 
## @param path : string
## @return Array
## 
func loadFiles(path: String) -> Array:
	var loaded_resources := []
	var dir := DirAccess.open(path)
	
	if not dir:
		push_error("Could not open directory: %s" % path)
		return loaded_resources
	
	dir.list_dir_begin()
	
	while true:
		var file_name := dir.get_next()
		if file_name == "":
			break
		if dir.current_is_dir():
			continue
		if file_name.ends_with(".tres"):
			var full_path := path + "/" + file_name
			var resource := ResourceLoader.load(full_path)
			if resource:
				loaded_resources.append(resource)
	
	dir.list_dir_end()
	return loaded_resources
