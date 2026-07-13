class_name PlayerDie
extends PlayerState


const DURATION := 1.0


func enter() -> void:
	super()
	player.dummy.idle()
	
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(player.graph, "scale", Vector3(2.0, 0.1, 2.0), DURATION)
	tween.tween_callback(reload)
	tween.play()


func reload() -> void:
	Fade.fade_out()
	
	await Fade.animation.animation_finished
	
	Game.reset()
	get_tree().change_scene_to_file("res://UI/End Screen/end_screen.tscn")
