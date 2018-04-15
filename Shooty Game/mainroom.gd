extends Node2D

var playerPos 

func _ready():
	pass

func _process(delta):
	playerPos = get_node("Player").global_position
