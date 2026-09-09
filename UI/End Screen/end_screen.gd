extends Control


const FLOOR = preload("uid://b0f437nyyx7kq")
const FLOOR_BOTTOM = preload("uid://3qu4oer0jgst")
const FLOOR_TOP = preload("uid://dx6vlfhr8quue")


@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var floors: VBoxContainer = $Control/Floors
@onready var label_time: Label = $Control/Stats/LabelTime
@onready var label_salary: Label = $Control/Stats/LabelSalary
@onready var title: Label = $Title


func _ready() -> void:
	if Game.victory:
		title.text = "Victory!"
	
	var duration := roundi((Time.get_ticks_msec() - Game.start_time) / 1000)
	label_time.text = "Duration: %02d:%02d" % [duration / 60.0, duration % 60]
	
	var salary := Game.money
	for upgrade in Upgrades.all.filter(Upgrades.is_unlocked):
		salary += upgrade.price
	label_salary.text = "Salary: $%d" % salary
	
	for i in range(Game.level.floors.size(), 0, -1):
		add_floor(i)


func _exit_tree() -> void:
	Game.reset()


func _input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventJoypadButton and event.is_pressed():
		audio.play()


func add_floor(floor_idx: int) -> void:
	var scene := FLOOR
	if floor_idx == 1:
		scene = FLOOR_BOTTOM
	elif floor_idx == Game.level.floors.size():
		scene = FLOOR_TOP
	
	var instance := scene.instantiate() as UIFloor
	floors.add_child(instance)
	
	if floor_idx <= Game.floor_nbr:
		if floor_idx % 2 == 0:
			instance.display_content_left(floor_idx)
		else:
			instance.display_content_right(floor_idx)
	
	if floor_idx < Game.floor_nbr or Game.floor_nbr == floor_idx and Game.victory:
		instance.light_windows()
