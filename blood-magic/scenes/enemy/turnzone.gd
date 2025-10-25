extends Area2D

func _on_body_entered(body: CharacterBody2D) -> void:
	print("Turn time!")
	
	var battle_scene = preload("res://battle.tscn")
	var battle_instance = battle_scene.instantiate()
	
	get_tree().root.add_child(battle_instance)
	get_tree().paused = true
	get_tree().current_scene.visible = false
