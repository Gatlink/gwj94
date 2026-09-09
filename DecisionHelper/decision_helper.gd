class_name DecisionHelper
extends RefCounted


var choices: Dictionary[Variant, float]


func _init(_choices: Array) -> void:
	for choice in _choices:
		choices[choice] = 0


func remove(method: Callable) -> void:
	for choice in choices.keys():
		if method.call(choice):
			choices.erase(choice)


func score(method: Callable) -> void:
	for choice in choices:
		choices[choice] += method.call(choice)


func get_best() -> Variant:
	if choices == null or choices.is_empty():
		return null
	
	var best: Variant = null
	for choice in choices:
		if best == null or choices[choice] > choices[best] or (choices[choice] == choices[best] and randf() >= 0.5):
			best = choice
	
	return best


func pop_best() -> Variant:
	var best = get_best()
	if best != null:
		choices.erase(best)
	return best
