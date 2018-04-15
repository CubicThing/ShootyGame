extends Area2D

var toSpawn = preload("res://chara/badexplodeyguy.tscn")
onready var timer = get_node("Timer")

func _ready():
	timer.connect("timeout", self, "on_timeout_complete")
	
func on_timeout_complete():
	
	var size = 1
	
	if size > 0.75:
		var spawnee = toSpawn.instance()
		get_parent().add_child(spawnee)
		spawnee.global_position = self.global_position
		spawnee.scale = Vector2(size,size)
		spawnee.speed = spawnee.speed * size
		
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
