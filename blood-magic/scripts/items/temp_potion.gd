extends Area2D

@export var itemData:= {
	"name": "TempPotion",
	"type": "single",
	"heal amount": 20,
	"icon": preload("res://assets/items/tempPotion.png"),
}

func _on_body_entered(body: CharacterBody2D) -> void:
	body.collectItem(itemData)
	queue_free()
