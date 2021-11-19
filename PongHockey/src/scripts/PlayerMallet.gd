extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	add_to_group("mallets")

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	var collision = move_and_collide(Vector2.ZERO)
	if mouse_position.x > 512+37.5 and mouse_position.x < 1024-37.5 and mouse_position.y > 37.5 and mouse_position.y < 600-37.5:
		self.position.x = mouse_position.x - 875
		self.position.y = mouse_position.y - 300
	
