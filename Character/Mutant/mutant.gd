class_name Mutant
extends Character


const DETECTION_ANGLE: float = deg_to_rad(120)
const DETECTION_RANGE: float = 7.0
const TURN_SPEED: float = 0.1


static var all: Array[Mutant] = []


var has_target: bool
var target_pos: Vector3
var current_speed: float
var stun_immunity: float


@onready var range_shape: CollisionShape3D = $Range/RangeShape
@onready var hitbox: DamageSource = $Hitbox
@onready var navigation: NavigationAgent3D = $NavigationAgent3D
@onready var detection_ray: RayCast3D = $DetectionRay
@onready var question_animation: AnimationPlayer = $QuestionMark/AnimationPlayer
@onready var sfx_low_growl: AudioStreamPlayer3D = $LowGrowl
@onready var sfx_big_growl: AudioStreamPlayer3D = $BigGrowl
@onready var fx_stun: Node3D = $FXStun

#region States
@onready var idle: MutantIdle = $Idle
@onready var chase: MutantChase = $Chase
@onready var strike: MutantStrike = $Strike
@onready var stunned: MutantStunned = $Stunned
#endregion


func _ready() -> void:
	super()
	all.append(self)


func _exit_tree() -> void:
	all.erase(self)


func _process(delta: float) -> void:
	look_toward(velocity)
	
	if stun_immunity > 0:
		stun_immunity -= delta


func _physics_process(_delta: float) -> void:
	update_target()
	
	if not navigation.is_navigation_finished():
		var next_pos := navigation.get_next_path_position()
		var next_dir := global_position.direction_to(next_pos)
		next_dir = velocity.normalized().lerp(next_dir, TURN_SPEED).normalized()
		velocity = next_dir * current_speed
		move_and_slide()


func update_target() -> void:
	has_target = false
	
	# Is the player hidden
	if PlayerCharacter.instance.is_hidden():
		return
	
	# Is the player not in the same room or in an adjacent connected room
	var player_room := PlayerCharacter.instance.room_idx
	if room_idx != player_room and not Level.current.are_neighbors(player_room, room_idx, true):
		return
	
	# Is the mutant not facing the player
	var player_pos := PlayerCharacter.instance.global_position
	if not _is_in_front(player_pos):
		return
	
	# Is the player too far away
	if global_position.distance_squared_to(player_pos) > DETECTION_RANGE ** 2:
		return
	
	# Is there a wall between the mutant and the player
	if room_idx != player_room:
		detection_ray.target_position = player_pos - global_position
		detection_ray.force_raycast_update()
		if detection_ray.is_colliding():
			return
	
	has_target = true
	target_pos = player_pos


func display_question() -> void:
	question_animation.stop()
	question_animation.play("show")


func can_be_stunned() -> bool:
	return stun_immunity <= 0


func _is_in_front(pos: Vector3) -> bool:
	return absf(forward.angle_to(pos - global_position)) <= DETECTION_ANGLE * 0.5
