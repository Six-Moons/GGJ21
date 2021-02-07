extends Actor

signal hit

export var stomp_impulse: = 600.0
export var lives := 3
var hurt := false
var curr_animation = "Idle"

func _ready():
	speed = Vector2(365, 730)
	gravity = 1300

func _on_StompDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	if !body.is_dead() and !hurt:
		$AnimationPlayer.play("Hurt")
		if lives > 0:
			lives -= 1
			hurt = true
		else:
			die()
		emit_signal("hit", lives)

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	var snap: Vector2 = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO
	
	_velocity = move_and_slide_with_snap(
		_velocity, snap, FLOOR_NORMAL, true
	)
	
	if is_on_floor():
		if direction.x != 0:
			if direction.x < 0:
				$Sprite.set_flip_h( true )
			else:
				$Sprite.set_flip_h( false )
			curr_animation = "Run"
		else:
			curr_animation = "Idle"
	else:
		if _velocity.y < 0:
			curr_animation = "Jump"
		else:
			curr_animation = "Fall"
	if !hurt:
		$AnimationPlayer.play(curr_animation)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	)
#calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var velocity: = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y = 0.0
	return velocity

func calculate_stomp_velocity(linear_velocity: Vector2, stomp_impulse: float) -> Vector2:
	var stomp_jump: = -speed.y if Input.is_action_pressed("jump") else -stomp_impulse
	return Vector2(linear_velocity.x, stomp_jump)

func die() -> void:
	PlayerData.deaths += 1
	queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Hurt":
		hurt = false
	pass # Replace with function body.
