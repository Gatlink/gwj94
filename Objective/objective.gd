extends Interactable


@export var money_gain := 20


@onready var graph: PopulateOnReady = $Graph
@onready var sfx: AudioStreamPlayer3D = $SFX


func on_interact() -> void:
	Lift.instance.is_unlocked = true
	Game.money += money_gain
	HUD.refresh_objective()
	sfx.play()
	player.input_prompt.hide()
	player = null
	graph.hide()
	
	await sfx.finished
	
	queue_free()
