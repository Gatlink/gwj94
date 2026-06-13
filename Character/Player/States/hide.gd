class_name PlayerHide
extends PlayerState


func enter() -> void:
	super()
	player.collision.disabled = true


func exit() -> void:
	player.collision.disabled = false
