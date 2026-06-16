class_name PlayerCharacter
extends Character


const SPEED := 5.0
const SPEED_BOOSTED := SPEED * 1.2
const LIGHT_RANGE_BONUS := 2.0


static var instance: PlayerCharacter


@onready var input_prompt: InputPrompt = $InputPrompt
@onready var collision: CollisionShape3D = $PhysicsCollision
@onready var hitbox: CollisionShape3D = $HitBox/CollisionShape3D
@onready var light: OmniLight3D = $Graph/Light
@onready var shoot_ray: RayCast3D = $ShootRay
@onready var no_input: PlayerNoInput = $NoInput
@onready var stand: PlayerStand = $Stand
@onready var move_to: PlayerMoveTo = $MoveTo
@onready var hide_state: PlayerHide = $Hide
@onready var die: PlayerDie = $Die
@onready var shoot: PlayerShoot = $Shoot


var was_hit: bool


func _ready() -> void:
	instance = self
	if not Game.is_locked(Game.UPGRADES.LIGHT):
		light.omni_range += LIGHT_RANGE_BONUS
	
	super()


func _exit_tree() -> void:
	instance = null


func get_speed() -> float:
	return SPEED_BOOSTED if not Game.is_locked(Game.UPGRADES.SPEED) else SPEED


func hurt() -> void:
	if not Game.is_locked(Game.UPGRADES.LIFE) and not was_hit:
		was_hit = true
		hide_state.transition_to()
	else:
		die.transition_to()
