
extends RigidBody

var sideways_speed = 10
var sideways_input = 0
var forwards_speed = 5
var max_forwards_speed = 30
var min_forwards_speed = 5
var position = Vector3(0,0,0)
var current_row = 0
var score_label
var score = 0

func _ready():
	set_fixed_process(true)
	score_label = get_tree().get_current_scene().get_node('UI/Score')

func _fixed_process(delta):
	sideways_input = 0
	if Input.is_action_pressed("ui_left"):
		sideways_input = 1

	if Input.is_action_pressed('ui_right'):
		sideways_input = -1

	if Input.is_action_pressed('ui_up'):
		forwards_speed = forwards_speed + 1

	if Input.is_action_pressed('ui_down'):
		forwards_speed = forwards_speed - 1

	if forwards_speed > max_forwards_speed:
		forwards_speed = max_forwards_speed

	if forwards_speed < min_forwards_speed:
		forwards_speed = min_forwards_speed

	apply_impulse(position, Vector3(sideways_input * sideways_speed * delta, 0, forwards_speed * delta))


func on_enter_tile(points, row):
	if row > current_row:
		score = score + (points * forwards_speed)
		current_row = row
		score_label.update_score(score)
