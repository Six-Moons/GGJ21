extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String, FILE) var next_scene_path: = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.change_scene(next_scene_path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
