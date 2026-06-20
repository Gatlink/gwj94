class_name HUD
extends MarginContainer


const OBJ_COLOR := Color.LIME_GREEN


static var instance: HUD


static func refresh_objective() -> void:
	if not is_instance_valid(instance):
		return
	
	instance.lift_label.show()
	instance.objective_pip.modulate = OBJ_COLOR
	(instance.objective_pip.texture as AtlasTexture).region.position.x = 512


@onready var floor_number: Label = $Top/FloorNumber
@onready var objective_pip: TextureRect = $Top/ObjectivePip
@onready var lift_label: Label = $Top/LiftLabel


func _ready() -> void:
	instance = self
	floor_number.text = str(Game.floor_nbr)
