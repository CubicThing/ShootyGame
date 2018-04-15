extends KinematicBody2D

var hp = 5
var speed = 700
var shotCD = 0
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
		bullet.linear_velocity = (bullet.linear_velocity.normalized() - Vector2(0.3,0.3)).normalized() * 1000
		bullet.rotation_degrees = self.rotation_degrees
		bullet.global_position = self.global_position
		
		var bullet2 = shot.instance()
		get_parent().add_child(bullet2)
		bullet2.add_collision_exception_with(self)
		bullet2.add_collision_exception_with(bullet)
		bullet.add_collision_exception_with(bullet2)
		bullet2.shoot_at_player(self.global_position)
		bullet2.linear_velocity = (bullet2.linear_velocity.normalized() - Vector2(-0.3,-0.3)).normalized() * 1000
		bullet2.rotation_degrees = self.rotation_degrees
		bullet2.global_position = self.global_position
		shotCD = 50