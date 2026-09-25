class_name AmmoBar
extends HBoxContainer


func refresh(weapon: WeaponBase) -> void:
	for child in get_children():
		child.queue_free()
	
	for i in weapon.ammo_max:
		var pip := TextureRect.new()
		add_child(pip)
		pip.texture = weapon.ammo_pip
		pip.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		pip.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		pip.self_modulate.a = 1.0 if i < weapon.ammo else 0.25
