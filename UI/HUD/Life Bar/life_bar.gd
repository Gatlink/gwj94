class_name LifeBar
extends HBoxContainer


const LIFE_PIP := preload("uid://dl73ch8xt7tp4")


func refresh(hp_current: int, hp_max: int) -> void:
	for child in get_children():
		child.queue_free()
	
	for i in hp_max:
		var instance := LIFE_PIP.instantiate() as LifePip
		add_child(instance)
		instance.full = i < hp_current
