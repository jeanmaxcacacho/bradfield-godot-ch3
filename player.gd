extends RigidBody2D

enum {INIT, ALIVE, INVULNERABLE, DEAD} # values come from their index in the whatever type of iterable this is
var state = INIT
var screensize = Vector2.ZERO

@export var engine_power = 500
@export var spin_power = 8000

# I should really understand what Vectors do because I have no fucking clue
var thrust = Vector2.ZERO
var rotation_dir = 0


func _ready():
	change_state(ALIVE)
	screensize = get_viewport_rect().size
	

func change_state(new_state):
	match new_state:
		INIT:
			$CollisionShape2D.set_deferred("disabled", true)
		ALIVE:
			$CollisionShape2D.set_deferred("disabled", false)
		INVULNERABLE:
			$CollisionShape2D.set_deferred("disabled", true)
		DEAD:
			$CollisionShape2D.set_deferred("disabled", true)
	state = new_state


func _process(_delta):
	get_input()
	
	
func get_input():
	thrust = Vector2.ZERO
	if state in [DEAD, INIT]:
		return
	if Input.is_action_pressed("thrust"):
		# scalar multiplication, you "stretch" the vector to make it move a direction
		thrust = transform.x*engine_power
	# I'm guessing this depends on whether or not it's a negative or positive rotation
	rotation_dir = Input.get_axis("rotate_left", "rotate_right")


# again, it's really just about learning what the nodes do; this is a rigid body specific method
func _physics_process(_delta):
	constant_force = thrust
	constant_torque = rotation_dir*spin_power
	
	
# have to use this function when changing a physics body's position or other like "God" shit
func _integrate_forces(physics_state):
	var xform = physics_state.transform
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x)
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y)
	physics_state.transform = xform
