class_name Lift
extends Interactable


static var instance: Lift


@onready var character_mark: Marker3D = $CharacterMark
@onready var animation: AnimationPlayer = $AnimationPlayer


var is_unlocked: bool


func _ready() -> void:
	instance = self
	Fade.fade_in()


func _exit_tree() -> void:
	instance = null


func interact() -> void:
	is_unlocked = false
	AboveHeadUI.hide_all()
	PlayerCharacter.instance.move_to.transition_to(character_mark.global_position)
	
	await PlayerCharacter.instance.move_to.target_reached
	
	PlayerCharacter.instance.no_input.transition_to()
	PlayerCharacter.instance.hide()
	animation.play("go")
	Fade.fade_out()
	
	await animation.animation_finished
	
	Game.change_floor()


func can_interact() -> bool:
	return is_unlocked


func spawn_character() -> void:
	PlayerCharacter.instance.show()
	PlayerCharacter.instance.stand.transition_to()
