extends Node


const GROUND_LAYER := 1


@onready var viewport: Viewport = get_viewport()
@onready var camera := viewport.get_camera_3d()


var move_dir: Vector3
var look_dir: Vector3
var mouse_pos: Vector3
var use_mouse: bool = false


func _process(_delta: float) -> void:
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	move_dir = Vector3(input_dir.x, 0, input_dir.y)
	
	input_dir = Input.get_vector("look_left", "look_right", "look_forward", "look_back")
	look_dir = Vector3.ZERO
	if input_dir:
		look_dir = Vector3(input_dir.x, 0, input_dir.y)
		use_mouse = false
	elif use_mouse:
		update_mouse_pos()
		look_dir = (mouse_pos - (camera.get_parent() as Node3D).global_position).normalized()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		use_mouse = true


func update_mouse_pos() -> void:
	var mouse_position := viewport.get_mouse_position()
	var origin := camera.project_ray_origin(mouse_position)
	var normal := camera.project_ray_normal(mouse_position)
	var end := origin + normal * camera.far
	var space_state := camera.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, end, GROUND_LAYER)
	var result := space_state.intersect_ray(query)
	if not result.is_empty():
		mouse_pos = result.position
