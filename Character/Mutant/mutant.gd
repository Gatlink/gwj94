class_name Mutant
extends Character


const DETECTION_RANGE_MIN := 1.0
const DETECTION_DELAY := 0.2
const DETECTION_MASK := 0b0010
const TURN_SPEED := 0.2


static var all: Array[Mutant] = []


var has_target: bool
var target_pos: Vector3
var player: PlayerCharacter
var current_speed: float
var detection_timer: float
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


func _physics_process(delta: float) -> void:
	detection_timer -= delta
	if detection_timer <= 0:
		detection_timer = DETECTION_DELAY
		update_target_pos()
	
	if navigation.is_navigation_finished():
		return
	
	var next_pos := navigation.get_next_path_position()
	var next_dir := global_position.direction_to(next_pos)
	next_dir = velocity.normalized().lerp(next_dir, TURN_SPEED).normalized()
	velocity = next_dir * current_speed
	move_and_slide()


func _on_detection_body_entered(body: Node3D) -> void:
	if body == PlayerCharacter.instance:
		player = body


func _on_detection_body_exited(body: Node3D) -> void:
	if body == PlayerCharacter.instance:
		player = null


func force_target_pos(pos: Vector3, keep_duration: float) -> void:
	has_target = true
	target_pos = pos
	detection_timer = keep_duration


func update_target_pos() -> void:
	has_target = false
	if not is_instance_valid(player) or player.is_dead():
		return
	
	var to := (player.global_position - global_position) * Vector3(1.0, 0.0, 1.0)
	if (-global_basis.z).dot(to) <= 0:
		if to.length_squared() > DETECTION_RANGE_MIN * DETECTION_RANGE_MIN:
			return
		to = to.normalized() * DETECTION_RANGE_MIN
	
	detection_ray.enabled = true
	detection_ray.target_position = to
	detection_ray.force_raycast_update()
	if not detection_ray.is_colliding():
		has_target = true
		target_pos = player.global_position
	detection_ray.enabled = false


func display_question() -> void:
	question_animation.stop()
	question_animation.play("show")


func can_be_stunned() -> bool:
	return stun_immunity <= 0
