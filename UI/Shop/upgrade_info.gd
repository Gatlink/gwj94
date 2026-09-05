class_name UpgradeInfo
extends VBoxContainer


@onready var label_name: Label = $PanelContainer/VBoxContainer/LabelName
@onready var label_description: Label = $PanelContainer/VBoxContainer/LabelDescription
@onready var button_buy: Button = $PanelContainer/VBoxContainer/ButtonBuy


var upgrade: Upgrade


func refresh(_upgrade: Upgrade) -> void:
	upgrade = _upgrade
	
	var is_locked := Game.is_locked(upgrade)
	label_name.text = upgrade.name
	label_description.text = upgrade.description
	button_buy.text = "$%d" % upgrade.price if is_locked else "SOLD OUT"
	button_buy.disabled = Game.money < upgrade.price or not is_locked


func _on_button_buy_pressed() -> void:
	Game.buy_upgrade(upgrade)
	refresh(upgrade)
