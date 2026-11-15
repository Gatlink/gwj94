extends WeaponBase


const RELOAD_DURATION: float = 2.0
const RELOAD_COST: int = 10


func _unhandled_input(event: InputEvent) -> void:
	if ammo > 0 or not Upgrades.is_unlocked_id("SHOTGUN_RELOAD"):
		return
	
	var handled: bool = false
	if event.is_action_pressed("shoot") and Game.money >= RELOAD_COST:
		reload_duration = RELOAD_DURATION
		_start_reloading()
		handled = true
	elif event.is_action_released("shoot"):
		reload_duration = 0
		timer = 0
		AboveHeadUI.hide_element(AboveHeadUI.WEAPON)
		handled = true
	
	if handled:
		get_viewport().set_input_as_handled()


func _complete_reload() -> void:
	super()
	Game.money -= RELOAD_COST
	HUD.instance.refresh_money()
	reload_duration = 0
