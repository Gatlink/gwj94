@abstract
class_name Interactable
extends Area3D


var player: PlayerCharacter


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player != null and not player.state is PlayerDie:
		on_interact()


func _on_body_entered(body: Node3D) -> void:
	var new_char = body as PlayerCharacter
	if new_char != null and not new_char.state is PlayerDie:
		player = new_char
		player.input_prompt.show()


func _on_body_exited(body: Node3D) -> void:
	var new_char = body as PlayerCharacter
	if new_char != null and player == new_char:
		player.input_prompt.hide()
		player = null


@abstract func on_interact() -> void
