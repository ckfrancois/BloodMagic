extends CharacterBody2D

signal itemCollected(Dictionary)

@onready var sprite = $Sprite2D

const SPEED = 300.0
var heldItem: Dictionary

# Whenever health is changed for a cultist, emit a corresponding signal
signal healthChanged(Dictionary, int)

signal healthUpdate

#var currentHealth:Array[int] = [0,0,0,0] # Starting values
#var maxHealth:Array[int] = [100,100,100,100] # Placeholder values

var cultist:Array[Dictionary]
var numCultist = 0

@export var combatActions: Array[combat]

func _ready():
	EventBus.player = self
	collectCultist({"name": "leader",
	"currHealth": 30,
	"maxHealth":30,
	"attacks": [load("res://assets/actions/blood_shot.tres"), load("res://assets/actions/life_steal.tres"), load("res://assets/actions/replenish.tres"), load("res://assets/actions/drain.tres")]})
	sprite.play("default")

func _physics_process(delta: float) -> void:
	var moveX := Input.get_axis("Left", "Right")
	var moveY := Input.get_axis("Up","Down")
	
	if moveX != 0:
		sprite.flip_h = moveX < 0
	
	if moveX:
		velocity.x = moveX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if moveY:
		velocity.y = moveY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
	
	if cultist.size() == 4:
		get_tree().change_scene_to_file("res://scenes/menus/win.tscn")

func _combat_action(action : combat , enemy : Node2D):
	pass

func collectItem(data: Dictionary):
	emit_signal("itemCollected", data)
	heldItem = data
	

func collectCultist(data: Dictionary):
	cultist.append(data)
	emit_signal("healthChanged", cultist[numCultist], numCultist)
	numCultist += 1

func use_item():
	collectItem({})
