class_name Objective
extends Interactable


@export var money_gain := 5
@export var is_main: bool = false
@export var dont_register: bool


@onready var graph: PopulateOnReady = $Graph


func _ready() -> void:
	if is_main:
		priority = 5


func interact() -> void:
	Game.money += money_gain
	PlayerCharacter.instance.sfx_objective.play()
	HUD.instance.refresh_money()
	queue_free()
	
	if is_main:
		Lift.instance.is_unlocked = true
		HUD.instance.lift_label.show()
		Game.register_history(UIFloor.HISTORY_MAIN_OBJECTIVE)
	elif not dont_register:
		Game.register_history(UIFloor.HISTORY_OBJECTIVE)
