extends ProgressBar

@export var player: CharacterBody2D

func _ready():
	player.healthChanged2.connect(update)
	update()

# Update the value to a fraction of the player's health
func update():
	value = player.currentHealth[1] * 100 / player.maxHealth[1]
