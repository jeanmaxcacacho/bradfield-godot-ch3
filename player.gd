extends RigidBody2D

enum {INIT, ALIVE, INVULNERABLE, DEAD} # values come from their index in the whatever type of iterable this is
var state = INIT

@export var engine_power = 500
@export var spin_power = 8000

# I should really understand what Vectors do because I have no fucking clue
var thrust = Vector2.ZERO
var rotation_dir = 0


func _ready():
	change_state(ALIVE)
	

func change_state(new_state):
	match new_state:
		INIT:
			$CollisionShape2D.set_deffered("disabled", true)
		ALIVE:
			$CollisionShape2D.set_deffered("disabled", false)
		INVULNERABLE:
			$CollisionShape2D.set_deffered("disabled", true)
		DEAD:
			$CollisionShape2D.set_deffered("disabled", true)
	state = new_state


func _process(_delta):
	get_input()
	
	
func get_input():
	thrust = Vector2.ZERO
	if state in [DEAD, INIT]:
		return
	if Input.is_action_pressed("thrust"):
		thrust = transform.x*engine_power
	# I'm guessing this depends on whether or not it's a negative or positive rotation
	rotation_dir = Input.get_axis("rotate_left", "rotate_right")
