# Player: kinematic movement, mechanics

extends KinematicBody2D

# Gravity, movement
var GRAV = 750.0
var WALKSP = 200
var jumpCap = false
var velocity = Vector2()

# Animations
# onready var anim_run = get_node("player_run")

func _fixed_process(delta):
	# Gravity
	velocity.y += GRAV * delta
	
	# User input
	if Input.is_action_pressed("move_left"):
		velocity.x = -WALKSP
	elif Input.is_action_pressed("move_right"):
		velocity.x = WALKSP
	else:
		velocity.x = 0
	
	if Input.is_action_pressed("jump") and jumpCap == false:
		velocity.y = -300
		jumpCap = true
	
	# Motion
	var motion = velocity * delta
	move(motion)
	
	# Sliding
	if (is_colliding()):
		jumpCap = false
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)

func _ready():
	set_fixed_process(true)
	pass
