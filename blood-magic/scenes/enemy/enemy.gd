extends Node2D

@export var combatActions: Array[combat]

@export var currHealth: int
@export var maxHealth: int

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
		weights.append(1 / element["currHealth"]) # flips the weights
		
	var ran = rng.rand_weighted(weights)
	if ran < 0:
		ran = 0
	if ran > num:
		ran = num
	
	return (ran)
