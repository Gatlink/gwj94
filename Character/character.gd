extends CharacterBody3D


const SPEED := 5.0
const GROUND_LAYER := 1


@onready var graph: Node3D = $Graph
@onready var viewport: Viewport = get_viewport()


func _physics_process(_delta: float) -> void:
	# Movement
	if PlayerInput.move_dir:
		velocity.x = PlayerInput.move_dir.x * SPEED
		velocity.z = PlayerInput.move_dir.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# Look At
	if PlayerInput.look_dir:
		graph.look_at(global_position + PlayerInput.look_dir)
	elif PlayerInput.move_dir:
		graph.look_at(global_position + PlayerInput.move_dir)
