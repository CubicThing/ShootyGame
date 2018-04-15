extends KinematicBody2D

var hp = 5
var speed = 700
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
	move_and_slide(((get_parent().playerPos - self.global_position).normalized() + Vector2(0,0)) * speed )