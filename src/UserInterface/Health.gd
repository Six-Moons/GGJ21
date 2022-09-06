extends Control

export var hearts = 4 setget set_hearts
export var max_hearts = 4 setget set_max_hearts
var heartSize = 18

onready var heartFull = $Full
onready var heartHalf = $Half
onready var heartEmpty = $Empty

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if (heartFull != null):
		var heartsRectSize = hearts * heartSize
		if heartsRectSize > 0:
			heartFull.visible = true
			heartFull.rect_size.x = hearts * heartSize
		else:
			heartFull.visible = false
		if ($Timer.is_stopped()):
			$Timer.start()

func set_max_hearts(value):
	max_hearts = max(value, 1)
	if (heartEmpty != null):
		heartEmpty.rect_size.x = max_hearts * heartSize

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Timer_timeout():
	if (heartHalf != null):
		var heartsRectSize = hearts * heartSize
		if heartsRectSize > 0:
			heartHalf.visible = true
			heartHalf.rect_size.x = hearts * heartSize
		else:
			heartHalf.visible = false
