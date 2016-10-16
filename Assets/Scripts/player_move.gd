
extends KinematicBody

const SIDEWAYS_SPEED = 30
const SCORE_DECREMENT_PER_FRAME = 1
const GRAVITY = -200
const JUMP_HEIGHT = 75
const MAX_FORWARD_SPEED = 100
const FORWARDS_SPEED = 7

var current_row = 0
var score = 0
var velocity = Vector3()
var jumping = false
var steer_inversion = 1
var game_ended = false
var game_started = false

onready var score_label = get_tree().get_current_scene().get_node('UI/Score')
onready var start_translation = get_translation()

func _ready():
	set_fixed_process(true)
	set_process(true)

func _process(delta):
	if not game_ended and game_started:
		score = score - (SCORE_DECREMENT_PER_FRAME * current_row)

		if score < 0:
			score = 0

		score_label.update_score(score)

func _fixed_process(delta):
	if game_started:
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

# Not wild on this method of handling args to the secondary function
func on_enter_tile(points, row, secondary_fn=null, secondary_arg=null):
	if row > current_row:
		score = score + (points * round(velocity.z))
		current_row = row
		score_label.update_score(score)
		if secondary_fn != null:
			if secondary_arg == null:
				secondary_fn.call_func()
			else:
				secondary_fn.call_func(secondary_arg)

func jump():
	if not jumping:
		jumping = true
		velocity.y = velocity.y + JUMP_HEIGHT

func reverb(strength):
	velocity.z = -velocity.z * strength

func alter_speed(factor):
	velocity.z = velocity.z * factor

func switch_steering():
	steer_inversion = -steer_inversion

func on_game_start():
	game_started = true

func on_game_over():
	game_ended = true

func on_game_reset():
	current_row = 0
	score = 0
	score_label.update_score(score)
	velocity = Vector3()
	jumping = false
	steer_inversion = 1
	set_translation(start_translation)
	game_ended = false

