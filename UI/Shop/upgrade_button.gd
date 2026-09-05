class_name UpgradeButton
extends Button


const ICON_LOCKED := preload("uid://dpj6pt2vdvkf7")


@onready var texture_icon: TextureRect = $MarginContainer/Icon
@onready var label_price: Label = $MarginContainer/Price


var upgrade: Upgrade
var unlock_floor: int


func refresh(_upgrade: Upgrade, _unlock_floor: int) -> void:
	upgrade = _upgrade
	unlock_floor = _unlock_floor
	if unlock_floor > Game.floor_nbr or upgrade == null:
		disabled = true
		texture_icon.texture = ICON_LOCKED
		texture_icon.self_modulate.a = 1.0
		label_price.hide()
		focus_mode = Control.FOCUS_NONE
		focus_behavior_recursive = Control.FOCUS_BEHAVIOR_DISABLED
		return
	
	var is_locked := Game.is_locked(upgrade)
	var has_money := upgrade.price <= Game.money
	disabled = false
	texture_icon.texture = upgrade.icon
	texture_icon.self_modulate.a = 0.5 if not has_money or not is_locked else 1.0
	label_price.text = "SOLD" if not is_locked else "$%d" % upgrade.price
	label_price.self_modulate = Color.DARK_RED if not has_money and is_locked else Color.WHITE
	label_price.show()
	focus_mode = Control.FOCUS_ALL
	focus_behavior_recursive = Control.FOCUS_BEHAVIOR_INHERITED
