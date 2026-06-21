extends Interactable


@export var money_gain := 20


@onready var graph: PopulateOnReady = $Graph


func on_interact() -> void:
	Lift.instance.is_unlocked = true
	Game.money += money_gain
	HUD.refresh_objective()
	player.input_prompt.hide()
	player.sfx_objective.play()
	queue_free()
