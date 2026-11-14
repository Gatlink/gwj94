class_name PlayerHideShell
extends PlayerHide


const DURATION: float = 5.0
const REFILL_DURATION: float = 8.0
const MOVE_FACTOR: float = 0.25


var _timer: float = DURATION
var _refill_tween: Tween


func enter() -> void:
	super()
	AboveHeadUI.show_element(AboveHeadUI.UIElement.SHELL)
	if _refill_tween != null and _refill_tween.is_running():
		_refill_tween.kill()


func exit() -> void:
	super()
	var tween_duration: float = REFILL_DURATION * (1 - get_timer_ratio())
	_refill_tween = create_tween()
	_refill_tween.tween_property(self, "_timer", DURATION, tween_duration)
	_refill_tween.tween_callback(AboveHeadUI.hide_element.bind(AboveHeadUI.UIElement.SHELL))


func _process(delta: float) -> void:
	_timer -= delta
	if _timer <= 0:
		player.stand.transition_to()


func _physics_process(_delta: float) -> void:
	if Upgrades.is_unlocked_id("SHELL_MOVE"):
		player.move(MOVE_FACTOR, true)


func get_timer_ratio() -> float:
	return _timer / DURATION


func emergency_refill() -> void:
	_timer = maxf(_timer, DURATION * 0.5)
