extends CanvasLayer

@onready var itemSlot = $ItemSlot
@onready var player = get_parent().get_node("Player")

func _ready() -> void:
	player.itemCollected.connect(_on_item_collected)

func _on_item_collected(itemData: Dictionary):
	updateItem(itemData)

func updateItem(itemData: Dictionary):
	itemSlot.setItem(itemData)
