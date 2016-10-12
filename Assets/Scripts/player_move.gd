
extends KinematicBody

const SIDEWAYS_SPEED = 15
const SCORE_DECREMENT_PER_FRAME = 1
const GRAVITY = -200
const JUMP_SPEED = 75
const MAX_FORWARD_SPEED = 75

var forwards_speed = 7
var position = Vector3(0, 0, 0)
var current_row = 09
var score_label
var score = 0
var velocity = Vector3()
var jumping = false

func _ready():
	set_fixed_process(true)
	set_process(true)
	score_label = get_tree().get_current_scene().get_node('UI/Score')

func _process(delta):
	score = score - SCORE_DECREMENT_PER_FRAME
	
	#if the score was under 0 then it's still 0 so don't update it visually
	if score < 0:
		score = 0
	else:
		score_label.update_score(score)

func _fixed_process(delta):
	var sideways_input = 0
	var force = Vector3(0, GRAVITY, 0)

	if Input.is_action_pressed("ui_left"):
		sideways_input = 1

	if Input.is_action_pressed('ui_right'):
		sideways_input = -1

	velocity.x = velocity.x + (sideways_input * SIDEWAYS_SPEED * delta)
	velocity.z = velocity.z + (forwards_speed * delta)
	
	if velocity.z > MAX_FORWARD_SPEED:
		velocity.z = MAX_FORWARD_SPEED
	
	velocity = velocity + (force * delta)

	var motion = velocity * delta
	motion = move(motion)

	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)

	if jumping and velocity.y > 0:
		jumping = false

func on_enter_tile(points, row):
	if row > current_row:
		score = score + (points * forwards_speed)
		current_row = row
		score_label.update_score(score)

func jump():
	if not jumping:
		print("jump")
		jumping = true
		velocity.y = velocity.y + JUMP_SPEED

func alter_speed(speed, row):
	if row > current_row: 
		velocity.z = velocity.z + speed

