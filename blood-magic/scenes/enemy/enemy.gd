extends Node2D

@export var combatActions: Array[combat]

func combat_action(enemy : CharacterBody2D) -> combat:
	var rng = RandomNumberGenerator.new()
	var weights = PackedFloat32Array([combatActions[0].base_weight, combatActions[1].base_weight, combatActions[2].base_weight])
	return (combatActions[rng.rand_weighted(weights)])
