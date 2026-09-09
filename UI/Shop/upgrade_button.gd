class_name UpgradeButton
extends Button


const ICON_LOCKED := preload("uid://dpj6pt2vdvkf7")


@onready var texture_icon: TextureRect = $MarginContainer/Icon
@onready var label_price: Label = $MarginContainer/Price


var upgrade: Upgrade


func refresh(_upgrade: Upgrade) -> void:
	upgrade = _upgrade
	if upgrade == null:
		disabled = true
		texture_icon.texture = ICON_LOCKED
		texture_icon.self_modulate.a = 1.0
		label_price.hide()
		focus_mode = Control.FOCUS_NONE
		focus_behavior_recursive = Control.FOCUS_BEHAVIOR_DISABLED
		return
	
	var is_unlocked := Upgrades.is_unlocked(upgrade)
	var has_money := upgrade.price <= Game.money
	disabled = false
	texture_icon.texture = upgrade.icon
	texture_icon.self_modulate.a = 0.5 if not has_money or is_unlocked else 1.0
	label_price.text = "SOLD" if is_unlocked else "$%d" % upgrade.price
	label_price.self_modulate = Color.DARK_RED if not has_money and not is_unlocked else Color.WHITE
	label_price.show()
	focus_mode = Control.FOCUS_ALL
	focus_behavior_recursive = Control.FOCUS_BEHAVIOR_INHERITED
