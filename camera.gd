class_name Camera
extends Camera3D


static var instance: Camera


static func shake(_duration: float, _intensity := 1.0) -> void:
	if is_instance_valid(instance):
		instance.start_shaking(_duration, _intensity)


var duration: float
var timer: float
var intensity: float


func _ready() -> void:
	instance = self


func _exit_tree() -> void:
	instance = null


func _process(delta: float) -> void:
	if timer <= 0:
		h_offset = 0
		v_offset = 0
		set_process(false)
		return
	
	timer -= delta
	var t := timer / duration
	var angle := randf() * 2 * PI
	h_offset = lerpf(h_offset, cos(angle) * intensity, t)
	v_offset = lerpf(v_offset, sin(angle) * intensity, t)


func start_shaking(_duration: float, _intensity: float) -> void:
	duration = _duration
	intensity = _intensity
	timer = duration
	set_process(true)
