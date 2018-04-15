extends KinematicBody2D

# class member variables go here, for example:
var movespeed = 600
var starterMoveSpeed = 600
var dashspped = 2000
var shotspeed = 1000.0
var shot = preload("res://chara/bullet.tscn")
var shotCD = 0;
var isDashUp = 0
onready var camera = get_node("Camera2D");
onready var mpos = get_global_mouse_position();
onready var dashTimer = get_node("DashDuration")
onready var dashCD = get_node("DashCD")

func _ready():
	dashTimer.connect("timeout",self,"resetMovespeed")
	dashCD.connect("timeout",self,"getDashBack")

func _process(delta):
	if shotCD > 0:
		shotCD = shotCD - 1

#func fire():
#     var shot = shotscene.instance()
#     var shotvect = get_global_pos() - get_global_mouse_pos()).normalized()
#     get_parent.add_child(shot)
#    shot.set_global_pos(get_node("shotpoint").get_global_pos())
#     shot.set_linear_velocity(shotvect * shotspeed) # if your shot is a rigidbody

func _physics_process(delta):
	
	mpos = get_global_mouse_position()
	look_at(mpos)
	
	var movement = Vector2();
	
	if Input.is_action_pressed("move_up"):
		movement += Vector2(0,-1)
	if Input.is_action_pressed("move_down"):
		movement += Vector2(0,1)
	if Input.is_action_pressed("move_left"):
		movement += Vector2(-1,0)
	if Input.is_action_pressed("move_right"):
		movement += Vector2(1,0)
	if Input.is_action_pressed("shoot"):
		if shotCD == 0:
			var bullet = shot.instance()
			#bullet.add_collision_exception_with(self)
			get_parent().add_child(bullet) #don't want bullet to move with me, so add it as child of parent
			bullet.add_collision_exception_with(self)
			bullet.shoot_at_mouse(self.global_position)
			#bullet.set_linear_velocity(mpos.normalized()*1000) # if your shot is a rigidbody
			bullet.rotation_degrees = self.rotation_degrees
			bullet.position = $Sprite.global_position #use node for shoot position
			#bullet.set_linear_velocity(Vector2((randf()-0.5)/7,-1).normalized()*1000)
			shotCD = 4
	if Input.is_action_pressed("move_dash"):
		if isDashUp == 0:
			movespeed = dashspped
			isDashUp = 1
			dashTimer.start()
			dashCD.start()

	movement = movement.normalized() * movespeed
	
	move_and_slide(movement)

func resetMovespeed():
	movespeed = starterMoveSpeed
	dashTimer.stop()
	
func getDashBack():
	isDashUp = 0