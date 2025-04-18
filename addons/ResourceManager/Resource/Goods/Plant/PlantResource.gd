## 
## PlantResource
## Oyunda yer alan şifalı bitkiler, sebzeler 
## ve meyveler için ortak veri girdileri
## 
class_name PlantResource
extends Goods

## bitkinin yetiştiği atmosfer türü
enum Atmosphere { 
	## Düşük nem ve büyük sıcaklık farklarına sahip ince tabakalı atmosfer türü. 
	## Örneğin; Mars benzeri kuru gezegenler.
	## Su tutabilen ve sert ortamlara uyum sağlayan bitkiler yetişir.
	ARID, 

	## Yüksek basınç, zayıf ışık geçirgenliği ve kalın tabakalı atmosfer.
	## Örneğin; Venüs benzeri yoğun gaz örtüsüne sahip gezegenler.
	## Düşük ışıkta fotosentez yapabilen ve karbondioksite dayanıklı bitkiler yetişir.
	DENSE, 

	## Aşırı soğuk, düşük basınç, sürekli buz ve donmuş gazlara sahip atmosfer.
	## Örneğin; Plüton, Enceladus, Europa.
	## Antifriz benzeri bileşikler üretebilen ve donmaya dayanıklı bitkiler yetişir.
	FROZEN,

	## Yüksek radyasyon seviyesine sahip atmosfer. 
	## Örneğin; Çıplak kayalık gezegenler, Jüpiter’in uydularının bazıları. 
	## Radyasyona dayanıklı özel pigmentli bitkiler yetişir.
	RADIATED,

	## Düşük basınç ve oksijen seviyesi, rüzgar erozyonu yüksek atmosfer.
	## Örneğin; Mars, Ay’ın bazı bölgeleri.
	## Yavaş büyüyen, düşük oksijenle yaşayabilen bitkiler yetişir.
	THIN,

	## Sülfür, amonyak ve diğer zehirli gazlar içeren aşındırıcı atmosfer.
	## Örneğin; Venüs'ün üst katmanları, Io’nun volkanik bölgeleri.
	## Aşındırıcı ortamlara dayanıklı ve aside dirençli bitkiler yetişir.
	TOXIC,

	## Sürekli yüksek sıcaklık, yoğun gaz çıkışı ve lav akıntılarına sahip atmosfer.
	## Örneğin; Io, süper-dünya’ların volkanik bölgeleri.
	## Sıcağa dayanıklı, mineral açısından zengin ortamlarda gelişebilen bitkiler yetişir.
	VOLCANIC,

	## Yüksek nem, yoğun bulut örtüsü ve sık yağışlı atmosfer.
	## Örneğin; Dünya’nın tropikal bölgeleri, Titan’ın metan gölleri.
	## Su emici ve büyük yapraklı bitkiler yetişir.
	WETLAND
}

enum Type {
	HERB, 
	VEGETABLE,
	FRUIT
}

## bitki adı
@export var name : String = "..."

## bitki açıklaması
@export_multiline var description: String = "..."

## bitkinin türü
@export var plant_type: Type = Type.HERB

## bitkinin yetiştiği atmosfer türü
@export var atmosphere_type: Atmosphere = Atmosphere.ARID

## yenilebilir mi?
@export var is_edible: bool = false

## tıbbi amaçla kullanılabilir mi?
@export var is_medicinal: bool = false

## zehirli mi?
@export var is_toxic: bool = false
