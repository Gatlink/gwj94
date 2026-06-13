class_name PlayerCharacter
extends Character


static var instance: PlayerCharacter


@onready var input_prompt: InputPrompt = $InputPrompt
@onready var no_input: CharacterNoInput = $NoInput
@onready var stand: CharacterStand = $Stand
@onready var move_to: CharacterMoveTo = $MoveTo


func _ready() -> void:
	instance = self
	super()


func _exit_tree() -> void:
	instance = null
