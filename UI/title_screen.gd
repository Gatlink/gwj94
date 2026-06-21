extends Control


@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer


func _input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventJoypadButton and event.is_pressed():
		animation.play("fade")
		audio.play()


func start() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
