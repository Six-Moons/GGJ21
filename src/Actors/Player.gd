extends Actor


export var stomp_impulse: = 600.0
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _on_StompDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)


func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	die()

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	var snap: Vector2 = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO
	
	_velocity = move_and_slide_with_snap(
		_velocity, snap, FLOOR_NORMAL, true
	)
	
	if direction != Vector2.ZERO:
		if direction.x < 0:
			$Sprite.set_flip_h( true )
		else:
			$Sprite.set_flip_h( false )
		if is_on_floor():
			$AnimationPlayer.play("Run_right")
		else:
			# Animation set up to prioritize walk left/right over up/down when walking diagonally UwU
			$AnimationPlayer.play("Jump_right")
			
	else:
		$AnimationPlayer.play("Idle_right")
	
#	print(_velocity)
#	print(animationState)
#	if _velocity != Vector2.ZERO:
#		# Set blend position of each node of the animation tree 
#		# to be equal to the input vector to play the correct animation OwO
#		animationTree.set("parameters/Idle/blend_position", direction.x)
#		animationTree.set("parameters/Run/blend_position", direction.x)
#
#		if is_on_floor():
#			animationState.travel("Run")
#		else:
#			animationTree.set("parameters/Jump/blend_position", _velocity.y)
#			# Animation set up to prioritize walk left/right over up/down when walking diagonally UwU
#			animationState.travel("Jump")
#	else:
#		animationState.travel("Idle")


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	)


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
