class_name PlayerCharacter
extends Character


static var instance: PlayerCharacter


@onready var input_prompt: InputPrompt = $InputPrompt
@onready var collision: CollisionShape3D = $PhysicsCollision
@onready var no_input: PlayerNoInput = $NoInput
@onready var stand: PlayerStand = $Stand
@onready var move_to: PlayerMoveTo = $MoveTo
@onready var hide_state: PlayerHide = $Hide
@onready var die: PlayerDie = $Die


func _ready() -> void:
	instance = self
	super()


func _exit_tree() -> void:
	instance = null
