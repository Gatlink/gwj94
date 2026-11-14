class_name PlayerBump
extends PlayerState


const DURATION := 0.1


var bump: Vector3
var _timer: float


func enter() -> void:
	super()
	_timer = DURATION


func _physics_process(delta: float) -> void:
	player.velocity = bump
	player.move_and_slide()
	
	_timer -= delta
	if _timer <= 0:
		player.stand.transition_to()
