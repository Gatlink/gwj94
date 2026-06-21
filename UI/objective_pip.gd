class_name ObjectivePip
extends TextureRect


const TEXTURE_MAIN_OBJ := preload("uid://bsqg7s14yn787")
const COLOR_MAIN := Color.LIME_GREEN
const COLOR_SEC := Color.GOLDENROD


@onready var atlas := texture as AtlasTexture


var objective: Objective:
	set(value):
		objective = value
		objective.tree_exited.connect(on_objective_picked)
		if objective.is_main:
			(texture as AtlasTexture).atlas = TEXTURE_MAIN_OBJ


func _exit_tree() -> void:
	if is_instance_valid(objective):
		objective.tree_exited.disconnect(on_objective_picked)


func on_objective_picked() -> void:
	atlas.region.position.x += 512
	modulate = COLOR_MAIN if objective.is_main else COLOR_SEC
