extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 800.0
var velocity = Vector2()
var random_number_generator = RandomNumberGenerator.new()
var signs = [-1, 1]
export var carryover = 0.75
export var max_speed = 2000.0
export var min_speed = 500.0

# Called when the node enters the scene tree for the first time.
func _ready():
	random_number_generator.randomize()
	yield(get_tree().create_timer(1.5), "timeout")
	spawn_puck()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		$hit_sound.play()
		velocity += carryover*collision.collider_velocity #add mallet speed to puck\
		velocity = velocity.bounce(collision.normal)
		particles_track()
		emitt_particles()
		move_and_collide(velocity*delta)
	
	if player_scored():
		$goal_sound.play()
		increase_player_score()
		reposition_puck()
		stop_puck()
		yield(get_tree().create_timer(2.0), "timeout")
		spawn_puck()
		clear_particles()
			
	if ai_scored():
		$goal_sound.play()
		increase_ai_score()
		reposition_puck()
		stop_puck()
		yield(get_tree().create_timer(2.0), "timeout")
		spawn_puck()
		clear_particles()
	
	degrade_velocity() #puck velocity degredation
	velocity.x = min(velocity.x,max_speed) #maximum puck velocity
	velocity.y = min(velocity.y,max_speed) #maximum puck velocity
	

func spawn_puck():
	var x_random_direction = signs[random_number_generator.randi() % signs.size()]
	var y_random_direction = signs[random_number_generator.randi() % signs.size()]
	velocity = Vector2(x_random_direction, y_random_direction)*speed

func reposition_puck():
	self.position.x = 512
	self.position.y = 300
#	self.position.y = random_number_generator.randi_range(0, 600)

func increase_player_score():
	Score.player_score += 1
	
func increase_ai_score():
	Score.ai_score += 1
	
func ai_scored():
	return self.position.x >= 1024

func player_scored():
	return self.position.x <= 0

func stop_puck():
	velocity = Vector2.ZERO

#
func degrade_velocity():
	velocity = velocity.linear_interpolate(Vector2.ZERO,.005)

#emitts the particles and restarts so it can play multiple times
func emitt_particles():
	$Particles.set_emitting(true)
	$Particles.restart()

#tracks the direction of the punk to emitt particles behind it
func particles_track():
	$Particles.set_rotation(velocity.angle() + PI)
	$Particles.initial_velocity = velocity.length()

#clears all the puck particles on screen
func clear_particles():
	$Particles.set_amount(0)
