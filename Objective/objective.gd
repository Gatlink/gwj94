extends Interactable


@export var money_gain := 20


func on_interact() -> void:
	queue_free()
	Lift.instance.is_unlocked = true
	Game.money += money_gain
