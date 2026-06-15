class_name Mutant
extends Character


@onready var range_shape: CollisionShape3D = $Range/RangeShape
@onready var hitbox: Area3D = $Hitbox
@onready var navigation: NavigationAgent3D = $NavigationAgent3D
@onready var idle: MutantIdle = $Idle
@onready var chase: MutantChase = $Chase
@onready var back_to_start: MutantBackToStart = $BackToStart
@onready var strike: MutantStrike = $Strike


var player: PlayerCharacter
var current_speed: float


func _process(_delta: float) -> void:
	if velocity:
		graph.look_at(global_position + velocity.normalized())


func _physics_process(_delta: float) -> void:
	if navigation.is_navigation_finished():
		return
	
	velocity = global_position.direction_to(navigation.get_next_path_position()) * current_speed
	move_and_slide()


func _on_detection_body_entered(body: Node3D) -> void:
	if body == PlayerCharacter.instance:
		player = body


func _on_detection_body_exited(body: Node3D) -> void:
	if body == PlayerCharacter.instance:
		player = null


func is_player_in_range() -> bool:
	return player != null and not player.state is PlayerDie
