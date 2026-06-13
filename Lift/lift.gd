class_name Lift
extends Interactable


static var instance: Lift


@onready var character_mark: Marker3D = $CharacterMark
@onready var animation: AnimationPlayer = $AnimationPlayer


var is_unlocked: bool


func _ready() -> void:
	super()
	instance = self
	Fade.fade_in()


func _exit_tree() -> void:
	instance = null


func on_interact() -> void:
	is_unlocked = false
	Character.instance.move_to.transition_to(character_mark.global_position)
	
	await character.move_to.target_reached
	
	Character.instance.no_input.transition_to()
	Character.instance.hide()
	animation.play("go")
	Fade.fade_out()
	
	await animation.animation_finished
	
	get_tree().reload_current_scene()


func _on_body_entered(body: Node3D) -> void:
	if not is_unlocked:
		return
	
	super(body)


func spawn_character() -> void:
	Character.instance.show()
	Character.instance.stand.transition_to()
