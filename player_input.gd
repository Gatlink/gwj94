extends Node


const GROUND_LAYER := 1


@onready var viewport: Viewport = get_viewport()


var camera: Camera3D
var move_dir: Vector3
var look_dir: Vector3
var mouse_pos: Vector3
var use_kb_mouse: bool = false


func _process(_delta: float) -> void:
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	move_dir = Vector3(input_dir.x, 0, input_dir.y)
	
	look_dir = Vector3.ZERO
	if use_kb_mouse:
		if update_mouse_pos():
			look_dir = (mouse_pos - (camera.get_parent() as Node3D).global_position).normalized()
	elif input_dir:
		input_dir = Input.get_vector("look_left", "look_right", "look_forward", "look_back")
		look_dir = Vector3(input_dir.x, 0, input_dir.y)
		use_kb_mouse = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion \
	or event is InputEventMouseButton \
	or event is InputEventKey:
		use_kb_mouse = true
	elif event is InputEventJoypadButton \
	or event is InputEventJoypadMotion:
		use_kb_mouse = false
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if use_kb_mouse else Input.MOUSE_MODE_HIDDEN


func update_mouse_pos() -> bool:
	if not is_instance_valid(camera):
		camera = viewport.get_camera_3d()
		if not is_instance_valid(camera):
			return false
	
	var mouse_position := viewport.get_mouse_position()
	var origin := camera.project_ray_origin(mouse_position)
	var normal := camera.project_ray_normal(mouse_position)
	var end := origin + normal * camera.far
	var space_state := camera.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, end, GROUND_LAYER)
	var result := space_state.intersect_ray(query)
	if not result.is_empty():
		mouse_pos = result.position
		return true
	
	return false


func reset() -> void:
	move_dir = Vector3.ZERO
	look_dir = Vector3.ZERO
