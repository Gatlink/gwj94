class_name Mutant
extends Character


@onready var idle: MutantIdle = $Idle
@onready var chase: MutantChase = $Chase
@onready var back_to_start: MutantBackToStart = $BackToStart


var is_player_in_range: bool


func _on_detection_body_entered(body: Node3D) -> void:
	if body == PlayerCharacter.instance:
		is_player_in_range = true


func _on_detection_body_exited(body: Node3D) -> void:
	if body == PlayerCharacter.instance:
		is_player_in_range = false
