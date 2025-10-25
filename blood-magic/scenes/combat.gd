class_name combat
extends Resource

@export var display_name : String
@export var description : String

@export var damage : int = 0
@export var heal : int = 0
@export var recoil : int = 0

# Set this higher or lower to determine if the AI will choose it
# Higher = better action, Lower = worse action for the AI
@export var base_weight : int = 100
