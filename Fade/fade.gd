extends ColorRect


@onready var animation: AnimationPlayer = $AnimationPlayer


func fade_in() -> void:
	animation.play("fade_in")


func fade_out() -> void:
	animation.play("fade_out")
