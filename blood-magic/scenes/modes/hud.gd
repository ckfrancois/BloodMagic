extends CanvasLayer

const MAX_MEMBERS = 4

@onready var itemSlot = $ItemSlot
@onready var itemDesc = $ItemDesc

@onready var health1 = $HealthBar1
@onready var health2 = $HealthBar2
@onready var health3 = $HealthBar3
@onready var health4 = $HealthBar4
var cultHealth: Array[ProgressBar]
@onready var player = get_parent().get_node("Player")
var selecting = false

func _ready() -> void:
	player.itemCollected.connect(_on_item_collected)
	player.healthChanged.connect(_on_health_changed)
	cultHealth = [health1,health2,health3,health4]
	print(player.heldItem)

func _process(delta) -> void:
	if !player.heldItem.is_empty():
		if Input.is_action_just_pressed("Use Item"):
			if player.heldItem["type"] == "all":
				heal_all()
			elif player.heldItem["type"] == "single":
				show_selection_numbers()
				selecting = true
		
		if selecting:
			for i in range(MAX_MEMBERS):
				if !player.cultist[i].is_empty():
					if Input.is_action_just_pressed("heal_%d" % (i+1)):
						heal_one(i)
						hide_selection_numbers()
						selecting = false

func _on_item_collected(itemData: Dictionary):
	updateItem(itemData)

func updateItem(itemData: Dictionary):
	itemSlot.setItem(itemData)
	if itemData.is_empty():
		itemDesc.text = ""
	else:
		itemDesc.text = itemData["Description"]

func _on_health_changed(data: Dictionary, num: int):
	updateHealth(data, num)

func updateHealth(data: Dictionary, num: int):
	cultHealth[num].value = data["currHealth"]
	cultHealth[num].max_value = data["maxHealth"]
	cultHealth[num].visible = true

func heal_all():
	for i in range(MAX_MEMBERS):
		if !player.cultist[i].is_empty():
			player.cultist[i]["currHealth"] = min(player.cultist[i]["maxHealth"], player.cultist[i]["currHealth"] + player.heldItem["heal amount"])
			updateHealth(player.cultist[i],i)
	player.use_item()

func heal_one(i: int):
	print("hi")
	if !player.cultist[i].is_empty():
		player.cultist[i]["currHealth"] = min(player.cultist[i]["maxHealth"], player.cultist[i]["currHealth"] + player.heldItem["heal amount"])
		updateHealth(player.cultist[i],i)
	player.use_item()

func show_selection_numbers():
	pass

func hide_selection_numbers():
	pass
