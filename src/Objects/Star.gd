extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer
var picked_by = false

func _on_body_entered(body: PhysicsBody2D) -> void:
	if !picked_by:
		picked()
		picked_by = true

func picked() -> void:
	anim_player.play("picked")
	PlayerData.stars -= 1
	if PlayerData.stars <= 0:
		finish()
	
func finish() -> void:
	get_tree().paused = true
#	anim_player.play("fade_out")
#	yield(anim_player, "animation_finished")
	get_tree().paused = false
	PlayerData.reset()
	get_tree().change_scene(PlayerData.next_scene)
