class_name DecisionHelper
extends RefCounted


var choices: Array
var scores: Array[float]


func _init(_choices: Array) -> void:
	choices = _choices
	scores.resize(choices.size())
	scores.fill(0)


func remove(method: Callable) -> void:
	for i in range(choices.size(), 0, -1):
		if method.call(choices[i - 1]):
			choices.remove_at(i - 1)
			scores.remove_at(i - 1)


func score(method: Callable) -> void:
	for i in choices.size():
		scores[i] += method.call(choices[i])


func get_best() -> Variant:
	if choices == null or choices.is_empty():
		return null
	
	var best: Variant = choices[0]
	var best_score := scores[0]
	for i in range(1, choices.size()):
		if scores[i] > best_score or (scores[i] == best_score and randf() >= 0.5):
			best = choices[i]
			best_score = scores[i]
	
	return best
