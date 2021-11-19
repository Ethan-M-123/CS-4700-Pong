extends Area2D

export var velocity_multipler = 1.0
var prev_x_pos = 0
var velocity = 1


func _ready():
	prev_x_pos = position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x_pos = get_parent().position.x
	velocity += prev_x_pos - x_pos
	if velocity < 1:
		velocity = 1
	else:
		velocity -= 1
	prev_x_pos = x_pos

func get_velocity():
	var hit_velocity = velocity_multipler * log(velocity)
	#just velocity somehow hits something ridicously slow
	if hit_velocity < 2:
		hit_velocity = 2
	return hit_velocity

