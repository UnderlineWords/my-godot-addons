## 
## TODO: kaydetme ve yükleme işlemleri tamamlanacak
## 
class_name ResourceManager extends Resource

## 
## Oyuncuya ait bilgileri kaydetme işlemi
## 
## file: string (file_path + filename + extension)
## "user://data/characters/john.char" gibi..
## ResourceManager.saveFile(file)
##
func saveFile(file: String):
	ResourceSaver.save(self, file)

## 
## Oyuncuya ait bilgileri yükleme işlemi
## 
## file: string (file_path + filename + extension)
## "user://data/characters/john.char" gibi..
## ResourceManager.loadFile(file)
##
static func loadFile(file: String) -> ResourceManager:
	return ResourceLoader.load(file) as ResourceManager
