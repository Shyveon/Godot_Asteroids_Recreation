extends Area2D

signal hit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 200
export var friction = 1
export var rotation_speed = 1.0
export(PackedScene) var projectile
var screen_size
var velocity = Vector2.ZERO
var rotation_direction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	pass # Replace with function body.

func _draw():
	draw_line(Vector2(0, -30), Vector2(20, 30), Color.white)
	draw_line(Vector2(20, 30), Vector2(0, 15), Color.white)
	draw_line(Vector2(0, 15), Vector2(-20, 30), Color.white)
	draw_line(Vector2(-20,30), Vector2(0,-30), Color.white)
	
func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		var bullet = projectile.instance()
		bullet.global_position = to_global(Vector2(0,-35))
		bullet.rotation = rotation
		get_node("/root/Main").add_child(bullet)
		
	if position.x < 0 or position.x > screen_size.x:
		position = Vector2(int(rand_range(0,screen_size.x)), rand_range(0, screen_size.y))
		
	if position.y < 0 or position.y > screen_size.y:
		position = Vector2(int(rand_range(0,screen_size.x)), rand_range(0, screen_size.y))
	
	update()

func _physics_process(delta):
	rotation_direction = lerp(rotation_direction, 0, 7.3 * delta)
	if velocity.length() > 0:
		velocity = lerp(velocity, Vector2.ZERO, friction * delta)
	
	if Input.is_action_pressed("acceleration"):
		velocity = Vector2(0,-speed).rotated(rotation)

	if Input.is_action_pressed("rotate_left"):
		rotation_direction -= 1
		
	if Input.is_action_pressed("rotate_right"):
		rotation_direction += 1
	
	rotation += rotation_direction * rotation_speed * delta
	position += velocity * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_area_entered(area):
	emit_signal("hit")
	hide()
	$CollisionPolygon2D.set_deferred("disabled", true)
	pass # Replace with function body.


func Respawn():
	position = Vector2(screen_size.x/2,screen_size.y/2)
	$GraceTimer.start()
	show()


func _on_GraceTimer_timeout():
	$CollisionPolygon2D.set_deferred("disabled", false)
	pass # Replace with function body.
