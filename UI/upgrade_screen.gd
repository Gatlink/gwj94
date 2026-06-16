extends Control


const UPGRADE_UI = preload("uid://ne1n42v0s2u2")


@onready var money_left: Label = $VBoxContainer/HBoxContainer/MoneyLeft
@onready var upgrades_grid: GridContainer = $VBoxContainer/UpgradesGrid


var upgrade_buttons: Array[UpgradeUI] = []


func _ready() -> void:
	for upgrade in Game.UPGRADES.values():
		var upgrade_ui := UPGRADE_UI.instantiate() as UpgradeUI
		upgrades_grid.add_child(upgrade_ui)
		upgrade_ui.upgrade = upgrade
		upgrade_ui.upgrade_button.pressed.connect(on_upgrade_pressed.bind(upgrade))
		upgrade_buttons.append(upgrade_ui)
	
	refresh()



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func refresh() -> void:
	money_left.text = "$%d" % Game.money
	for upgrade in upgrade_buttons:
		upgrade.refresh()


func on_upgrade_pressed(upgrade: Upgrade) -> void:
	Game.buy_upgrade(upgrade)
	refresh()
