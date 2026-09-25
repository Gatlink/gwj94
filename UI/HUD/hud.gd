class_name HUD
extends MarginContainer


const OBJECTIVE_PIP = preload("uid://c5vsegkieh7hc")


static var instance: HUD


@onready var floor_number: Label = $Top/FloorNumber
@onready var lift_label: Label = $Top/LiftLabel
@onready var top: HBoxContainer = $Top
@onready var money: Label = $Top/Money
@onready var life_bar: LifeBar = $Top/LifeBar
@onready var ammo_bar: AmmoBar = $Top/AmmoBar


func _ready() -> void:
	instance = self
	floor_number.text = str(Game.floor_nbr)
	refresh_money()


func add_objective(objective: Objective) -> void:
	var obj_pip := OBJECTIVE_PIP.instantiate() as ObjectivePip
	top.add_child(obj_pip)
	obj_pip.objective = objective


func refresh_money() -> void:
	money.text = "$%d" % Game.money


func refresh_health(health: HealthManager) -> void:
	life_bar.refresh(health.current_hp, health.max_hp)
	health.health_changed.connect(life_bar.refresh)


func refresh_ammo(weapon: WeaponBase) -> void:
	if weapon == null:
		ammo_bar.hide()
	else:
		ammo_bar.refresh(weapon)
		ammo_bar.show()
