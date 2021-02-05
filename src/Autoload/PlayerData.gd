extends Node


signal updated
signal died
signal reset

var score: = 5 setget set_score
var deaths: = 0 setget set_deaths
var next_scene = ""
var scenes = []

func _ready():
	pass

func change_scene(scene_path):
	next_scene = scene_path

func reset():
	self.score = 5
	self.deaths = 0
	emit_signal("reset")

func set_score(new_score: int) -> void:
	score = new_score
	emit_signal("updated")

func set_deaths(new_value: int) -> void:
	deaths = new_value
	emit_signal("died")
