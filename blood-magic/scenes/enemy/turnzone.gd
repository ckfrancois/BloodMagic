extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Turn time!")
	body.get_node("CollisionShape2D").queue_free()
