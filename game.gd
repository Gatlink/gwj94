extends Node


const UPGRADES: Dictionary[String, Upgrade] = {
	"LIGHT": preload("uid://c63etlsq14cgm"),
	"SPEED": preload("uid://boecofonuw238"),
	"SHELL": preload("uid://cikwl46xtjaeb"),
	"LIFE": preload("uid://bfd83idhg0svd"),
	"SHOTGUN": preload("uid://w6t5d17d0rwm")
}


var money: int = 0
var unlocked_upgrades: Array[Upgrade] = []


func is_locked(upgrade: Upgrade) -> bool:
	return not unlocked_upgrades.has(upgrade)


func buy_upgrade(upgrade: Upgrade) -> void:
	if is_locked(upgrade) and money >= upgrade.price:
		money -= upgrade.price
		unlocked_upgrades.append(upgrade)


func reset() -> void:
	money = 0
	unlocked_upgrades.clear()
