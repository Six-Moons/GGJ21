extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer

export var score: = -1

func _on_body_entered(body: PhysicsBody2D) -> void:
	picked()

func picked() -> void:
	anim_player.play("picked")
	PlayerData.score += score
	if PlayerData.score <= 0:
		finish()
	
func finish() -> void:
	get_tree().paused = true
#	anim_player.play("fade_out")
#	yield(anim_player, "animation_finished")
	get_tree().paused = false
	PlayerData.reset()
	get_tree().change_scene(PlayerData.next_scene)
