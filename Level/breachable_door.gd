@tool
class_name BreachableDoor
extends DoorModel


var on_breached: Callable


@onready var health_manager: HealthManager = $HealthManager


func kill() -> void:
	on_breached.call()
	health_manager.queue_free()
