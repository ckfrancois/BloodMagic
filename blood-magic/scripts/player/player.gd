extends CharacterBody2D

const SPEED = 300.0

# Whenever health is changed for a cultist, emit a corresponding signal
signal healthChanged1
signal healthChanged2
signal healthChanged3
signal healthChanged4

var currentHealth:Array[int] = [0,0,0,0] # Starting values
var maxHealth:Array[int] = [100,100,100,100] # Placeholder values

@export var combatActions: Array[combat]

func _ready():
	pass

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

func _combat_action(action : combat , enemy : Node2D):
	pass
