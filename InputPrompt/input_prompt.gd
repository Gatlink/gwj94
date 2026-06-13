extends Sprite3D


const JOYPAD_COLOR := Color("549937")
const JOYPAD_TEXTURE = preload("uid://1jqfn24h1gr7")
const KEYBOARD_COLOR := Color("272727")
const KEYBOARD_TEXTURE = preload("uid://cmg4y7p1qgp4y")


func _process(_delta: float) -> void:
	modulate = KEYBOARD_COLOR if PlayerInput.use_kb_mouse else JOYPAD_COLOR
	texture = KEYBOARD_TEXTURE if PlayerInput.use_kb_mouse else JOYPAD_TEXTURE
