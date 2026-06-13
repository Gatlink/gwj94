class_name Character
extends CharacterBody3D


static var instance: Character


@onready var graph: Node3D = $Graph
@onready var input_prompt: Sprite3D = $InputPrompt
@onready var dummy: CharacterDummy = $Graph/CharacterDummy
@onready var no_input: CharacterNoInput = $NoInput
@onready var stand: CharacterStand = $Stand
@onready var move_to: CharacterMoveTo = $MoveTo
@onready var state: CharacterState = no_input


func _ready() -> void:
	instance = self
	state.enter()


func _exit_tree() -> void:
	instance = null
