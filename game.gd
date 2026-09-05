extends Node


signal upgrade_bought(upgrade: Upgrade)


const TITLE_SCREEN := "res://UI/Menu/Menu.tscn"
const LEVEL_SCREEN := "res://UI/Level Select/level_select.tscn"
const END_SCREEN := "res://UI/End Screen/end_screen.tscn"
const SHOP_SCREEN := "res://UI/Shop/upgrade_screen.tscn"

const SECONDARY_OBJ_COUNT := 2
const UPGRADES: Dictionary[String, Upgrade] = {
	"LIGHT": preload("uid://c63etlsq14cgm"),
	"SPEED": preload("uid://boecofonuw238"),
	"SHELL": preload("uid://cikwl46xtjaeb"),
	"LIFE": preload("uid://bfd83idhg0svd"),
	"SHOTGUN": preload("uid://w6t5d17d0rwm")
}

const MUTANTS_PER_FLOOR: Array[int] = [1, 2, 2, 3, 3, 4, 4, 5, 6, 7, 10]
const HIDING_SPOTS_PER_FLOOR: Array[int] = [8, 8, 6, 6, 4, 4, 2, 2, 1, 0]


var level: LevelData
var floor_nbr: int = 1
var money: int = 0
var unlocked_upgrades: Array[Upgrade] = []
var floor_history: Dictionary[int, PackedStringArray] = {}
var start_time: float


func is_locked(upgrade: Upgrade) -> bool:
	return not unlocked_upgrades.has(upgrade)


func buy_upgrade(upgrade: Upgrade) -> void:
	if is_locked(upgrade) and money >= upgrade.price:
		money -= upgrade.price
		unlocked_upgrades.append(upgrade)
		upgrade_bought.emit(upgrade)
		register_history("%s%s" % [UIFloor.HISTORY_UPGRADE, UPGRADES.find_key(upgrade)])


func reset() -> void:
	floor_history.clear()
	floor_nbr = 1
	money = 0
	unlocked_upgrades.clear()


func change_floor() -> void:
	floor_nbr += 1
	if floor_nbr > level.floor_count:
		get_tree().change_scene_to_file("res://UI/End Screen/end_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://UI/Shop/shop.tscn")


func get_mutant_count() -> int:
	return MUTANTS_PER_FLOOR[mini(floor_nbr, MUTANTS_PER_FLOOR.size()) - 1]


func get_hiding_spots_count() -> int:
	return HIDING_SPOTS_PER_FLOOR[mini(floor_nbr, HIDING_SPOTS_PER_FLOOR.size()) - 1]


func register_history(content: String) -> void:
	if not floor_history.has(floor_nbr):
		floor_history[floor_nbr] = PackedStringArray()
	floor_history[floor_nbr].append(content)
