class_name PlayerBump
extends PlayerState


const DURATION := 0.1


var bump: Vector3
var timer: float


func enter() -> void:
	super()
	timer = 0


func _physics_process(delta: float) -> void:
	player.velocity = bump
	player.move_and_slide()
	
	timer += delta
	if timer >= DURATION:
		player.stand.transition_to()
