extends Area2D

func _on_body_entered(body: CharacterBody2D) -> void:
	print("Turn time!")
	
	var battle_scene = preload("res://scenes/modes/battle.tscn")
	var battle_instance = battle_scene.instantiate()
	
	get_tree().root.add_child(battle_instance)
	battle_instance.ai = get_parent()
	print(battle_instance.ai)
	get_tree().current_scene.visible = false
	get_tree().paused = true
