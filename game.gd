extends Node


const TITLE_SCREEN := "res://UI/Menu/Menu.tscn"
const LEVEL_SCREEN := "res://UI/Level Select/level_select.tscn"
const END_SCREEN := "res://UI/End Screen/end_screen.tscn"
const SHOP_SCREEN := "res://UI/Shop/upgrade_screen.tscn"
const SECONDARY_OBJ_COUNT := 2
const HEAL_PRICE_BASE := 15


var level: LevelData
var floor_nbr: int = 1
var money: int = 0
var floor_history: Dictionary[int, PackedStringArray] = {}
var start_time: float
var victory := true
# HEALTH
var heal_price: int = HEAL_PRICE_BASE
var current_health: int = max_health
var max_health: int:
	get():
		return 3


func reset() -> void:
	floor_history.clear()
	floor_nbr = 1
	money = 0
	victory = true
	current_health = max_health
	heal_price = HEAL_PRICE_BASE


func start_level(new_level: LevelData) -> void:
	# No reset for debug purposes
	level = new_level
	start_time = Time.get_ticks_msec()
	get_tree().change_scene_to_packed(level.scene)


func get_floor() -> FloorData:
	return level.floors[floor_nbr - 1] if level != null else null


func get_max_upgrade_count() -> int:
	return level.floors.back().available_upgrades if level != null else 12


func change_floor() -> void:
	if floor_nbr >= level.floors.size():
		get_tree().change_scene_to_file("res://UI/End Screen/end_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://UI/Shop/shop.tscn")


func get_mutant_count() -> int:
	return get_floor().mutant_count


func get_hideout_count() -> int:
	return get_floor().hideout_count


func register_history(content: String) -> void:
	if not floor_history.has(floor_nbr):
		floor_history[floor_nbr] = PackedStringArray()
	floor_history[floor_nbr].append(content)


func heal() -> void:
	if current_health >= max_health or money < heal_price:
		return
	
	current_health += 1
	money -= heal_price
	heal_price += HEAL_PRICE_BASE
