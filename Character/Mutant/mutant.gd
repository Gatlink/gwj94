class_name Mutant
extends Character


@onready var range_shape: CollisionShape3D = $Range/RangeShape
@onready var idle: MutantIdle = $Idle
@onready var chase: MutantChase = $Chase
@onready var back_to_start: MutantBackToStart = $BackToStart
@onready var strike: MutantStrike = $Strike
@onready var hitbox: Area3D = $Hitbox


var player: PlayerCharacter


func _on_detection_body_entered(body: Node3D) -> void:
	if body == PlayerCharacter.instance:
		player = body


func _on_detection_body_exited(body: Node3D) -> void:
	if body == PlayerCharacter.instance:
		player = null


func is_player_in_range() -> bool:
	return player != null and not player.state is PlayerDie
