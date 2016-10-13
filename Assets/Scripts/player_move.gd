
extends KinematicBody

const SIDEWAYS_SPEED = 30
const SCORE_DECREMENT_PER_FRAME = 1
const GRAVITY = -200
const JUMP_SPEED = 75
const MAX_FORWARD_SPEED = 100
const FORWARDS_SPEED = 7

var position = Vector3(0, 0, 0)
var current_row = 0
var score_label
var score = 0
var velocity = Vector3()
var jumping = false
var steer_inversion = 1

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
	var z_factor = velocity.z + (FORWARDS_SPEED * delta)
	var steer_factor = (1.421085 * pow(10, -14)) + (3.626263 * z_factor) - (0.066666667 * pow(z_factor, 2)) + (0.000404040404 * pow(z_factor, 3))

	if Input.is_action_pressed("ui_left"):
		sideways_input = 1 * steer_inversion

	if Input.is_action_pressed('ui_right'):
		sideways_input = -1 * steer_inversion

	if velocity.z < 0:
		sideways_input = sideways_input * -1

	velocity.x = velocity.x + (sideways_input * steer_factor * delta)
	velocity.z = z_factor

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
		score = score + (points * round(velocity.z))
		current_row = row
		score_label.update_score(score)

func jump(row):
	if row > current_row and not jumping:
		jumping = true
		velocity.y = velocity.y + JUMP_SPEED

func alter_speed(speed, row):
	if row > current_row: 
		velocity.z = velocity.z + speed

func switch_steering(row):
	if row > current_row: 
		steer_inversion = -steer_inversion
