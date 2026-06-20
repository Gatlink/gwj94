extends Node


const MAX_FLOOR: int = 10
const UPGRADES: Dictionary[String, Upgrade] = {
	"LIGHT": preload("uid://c63etlsq14cgm"),
	"SPEED": preload("uid://boecofonuw238"),
	"SHELL": preload("uid://cikwl46xtjaeb"),
	"LIFE": preload("uid://bfd83idhg0svd"),
	"SHOTGUN": preload("uid://w6t5d17d0rwm")
}

const MUTANTS_PER_FLOOR: Array[int] = [1, 2, 2, 3, 3, 3, 4, 4, 4, 6]


var floor_nbr: int = 1
var money: int = 0
var unlocked_upgrades: Array[Upgrade] = []


func is_locked(upgrade: Upgrade) -> bool:
	return not unlocked_upgrades.has(upgrade)


func buy_upgrade(upgrade: Upgrade) -> void:
	if is_locked(upgrade) and money >= upgrade.price:
		money -= upgrade.price
		unlocked_upgrades.append(upgrade)


func reset() -> void:
	floor_nbr = 1
	money = 0
	unlocked_upgrades.clear()


func change_floor() -> void:
	floor_nbr += 1
	get_tree().change_scene_to_file("res://UI/upgrade_screen.tscn")


func get_mutant_count() -> int:
	return MUTANTS_PER_FLOOR[floor_nbr - 1]
