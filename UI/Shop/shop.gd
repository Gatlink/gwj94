extends Control


const UPGRADE_BUTTON := preload("uid://ne1n42v0s2u2")


@onready var upgrade_container: GridContainer = $MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer
@onready var upgrade_info: UpgradeInfo = $MarginContainer/VBoxContainer/HBoxContainer/UpgradeInfo
@onready var label_floor: Label = $MarginContainer/VBoxContainer/Top/Infos/LabelFloor
@onready var label_money: Label = $MarginContainer/VBoxContainer/Top/Infos/LabelMoney
@onready var label_floor_lock_4: Label = $MarginContainer/VBoxContainer/HBoxContainer/FloorLocks/LabelFloorLock4
@onready var label_floor_lock_7: Label = $MarginContainer/VBoxContainer/HBoxContainer/FloorLocks/LabelFloorLock7


var buttons: Array[UpgradeButton] = []


func _ready() -> void:
	Upgrades.unlocked.connect(on_upgrade_bought)
	
	refresh_money()
	label_floor.text = "Floor %d" % Game.floor_nbr
	#label_floor_lock_4.visible = Game.floor_nbr < LOCK_LEVELS[1]
	#label_floor_lock_7.visible = Game.floor_nbr < LOCK_LEVELS[2]
	
	for upgrade in Upgrades.get_available_upgrades():
		var button: UpgradeButton = UPGRADE_BUTTON.instantiate()
		upgrade_container.add_child(button)
		button.refresh(upgrade)
		button.pressed.connect(on_upgrade_pressed.bind(button))
		button.focus_entered.connect(upgrade_info.refresh.bind(upgrade))
		buttons.append(button)
	
	for i in range(upgrade_container.get_child_count(), Game.get_max_upgrade_count()):
		var button: UpgradeButton = UPGRADE_BUTTON.instantiate()
		upgrade_container.add_child(button)
		button.refresh(null)
	
	if not buttons.is_empty():
		buttons[0].grab_focus()


func _exit_tree() -> void:
	Game.floor_nbr += 1
	Upgrades.unlocked.disconnect(on_upgrade_bought)


func on_upgrade_bought(upgrade: Upgrade) -> void:
	refresh_money()
	upgrade_info.refresh(upgrade)
	
	for button in buttons:
		button.refresh(button.upgrade)


func on_upgrade_pressed(button: UpgradeButton) -> void:
	button.grab_focus()


func refresh_money() -> void:
	label_money.text = "$%d" % Game.money
