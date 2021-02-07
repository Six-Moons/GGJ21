extends Node2D

var tile_size = 32
export(String, FILE) var next_scene_path: = ""
export(int) var num_tiles_bottom = 24
export(int) var num_tiles_right = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Camera2D.limit_right = num_tiles_right * tile_size
	$Player/Camera2D.limit_bottom = num_tiles_bottom * tile_size
	PlayerData.change_scene(next_scene_path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
