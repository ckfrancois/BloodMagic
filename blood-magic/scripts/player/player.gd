extends CharacterBody2D

signal itemCollected(Dictionary)

const SPEED = 300.0
var heldItem: Dictionary

# Whenever health is changed for a cultist, emit a corresponding signal
signal healthChanged(Dictionary, int)

#var currentHealth:Array[int] = [0,0,0,0] # Starting values
#var maxHealth:Array[int] = [100,100,100,100] # Placeholder values

var cultist:Array[Dictionary] = [{},{},{},{}]
var numCultist:=0

@export var combatActions: Array[combat]

func _ready():
	collectCultist({"currHealth": 10,
	"maxHealth":10})
	collectCultist({"currHealth": 25,
	"maxHealth":25})

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
	
	if Input.is_action_just_pressed("Up"):
		cultistHurt()

func _combat_action(action : combat , enemy : Node2D):
	pass

func collectItem(data: Dictionary):
	emit_signal("itemCollected", data)
	heldItem = data
	

func collectCultist(data: Dictionary):
	while !cultist[numCultist].is_empty():
		numCultist += 1
	cultist[numCultist] = data
	emit_signal("healthChanged", cultist[numCultist], numCultist)

func cultistHurt():
	print(numCultist)
	var x = randi_range(0,numCultist)
	cultist[x]["currHealth"] -= 1
	emit_signal("healthChanged", cultist[x], x)
	
	
