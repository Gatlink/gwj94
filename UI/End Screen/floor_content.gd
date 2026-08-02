class_name UIFloorContent
extends HBoxContainer


const FLOOR_CONTENT_ITEM := preload("uid://dhj5q0mqk1w1a")


@export var last_added: Control


func set_content(content: Array[String]) -> void:
	for item in content:
		var instance := FLOOR_CONTENT_ITEM.instantiate() as UIFloorContentItem
		last_added.add_sibling(instance)
		instance.set_content(item)
		last_added = instance
