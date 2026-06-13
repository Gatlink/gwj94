@abstract
class_name Interactable
extends Area3D


var character: Character


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and character != null:
		on_interact()


func _on_body_entered(body: Node3D) -> void:
	var new_char = body as Character
	if new_char != null:
		character = new_char
		character.input_prompt.show()


func _on_body_exited(body: Node3D) -> void:
	var new_char = body as Character
	if new_char != null and character == new_char:
		character.input_prompt.hide()


@abstract func on_interact() -> void
