##
##
##
class_name DirUtil extends Node

## 
## 
## 
static func clearDirectory(path: String):
	var dir := DirAccess.open(path)
	if dir == null:
		push_error("Klasör açılamadı: " + path)
		return

	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		if dir.current_is_dir():
			continue  # alt klasörleri es geçiyoruz
		var file_path = path + "/" + file_name
		var result = dir.remove(file_path)
		if result != OK:
			push_error("Silinemedi: " + file_path)
	
	print_rich("[color=green]"+path+" klasöründeki tüm dosyalar başarıyla silindi.[/color]")
	dir.list_dir_end()
