class_name Character
extends CharacterBody3D


@export var state: CharacterState
@export var dummy: CharacterDummy


@onready var health_manager: HealthManager = $HealthManager
@onready var graph: Node3D = $Graph


func _ready() -> void:
	state.enter()


func look_toward(direction: Vector3) -> void:
	var target := global_position + direction
	target.y = global_position.y
	if target != global_position:
		look_at(target)


func is_dead() -> bool:
	return health_manager.is_dead()
