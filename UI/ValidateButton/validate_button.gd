extends Button


@export var next_scene: PackedScene


@onready var button_icon: Texture2D = icon


func _process(_delta: float) -> void:
	icon = null if PlayerInput.use_kb_mouse else button_icon


func _on_pressed() -> void:
	get_tree().change_scene_to_packed(next_scene)
