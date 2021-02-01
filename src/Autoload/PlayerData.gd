extends Node


signal updated
signal died
signal reset

var score: = 5 setget set_score
var deaths: = 0 setget set_deaths
var next_scene
var scenes = []

func _ready():
	scenes.push_back(preload("res://src/Levels/Level01.tscn").instance()) # 0
	scenes.push_back(preload("res://src/Levels/Vale.tscn").instance())    # 1
	scenes.push_back(preload("res://src/Levels/Vale 2.tscn").instance())  # 2
	scenes.push_back(preload("res://src/Levels/Vale 3.tscn").instance())  # 3
	scenes.push_back(preload("res://src/Levels/Vale 4.tscn").instance())  # 4
	next_scene = scenes[0]

func change_scene(index):
	next_scene = scenes[index]

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
