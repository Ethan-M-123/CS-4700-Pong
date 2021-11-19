extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 1000.0
var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.ZERO
	add_to_group("mallets")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2.ZERO
	
	var ball = get_parent().get_node("Puck")
	
	if ball.velocity != Vector2.ZERO:
		if ball.position.y < self.position.y:
			velocity += Vector2.UP * (speed/3)
		if ball.position.y > self.position.y:
			velocity += Vector2.DOWN * (speed/3)
			
		
	move_and_collide(velocity*delta)

