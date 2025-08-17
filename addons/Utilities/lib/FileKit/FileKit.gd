##
## @class FileKit
##
class_name FileKit extends Utilities

## 
## @param file_path: String
## 
static func read(file_path: String):
	return FileAccess.open(file_path, FileAccess.READ)
	
## 
## @param file_path: String
## 
## @return bool
## 
static func has(file_path: String) -> bool:
	return FileAccess.file_exists(file_path)

## 
## @param file_path: String
##
static func write(file_path: String):
	return FileAccess.open(file_path, FileAccess.WRITE)

## 
## @param String path
## @param String directory_name
## 
static func makeDir(path: String, directory_name: String):
	var directory = DirAccess.open(path)
	if directory and not directory.dir_exists(directory_name):
		var directory_created = directory.make_dir(directory_name)
		if directory_created != OK:
			push_error(directory_name + " klasörü oluşturulamadı.")
			return
	else:
		print_rich(path+" dizini içinde daha önce "+directory_name+" isimli klasör oluşturulduğu için es geçildi.")
		return

## 
## @param file_path: String
## 
static func clear(path: String):
	var dir := DirAccess.open(path)
	if dir == null:
		push_error("Klasör açılamadı: " + path)
		return

	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		if file_name == "." or file_name == "..":
			continue
		var file_path = path + "/" + file_name
		
		if dir.current_is_dir():
			# Alt dizini de aynı şekilde temizle
			FileKit.clear(file_path)
			# Boş olan dizini kaldır
			if dir.remove(file_path) != OK:
				push_error("Klasör silinemedi: " + file_path)
		else:
			# Dosyayı sil
			if dir.remove(file_path) != OK:
				push_error("Dosya silinemedi: " + file_path)
	
	#print_rich("[color=green]"+path+" klasöründeki tüm dosyalar başarıyla silindi.[/color]")
	dir.list_dir_end()
