extends Node

signal updated
signal reset

var stars: = 5 setget set_score
var next_scene = ""
var scenes = []

func _ready():
	pass

func change_scene(scene_path):
	next_scene = scene_path

func reset():
	self.stars = 5
	emit_signal("reset")

func set_score(new_stars: int) -> void:
	stars = new_stars
	emit_signal("updated")
