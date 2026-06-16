class_name UpgradeUI
extends VBoxContainer


@export var upgrade: Upgrade


@onready var upgrade_button: Button = $UpgradeButton
@onready var name_and_price: HBoxContainer = $NameAndPrice
@onready var label_name: Label = $NameAndPrice/Name
@onready var label_price: Label = $NameAndPrice/Price
@onready var label_sold_out: Label = $SoldOut


func refresh() -> void:
	upgrade_button.icon = upgrade.icon
	if Game.is_locked(upgrade):
		var has_money := Game.money >= upgrade.price
		upgrade_button.disabled = not has_money
		name_and_price.show()
		label_name.text = upgrade.name
		label_price.text = "$%d" % upgrade.price
		label_price.self_modulate = Color.DARK_RED if not has_money else Color.WHITE
		label_sold_out.hide()
	else:
		upgrade_button.disabled = true
		name_and_price.hide()
		label_sold_out.show()
