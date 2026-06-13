class_name PlayerCharacter
extends Character


static var instance: PlayerCharacter


@onready var input_prompt: InputPrompt = $InputPrompt
@onready var no_input: PlayerNoInput = $NoInput
@onready var stand: PlayerStand = $Stand
@onready var move_to: PlayerMoveTo = $MoveTo
@onready var collision: CollisionShape3D = $PhysicsCollision


func _ready() -> void:
	instance = self
	super()


func _exit_tree() -> void:
	instance = null
