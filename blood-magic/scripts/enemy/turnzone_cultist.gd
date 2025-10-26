extends Area2D

@export var cultist_data := {
	"name": "",
	"currHealth": 0,
	"maxHealth": 0,
	"attacks": ["res://assets/actions/blood_shot.tres", "res://assets/actions/life_steal.tres", "res://assets/actions/replenish.tres", "res://assets/actions/reckless_exchange.tres"]}

func _on_body_entered(body: CharacterBody2D) -> void:
	print("Turn time!")
	
	body.collectCultist(cultist_data)
	
	var battle_scene = preload("res://scenes/modes/battle.tscn")
	var battle_instance = battle_scene.instantiate()
	
	get_tree().root.add_child(battle_instance)
	battle_instance.ai = get_parent()
	battle_instance.player = EventBus.player
	get_tree().current_scene.visible = false
	get_tree().paused = true
