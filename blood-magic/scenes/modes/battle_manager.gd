extends Node2D

@onready var camera := $Camera2D

var player : Node2D = EventBus.player
@export var ai : Node2D

var turn_order = [0, 1, 2, 3, 4] # enemy and players
var current_turn_index = 0 # starts at enemy, can randomize later
var number_of_cultists # needs to be updated

var character : bool = false
var game_over : bool = false

@onready var buttons: Array
var current_moves : Array

func _ready():
	buttons = [$BattleUI/HBoxContainer/VBoxContainer/Button1, $BattleUI/HBoxContainer/VBoxContainer2/Button2, $BattleUI/HBoxContainer/VBoxContainer/Button3, $BattleUI/HBoxContainer/VBoxContainer2/Button4]
	number_of_cultists = player.numCultist
	print(number_of_cultists)
	print("hiii")
	next_turn()
	camera.make_current()


func next_turn():
	if game_over:
		return
	
	# Allow the character to act
	act(turn_order[current_turn_index])
	
	# Go to the next character
	if turn_order.size() - 1 == current_turn_index || current_turn_index > number_of_cultists :
		current_turn_index = 0
	else:
		current_turn_index += 1

func act(index):
	# Enemy
	if current_turn_index == 0:
		print("Enemy turn has begun")
		var wait_time = randf_range(0.5, 1.5)
		await get_tree().create_timer(wait_time).timeout
		
		var action_to_cast:combat = ai.combat_action()
		#var cultist_to_attack:int = ai.choose_cultist(player, number_of_cultists)
		
		# Do the action
		print(action_to_cast.display_name)
		#print(cultist_to_attack)
		
		await get_tree().create_timer(0.5).timeout
		next_turn()
	# Player
	else:
		print("Player turn has begun")
		player_combat_action(index)

func player_combat_action(index : int):
	await get_tree().create_timer(0.5).timeout
	
	print(player.cultist[index - 1]["attacks"][3])
		
	for i in 4:
		print(player.cultist[index - 1])
		# Set current moves to current_moves
		current_moves.insert(i, player.cultist[index - 1]["attacks"][i])
		
		# Set buttons to correct moves
		buttons[i].text = current_moves[i].display_name
		
		print(current_moves[i].display_name)
		print(buttons[i].text)
		
		# Enable buttons
		for b in buttons:
			b.disabled = false
	
func ai_decide_combat_action () -> combat:
	return null
	

func _on_button_1_pressed() -> void:
	print("Button 1")
	# Do the action
	print(current_moves[0].display_name)
	
	# Disable buttons
	for b in buttons:
		b.disabled = true
	
	await get_tree().create_timer(0.5).timeout
	next_turn()

func _on_button_2_pressed() -> void:
	print("Button 2")
	# Do the action
	print(current_moves[1].display_name)
	
	# Disable buttons
	for b in buttons:
		b.disabled = true
	
	await get_tree().create_timer(0.5).timeout
	next_turn()

func _on_button_3_pressed() -> void:
	print("Button 3")
	# Do the action
	print(current_moves[2].display_name)
	
	# Disable buttons
	for b in buttons:
		b.disabled = true
	
	await get_tree().create_timer(0.5).timeout
	next_turn()


func _on_button_4_pressed() -> void:
	print("Button 4")
	# Do the action
	print(current_moves[3].display_name)
	
	# Disable buttons
	for b in buttons:
		b.disabled = true
	
	await get_tree().create_timer(0.5).timeout
	next_turn()
