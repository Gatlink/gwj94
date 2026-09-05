extends Control


const UPGRADES: Array[Upgrade] = [
	preload("res://Upgrades/life.tres"),
	preload("res://Upgrades/light.tres"),
	preload("res://Upgrades/shell.tres"),
	preload("res://Upgrades/shotgun.tres"),
	preload("res://Upgrades/speed.tres")
]
const LOCK_LEVELS := [0, 4, 7]


@onready var upgrade_buttons: Array[UpgradeButton] = [
	$MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer/Upgrade1,
	$MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer/Upgrade2,
	$MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer/Upgrade3,
	$MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer/Upgrade4,
	$MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer/Upgrade5,
	$MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer/Upgrade6,
	$MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer/Upgrade7,
	$MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer/Upgrade8,
	$MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer/Upgrade9,
	$MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer/Upgrade10,
	$MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer/Upgrade11,
	$MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer/Upgrade12
]
@onready var upgrade_info: UpgradeInfo = $MarginContainer/VBoxContainer/HBoxContainer/UpgradeInfo
@onready var label_floor: Label = $MarginContainer/VBoxContainer/Top/Infos/LabelFloor
@onready var label_money: Label = $MarginContainer/VBoxContainer/Top/Infos/LabelMoney
@onready var label_floor_lock_4: Label = $MarginContainer/VBoxContainer/HBoxContainer/FloorLocks/LabelFloorLock4
@onready var label_floor_lock_7: Label = $MarginContainer/VBoxContainer/HBoxContainer/FloorLocks/LabelFloorLock7



func _ready() -> void:
	Game.upgrade_bought.connect(on_upgrade_bought)
	
	refresh_money()
	label_floor.text = "Floor %d" % Game.floor_nbr
	label_floor_lock_4.visible = Game.floor_nbr < LOCK_LEVELS[1]
	label_floor_lock_7.visible = Game.floor_nbr < LOCK_LEVELS[2]
	
	var upgrades := UPGRADES.duplicate()
	for i in upgrade_buttons.size():
		var button := upgrade_buttons[i]
		var upgrade: Upgrade = null if upgrades.is_empty() else upgrades.pick_random()
		if upgrade != null:
			upgrades.erase(upgrade)
		
		var lock_level := floori(i / 4.0)
		button.refresh(upgrade, LOCK_LEVELS[lock_level])
		button.pressed.connect(on_upgrade_pressed.bind(button))
		button.focus_entered.connect(upgrade_info.refresh.bind(upgrade))
	
	on_upgrade_pressed(upgrade_buttons[0])


func _exit_tree() -> void:
	Game.upgrade_bought.disconnect(on_upgrade_bought)


func on_upgrade_bought(upgrade: Upgrade) -> void:
	refresh_money()
	upgrade_info.refresh(upgrade)
	
	for button in upgrade_buttons:
		button.refresh(button.upgrade, button.unlock_floor)


func on_upgrade_pressed(button: UpgradeButton) -> void:
	button.grab_focus()


func refresh_money() -> void:
	label_money.text = "$%d" % Game.money
