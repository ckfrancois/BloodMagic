extends ProgressBar

@export var player: CharacterBody2D

func _ready():
	player.healthChanged3.connect(update)
	update()

# Update the value to a fraction of the player's health
func update():
	value = player.currentHealth[2] * 100 / player.maxHealth[2]
