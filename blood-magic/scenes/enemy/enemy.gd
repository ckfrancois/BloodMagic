extends Node2D

@export var combatActions: Array[combat]

func combat_action() -> combat:
	var rng = RandomNumberGenerator.new()
	var weights = PackedFloat32Array()
	
	for element in combatActions:
		weights.append(element.base_weight)
	
	return (combatActions[rng.rand_weighted(weights)])

func choose_cultist(player : CharacterBody2D, num : int):
	var rng = RandomNumberGenerator.new()
	var weights = PackedFloat32Array()
	
	# Append the healths
	for element in player.cultist: # edit
		weights.append(1 / element["curr_health"]) # flips the weights
	
	return (rng.rand_weighted(weights))
