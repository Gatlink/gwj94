class_name Objective
extends Interactable


@export var money_gain := 5
@export var is_main: bool = false


@onready var graph: PopulateOnReady = $Graph


func on_interact() -> void:
	Game.money += money_gain
	player.input_prompt.hide()
	player.sfx_objective.play()
	HUD.instance.refresh_money()
	queue_free()
	
	if is_main:
		Lift.instance.is_unlocked = true
		HUD.instance.lift_label.show()
