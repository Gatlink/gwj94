class_name UpgradeButton
extends Button


@export var upgrade: Upgrade


@onready var label_price: Label = $Price


func refresh() -> void:
	icon = upgrade.icon
	if Game.is_locked(upgrade):
		var has_money := Game.money >= upgrade.price
		disabled = not has_money
		label_price.text = "$%d" % upgrade.price
		label_price.self_modulate = Color.DARK_RED if not has_money else Color.WHITE
	else:
		disabled = true
		label_price.text = "SOLD OUT"
		label_price.self_modulate = Color.WHITE


func _on_pressed() -> void:
	Game.buy_upgrade(upgrade)
