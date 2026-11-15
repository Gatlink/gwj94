class_name Character
extends CharacterBody3D


@export var state: CharacterState
@export var dummy: CharacterDummy


var room_idx: int:
	get():
		return Level.current.get_room_idx(global_position)
var forward: Vector3:
	get():
		return -global_basis.z


@onready var health_manager: HealthManager = $HealthManager
@onready var graph: Node3D = $Graph


func _ready() -> void:
	state.enter()


func look_toward(direction: Vector3) -> void:
	var target := global_position + direction
	target.y = global_position.y
	if not global_position.is_equal_approx(target):
		look_at(target)


func is_dead() -> bool:
	return health_manager.is_dead()
