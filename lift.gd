class_name Lift
extends Interactable


static var instance: Lift


var is_unlocked: bool


func _enter_tree() -> void:
	instance = self


func _exit_tree() -> void:
	instance = null


func on_interact() -> void:
	if is_unlocked:
		get_tree().reload_current_scene()


func _on_body_entered(body: Node3D) -> void:
	if not is_unlocked:
		return
	
	super(body)
