class_name LifePip
extends TextureRect


const TEXTURE_FULL := preload("uid://ciwbpahqw5xhs")
const TEXTURE_NOT_FULL := preload("uid://d2nbapiruwt81")
const COLOR_FULL := Color("ff7f2a")
const COLOR_NOT_FULL := Color("666666")


var full: bool:
	set(value):
		full = value
		texture = TEXTURE_FULL if value else TEXTURE_NOT_FULL
		modulate = COLOR_FULL if value else COLOR_NOT_FULL
