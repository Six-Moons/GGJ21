extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var scene_index = 1 

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.change_scene(scene_index)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
