class_name UIFloorContentItem
extends TextureRect


const CONTENT := {
	UIFloor.HISTORY_DEATH: preload("uid://df72uwa8p2eeg"),
	UIFloor.HISTORY_MAIN_OBJECTIVE: preload("uid://3elj2myph30f"),
	UIFloor.HISTORY_OBJECTIVE: preload("uid://dp1g8flhmrjmu"),
	UIFloor.HISTORY_HEAL: preload("uid://kms1te886y1o")
}


@onready var texture_rect: TextureRect = $TextureRect


func set_content(content: String) -> void:
	var content_texture: Texture2D = CONTENT.get(content)
	if content_texture != null:
		texture_rect.texture = content_texture
	else:
		var upgrade := content.get_slice(":", 1)
		if Upgrades.is_unlocked_id(upgrade):
			texture_rect.texture = Upgrades.by_id(upgrade).icon
		else:
			queue_free()
