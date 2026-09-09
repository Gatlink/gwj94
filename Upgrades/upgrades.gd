extends Node


signal unlocked(upgrade: Upgrade)


@export var all: Array[Upgrade]


var _unlocked: Dictionary[Upgrade, bool] = {}
var _available: Array[Upgrade] = []


func _ready() -> void:
	for upgrade in all:
		_unlocked[upgrade] = false


func by_id(id: String) -> Upgrade:
	for upgrade in all:
		if upgrade.resource_name == id:
			return upgrade
	
	printerr("UPGRADE: upgrade %s does not exist." % id)
	return null


func is_unlocked(upgrade: Upgrade) -> bool:
	return _unlocked[upgrade]


func is_unlocked_id(id: String) -> bool:
	var upgrade := by_id(id)
	return upgrade != null and _unlocked[upgrade]


func buy_upgrade(upgrade: Upgrade) -> void:
	if _unlocked[upgrade] or Game.money < upgrade.price:
		return
	
	_unlocked[upgrade] = true
	Game.money -= upgrade.price
	Game.register_history("%s%s" % [UIFloor.HISTORY_UPGRADE, upgrade.resource_name])
	
	unlocked.emit(upgrade)


func get_available_upgrades() -> Array[Upgrade]:
	var floor_data := Game.get_floor()
	var count := floor_data.available_upgrades if floor_data != null else Game.get_max_upgrade_count()
	var dh := DecisionHelper.new(all)
	dh.remove(_available.has)
	dh.remove(func (u: Upgrade) -> bool: return u.prerequisite != null and not _available.has(u.prerequisite))
	dh.score(func (u: Upgrade) -> float: return 2 if u.prerequisite != null and _available.has(u.prerequisite) else 0)
	dh.score(func (_u: Upgrade) -> float: return randi() % 5)
	
	for i in count - _available.size():
		var new_upgrade: Upgrade = dh.pop_best()
		if new_upgrade != null:
			_available.append(new_upgrade)
		else:
			break
	
	return _available
