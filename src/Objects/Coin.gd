extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer

export var score: = -1

func _on_body_entered(body: PhysicsBody2D) -> void:
	picked()

func picked() -> void:
	PlayerData.score += score
	anim_player.play("picked")
	
func finish() -> void:
	if PlayerData.score == 0:
		get_tree().paused = true
		anim_player.play("fade_out")
		yield(anim_player, "animation_finished")
		get_tree().paused = false
#		get_tree().change_scene_to(PlayerData.next_scene)
