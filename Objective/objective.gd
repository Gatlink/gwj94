extends Interactable


func on_interact() -> void:
	queue_free()
	Lift.instance.is_unlocked = true
