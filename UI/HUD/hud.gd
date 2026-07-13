class_name HUD
extends MarginContainer


const OBJECTIVE_PIP = preload("uid://c5vsegkieh7hc")


static var instance: HUD


@onready var floor_number: Label = $Top/FloorNumber
@onready var lift_label: Label = $Top/LiftLabel
@onready var top: HBoxContainer = $Top
@onready var money: Label = $Top/Money


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
