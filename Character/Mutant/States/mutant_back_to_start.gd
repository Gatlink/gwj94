class_name MutantBackToStart
extends MutantState


const SPEED := 2.0


var start_pos: Vector3


func _ready() -> void:
	super()
	start_pos = mutant.global_position


func enter() -> void:
	super()
	
	mutant.graph.look_at(start_pos)
	mutant.dummy.walk(SPEED)
	
	var duration := mutant.global_position.distance_to(start_pos) / SPEED
	var tween := create_tween()
	tween.tween_property(mutant, "global_position", start_pos, duration)
	tween.tween_callback(mutant.idle.transition_to)
	tween.play()
