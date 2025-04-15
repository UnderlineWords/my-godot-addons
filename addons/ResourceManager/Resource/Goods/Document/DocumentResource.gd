##
## DocumentResource
## Oyun yer alan tüm kitaplar, dergiler, belgeler,
## günlükler, sistem kayıtları vb. için ortak veri girdileri
## 
class_name DocumentResource
extends Goods

## doküman türü
enum DocType { 
	## bir kaşif veya gözlemcinin yazı veya hikayeleri
	JOURNAL,
	
	## Bilimsel ya da istihbarat raporları
	REPORT, 
	
	## Oyun içi karakterlerin kişisel hikayeleri/günlükleri
	DIARY,
	
	## Bir gemiye, istasyona veya cihaza ait sistem kayıtları
	LOGBOOK,
	
	## Okunduğunda karakterin xp seviyesini etkileyecek olan 
	## farklı beceri alanlarına ait eğitici dergiler
	MAGAZINE
}

## isim
@export var name: String

## yazar
@export var author : String

## tür
@export var doc_type: DocType = DocType.JOURNAL

## içerik
@export_multiline var content: String = "..."
