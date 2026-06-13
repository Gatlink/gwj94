class_name Character
extends CharacterBody3D


@export var state: CharacterState
@export var dummy: CharacterDummy


@onready var graph: Node3D = $Graph


func _ready() -> void:
	state.enter()
