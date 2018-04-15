extends KinematicBody2D

var hp = 5
var speed = 700
var shotCD = 0
var movement = Vector2(0,0)
var movementDecide = 0
var shot = preload("res://chara/bullet.tscn")
onready var timer = get_node("Timer")

func _ready():
	pass
	
func hit_by_bullet():
	hp = hp - 1
	if hp == 0:
		queue_free()
		
func on_timeout():
	pass

func _process(delta):
	if shotCD > 0:
		shotCD = shotCD - 1
	look_at(get_parent().playerPos)
	if shotCD == 0:
		var bullet = shot.instance()
		get_parent().add_child(bullet)
		bullet.add_collision_exception_with(self)
		bullet.shoot_at_player(self.global_position)
		bullet.rotation_degrees = self.rotation_degrees
		bullet.global_position = self.global_position
		shotCD = 50