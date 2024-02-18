extends RigidBody2D

var screensize = Vector2.ZERO
var size
var radius
var scale_factor = 0.2


# I'm guessing this is the asteroid's constructor
func start(_position, _velocity, _size):
	position = _position
	size = _size
	mass = 1.5*size
	$Sprite2D.scale = Vector2.ONE*scale_factor*size
	radius = int($Sprite2D.texture.get_size().x/2 * $Sprite2D.scale.x)
	var shape = CircleShape2D.new()
	shape.radius = radius
	$CollisionShape2D.shape = shape
	linear_velocity = _velocity
	angular_velocity = randf_range(-PI, PI)
