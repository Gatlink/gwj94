extends Control


const UPGRADE_UI = preload("uid://ne1n42v0s2u2")
const START_ICON: Texture2D = preload("uid://004uaxy5dg0d")


@onready var money_left: Label = $VBoxContainer/HBoxContainer/MoneyLeft
@onready var upgrades_grid: GridContainer = $VBoxContainer/UpgradesGrid
@onready var button: Button = $VBoxContainer/Button


var upgrade_buttons: Array[UpgradeButton] = []


func _ready() -> void:
	var gave_focus: bool = PlayerInput.use_kb_mouse
	for child in upgrades_grid.get_children():
		var upgrade_button := child as UpgradeButton
		if upgrade_button == null:
			continue
		
		upgrade_buttons.append(upgrade_button)
		upgrade_button.pressed.connect(refresh)
		
		if not gave_focus:
			upgrade_button.grab_focus()
			gave_focus = true
	
	refresh()


func _process(_delta: float) -> void:
	if not PlayerInput.use_kb_mouse:
		button.icon = START_ICON
	else:
		button.icon = null


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func refresh() -> void:
	money_left.text = "$%d" % Game.money
	for upgrade in upgrade_buttons:
		upgrade.refresh()
