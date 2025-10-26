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
var deaths = 0

signal healthUpdate
signal turnIndex

func _ready():
	buttons = [$BattleUI/HBoxContainer/VBoxContainer/Button1, $BattleUI/HBoxContainer/VBoxContainer2/Button2, $BattleUI/HBoxContainer/VBoxContainer/Button3, $BattleUI/HBoxContainer/VBoxContainer2/Button4]
	number_of_cultists = player.numCultist
	print(number_of_cultists, " num")
	next_turn()
	camera.make_current()

func _physics_process(delta: float) -> void:
	if ai.currHealth <=0:
		end_battle()

func next_turn():
	if game_over:
		game_over_fully()
		return
		
	
	print(current_turn_index)
	
	# Allow the character to act
	act(turn_order[current_turn_index])
	
	# Go to the next character
	
	if turn_order.size() - 1 == current_turn_index || current_turn_index >= number_of_cultists :
		await turnIndex
		current_turn_index = 0
	else:
		await turnIndex
		current_turn_index += 1
	

func act(index):
	# Enemy
	if current_turn_index == 0:
		print("Enemy turn has begun")
		var wait_time = randf_range(0.5, 1.5)
		await get_tree().create_timer(wait_time).timeout
		
		var action_to_cast:combat = ai.combat_action()
		var cultist_to_attack:int = ai.choose_cultist(player, number_of_cultists - deaths)
		cultist_to_attack = randi_range(0, number_of_cultists - 1)
		
		# Do the action
		print(action_to_cast.display_name)
		print("Attacking ", cultist_to_attack)
		ai_action(action_to_cast, cultist_to_attack)
		
		# Check if player died
		if player.cultist[cultist_to_attack]["currHealth"] <= 0:
			deaths += 1
		
		# If all party members are dead, game over
		if deaths >= number_of_cultists:
			game_over = true
		
		await get_tree().create_timer(0.5).timeout
		next_turn()
	# Player
	else:
		print("Player turn has begun ", index)
		player_combat_action(index)

func game_over_fully():
	print("Game OVER!!!")
	get_tree().quit()
	# Game over screen...
	get_tree().change_scene_to_file("res://scenes/menus/game_over.tscn")

func ai_action(action:combat, cultist_index:int):
	player.cultist[cultist_index]["currHealth"] -= action.damage;
	ai.currHealth = min(action.heal+ai.currHealth, ai.maxHealth);
	ai.currHealth -= action.recoil
	player.emit_signal("healthUpdate", cultist_index)
	emit_signal("turnIndex")
	print(player.cultist[cultist_index]["currHealth"], "for" , cultist_index)

func player_combat_action(index : int):
	await get_tree().create_timer(0.5).timeout
		
	for i in 4:
		# Set current moves to current_moves
		if typeof(player.cultist[index - 1]["attacks"][i]) == TYPE_STRING:
			current_moves.insert(i, load(player.cultist[index - 1]["attacks"][i]))
		else:
			current_moves.insert(i, player.cultist[index - 1]["attacks"][i])
		
		# Set buttons to correct moves
		buttons[i].text = current_moves[i].display_name
		buttons[i].set_tooltip_text(current_moves[i].description)
		
		# Enable buttons
		for b in buttons:
			b.disabled = false
	
func ai_decide_combat_action () -> combat:
	return null

func player_action (action:combat, index:int):
	ai.currHealth -= action.damage;
	player.cultist[index]["currHealth"] = min(action.heal + player.cultist[index]["currHealth"], player.cultist[index]["maxHealth"])
	player.cultist[index]["currHealth"] -= action.recoil
	print(player.cultist[index]["currHealth"], " for ", index)
	print(current_turn_index)
		
	# Check if player died
	if player.cultist[index - 1]["currHealth"] <= 0:
		deaths += 1
	
	# If all party members are dead, game over
	if deaths >= number_of_cultists:
		game_over = true
	
	player.emit_signal("healthUpdate", index)
	emit_signal("turnIndex")
	
	next_turn()

func _on_button_1_pressed() -> void:
	player_action(current_moves[0], current_turn_index - 1)
	
	# Disable buttons
	for b in buttons:
		b.disabled = true
	
	await get_tree().create_timer(0.5).timeout

func _on_button_2_pressed() -> void:
	player_action(current_moves[1], current_turn_index - 1)
	
	# Disable buttons
	for b in buttons:
		b.disabled = true
	
	await get_tree().create_timer(0.5).timeout

func _on_button_3_pressed() -> void:
	player_action(current_moves[2], current_turn_index - 1)
	
	# Disable buttons
	for b in buttons:
		b.disabled = true
	
	await get_tree().create_timer(0.5).timeout

func _on_button_4_pressed() -> void:
	player_action(current_moves[3], current_turn_index - 1)
	
	# Disable buttons
	for b in buttons:
		b.disabled = true
	
	await get_tree().create_timer(0.5).timeout

func end_battle():
	get_tree().current_scene.visible = true
	get_tree().paused = false
	ai.queue_free()
	queue_free()
