extends Area2D

@export var itemData:= {
	"name": "TempCake",
	"type": "all",
	"heal amount": 3,
	"icon": preload("res://assets/items/redVelv.png"),
	"Description": "Heals all followers"
}


func _on_body_entered(body: CharacterBody2D) -> void:
	body.collectItem(itemData)
	queue_free()
