extends CharacterBody2D

@onready var playerWalkingAudiostream = $AudioStreamPlayer_Walking

const SPEED = 300.0


func _physics_process(delta: float) -> void:
	var PlayerStoneWalkingSound= load("res://audio/player sfx/player_walking.mp3")
	var moveX := Input.get_axis("Left", "Right")
	var moveY := Input.get_axis("Up","Down")
	if moveX:
		velocity.x = moveX * SPEED
		if !playerWalkingAudiostream.playing:
			playerWalkingAudiostream.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		playerWalkingAudiostream.stop()
	
	if moveY:
		velocity.y = moveY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
