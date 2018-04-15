extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var bulletSpeed = 1000
onready var timer = get_node("Timer")

func shoot_at_mouse(start_pos):
	self.global_position = start_pos
	var direction = (get_global_mouse_position() - start_pos ).normalized()
	direction = (direction + direction * Vector2(rand_range(0.2,1),rand_range(0.2,1))).normalized()
	print(direction)
	self.linear_velocity = direction * 2000

func shoot_at_player(start_pos):
	self.global_position = start_pos
	var direction = (get_parent().playerPos - start_pos ).normalized()
	self.linear_velocity = direction * 1000


func _ready():
	timer.connect("timeout", self, "on_timeout_complete")
	self.connect("body_entered", self, "body_entered")

func body_entered( body ):
	if body.has_method("hit_by_bullet"):
		body.call("hit_by_bullet")
	queue_free()
	
func on_timeout_complete():
	queue_free()

func _process(delta):
	pass
