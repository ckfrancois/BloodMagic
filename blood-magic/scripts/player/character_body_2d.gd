extends CharacterBody2D

signal itemCollected(Dictionary)

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	var moveX := Input.get_axis("Left", "Right")
	var moveY := Input.get_axis("Up","Down")
	if moveX:
		velocity.x = moveX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if moveY:
		velocity.y = moveY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()

func collectItem(data: Dictionary):
	emit_signal("itemCollected", data)
