## 
## Location
## 
class_name Location extends ResourceManager

enum Type {
	## askeri amaçlı mekanlar için
	Military,
	## bilimsel amaçlı araştırma tesisleri için
	Research,
	## madencilik amaçlı tesisler
	Mining,
	## ticaret amaçlı mekanlar
	Trade,
	## genel maksatlı, herhangi bir amaca
	## hizmet etmeyen yerler için
	General
}

enum Status {
	## işlevsel olarak faal olan 
	## mekan, yer veya tesisler
	Operational,
	## terkedilmiş veya hasarlı
	## mekan, yer veya tesisler
	Abandoned
}

enum Size {
	## küçük olan mekan, yer veya tesisler
	Small,
	## orta büyüklükte mekan, yer veya tesisler
	Medium,
	## büyük mekan, yer veya tesisler
	Large
}

## NAME
@export var name : String = "..."

## STATUS
@export var status:Status

## TYPE
@export var type:Type

## SIZE
@export var size:Size

## DESCRIPTION
@export_multiline var description: String = "..."
