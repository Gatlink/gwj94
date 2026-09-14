class_name UIFloorContentItem
extends TextureRect


const CONTENT_DEATH = preload("uid://df72uwa8p2eeg")
const CONTENT_MAIN_OBJECTIVE = preload("uid://3elj2myph30f")
const CONTENT_OBJECTIVE = preload("uid://dp1g8flhmrjmu")


@onready var texture_rect: TextureRect = $TextureRect


func set_content(content: String) -> void:
	if content == UIFloor.HISTORY_DEATH:
		texture_rect.texture = CONTENT_DEATH
	elif content == UIFloor.HISTORY_MAIN_OBJECTIVE:
		texture_rect.texture = CONTENT_MAIN_OBJECTIVE
	elif content == UIFloor.HISTORY_OBJECTIVE:
		texture_rect.texture = CONTENT_OBJECTIVE
	else:
		var upgrade := content.get_slice(":", 1)
		if Upgrades.is_unlocked_id(upgrade):
			texture_rect.texture = Upgrades.by_id(upgrade).icon
		else:
			queue_free()
