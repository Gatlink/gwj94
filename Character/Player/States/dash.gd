class_name PlayerDash
extends PlayerBump


const DASH_DURATION: float = 0.15
const DASH_SPEED: float = 20.0
const DASH_COOLDOWN: float = 1.0


var _cooldown: float
var _cooldown_tween: Tween


func enter() -> void:
	super()
	_timer = DASH_DURATION
	
	var direction: Vector3 = PlayerInput.move_dir
	if direction.is_equal_approx(Vector3.ZERO):
		direction = -player.global_basis.z.normalized()
	bump = direction * DASH_SPEED
	player.look_toward(direction)
	player.health_manager.set_can_be_touched(false)
	player.dummy.walk(0)


func exit() -> void:
	super()
	player.health_manager.set_can_be_touched(true)
	AboveHeadUI.show_element(AboveHeadUI.UIElement.DASH)
	_cooldown = DASH_COOLDOWN
	_cooldown_tween = create_tween()
	_cooldown_tween.tween_property(self, "_cooldown", 0.0, DASH_COOLDOWN)
	_cooldown_tween.tween_callback(AboveHeadUI.hide_element.bind(AboveHeadUI.UIElement.DASH))
	_cooldown_tween.play()


func can_dash() -> bool:
	return _cooldown <= 0.0


func get_cooldown_ratio() -> float:
	return _cooldown / DASH_COOLDOWN
