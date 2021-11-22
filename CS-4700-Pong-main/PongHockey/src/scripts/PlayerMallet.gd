extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	var collision = move_and_collide(Vector2.ZERO)
	
	#print(mouse_position)
	
	if mouse_position.x > 512+37.5 and mouse_position.x < 1024-37.5:
		self.position.x = mouse_position.x - 875
	if mouse_position.y > 37.5 and mouse_position.y < 600-37.5:
		self.position.y = mouse_position.y - 300
