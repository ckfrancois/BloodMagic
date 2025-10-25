extends Node2D


@export var player : Node2D
@export var ai : Node2D

var turn_order = [0, 1, 2, 3, 4] # enemy and players
var current_turn_index = 0 # starts at enemy, can randomize later


var character : bool = false

var game_over : bool = false

func _ready():
	next_turn()

func next_turn():
	if game_over:
		return
	
	# Allow the character to act
	act(turn_order[current_turn_index])
	
	# Go to the next character
	if turn_order.size() - 1 == current_turn_index:
		current_turn_index = 0
	else:
		current_turn_index += 1

func act(index):
	# Enemy
	if current_turn_index == 0:
		print("Enemy turn has begun")
		var wait_time = randf_range(0.5, 1.5)
		await get_tree().create_timer(wait_time).timeout
		
		var action_to_cast:combat = ai.combat_action(player) # make this random
		
		print(action_to_cast.display_name)
		
		await get_tree().create_timer(0.5).timeout
		next_turn()
	# Player
	else:
		print("Player turn has begun")

func player_combat_action (action : combat):
	#player.combat_action(action, enemy)
	# disable player ui
	await get_tree().create_timer(0.5).timeout
	next_turn()
	
func ai_decide_combat_action () -> combat:
	return null
	

func _on_button_1_pressed() -> void:
	print("Button 1")

func _on_button_2_pressed() -> void:
	pass # Replace with function body.

func _on_button_3_pressed() -> void:
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	pass # Replace with function body.
