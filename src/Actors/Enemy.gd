extends Actor

onready var stomp_area: Area2D = $StompArea2D

export var score: = 100
var dead = false

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x
	$AnimationPlayer.play("Run")

func is_dead():
	return dead

func _physics_process(delta: float) -> void:
	if is_on_wall():
		_velocity.x *= -1
		$Sprite.set_flip_h(!$Sprite.is_flipped_h())
		
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func _on_StompArea2D_area_entered(area: Area2D) -> void:
	if area.global_position.y > stomp_area.global_position.y:
		return
	die()

func die() -> void:
	$AnimationPlayer.play("Hit")
	dead = true
	_velocity.x = 0
	PlayerData.score += score

func _on_AnimationPlayer_animation_finished(anim_name):
	if $AnimationPlayer.assigned_animation == "Hit":
		queue_free()
	pass # Replace with function body.
