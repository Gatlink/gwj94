extends Control


const UPGRADE_BUTTON := preload("uid://ne1n42v0s2u2")


@onready var upgrade_container: GridContainer = $MarginContainer/VBoxContainer/HBoxContainer/Upgrades/GridContainer
@onready var upgrade_info: UpgradeInfo = $MarginContainer/VBoxContainer/HBoxContainer/UpgradeInfo
@onready var label_floor: Label = $MarginContainer/VBoxContainer/Top/Infos/LabelFloor
@onready var label_money: Label = $MarginContainer/VBoxContainer/Top/Infos/LabelMoney
@onready var label_floor_lock_4: Label = $MarginContainer/VBoxContainer/HBoxContainer/FloorLocks/LabelFloorLock4
@onready var label_floor_lock_7: Label = $MarginContainer/VBoxContainer/HBoxContainer/FloorLocks/LabelFloorLock7
@onready var life_bar: LifeBar = $MarginContainer/VBoxContainer/HBoxContainer2/HealingPanel/HBoxContainer/LifeBar
@onready var heal_button: Button = $MarginContainer/VBoxContainer/HBoxContainer2/HealingPanel/HBoxContainer/HBoxContainer/HealButton


var buttons: Array[UpgradeButton] = []


func _ready() -> void:
	Upgrades.unlocked.connect(on_upgrade_bought)
	
	refresh_money()
	
	var floor_8 := Game.level.floors.find_custom(func (f: FloorData) -> bool: return f.available_upgrades >= 8)
	var floor_12 := Game.level.floors.find_custom(func (f: FloorData) -> bool: return f.available_upgrades >= 12)
	label_floor.text = "Floor %d" % Game.floor_nbr
	label_floor_lock_4.visible = Game.floor_nbr <= floor_8
	label_floor_lock_7.visible = Game.floor_nbr <= floor_12
	
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
	
	refresh_health()


func _exit_tree() -> void:
	Game.floor_nbr += 1
	Upgrades.unlocked.disconnect(on_upgrade_bought)


func _on_heal_button_pressed() -> void:
	Game.heal()
	refresh()


func on_upgrade_bought(upgrade: Upgrade) -> void:
	upgrade_info.refresh(upgrade)
	refresh()


func on_upgrade_pressed(button: UpgradeButton) -> void:
	button.grab_focus()


func refresh() -> void:
	refresh_money()
	refresh_health()
	refresh_ugprades()


func refresh_money() -> void:
	label_money.text = "$%d" % Game.money


func refresh_ugprades() -> void:
	for button in buttons:
		button.refresh(button.upgrade)


func refresh_health() -> void:
	life_bar.refresh(Game.current_health, Game.max_health)
	heal_button.disabled = Game.money < Game.heal_price or Game.current_health >= Game.max_health
	heal_button.text = "$%d" % Game.heal_price
