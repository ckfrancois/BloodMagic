extends CanvasLayer

@onready var itemSlot = $ItemSlot
@onready var health1 = $HealthBar1
@onready var health2 = $HealthBar2
@onready var health3 = $HealthBar3
@onready var health4 = $HealthBar4
var cultHealth: Array[ProgressBar]
@onready var player = get_parent().get_node("Player")

func _ready() -> void:
	player.itemCollected.connect(_on_item_collected)
	player.healthChanged.connect(_on_health_changed)
	cultHealth = [health1,health2,health3,health4]

func _on_item_collected(itemData: Dictionary):
	updateItem(itemData)

func updateItem(itemData: Dictionary):
	itemSlot.setItem(itemData)

func _on_health_changed(data: Dictionary, num: int):
	updateHealth(data, num)

func updateHealth(data: Dictionary, num: int):
	cultHealth[num].value = data["currHealth"] * 100 / data["maxHealth"]
	cultHealth[num].visible = true
