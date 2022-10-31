extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum Sizes {
	BIG,
	MEDIUM,
	SMALL
}
var radius
var speed
var size
var velocity = Vector2.ZERO
var alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	match size:
			Sizes.BIG:
				self.radius = 40
				self.speed = 50
			Sizes.MEDIUM:
				self.radius = 20
				self.speed = 200
			Sizes.SMALL:
				self.radius = 5
				self.speed = 300
	pass # Replace with function body.

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func _draw():
	draw_circle_arc(Vector2(0,0), radius, 0, 360, Color.white)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	update()
	pass

func _physics_process(_delta):
	velocity = Vector2(speed,0).rotated(rotation)

func _on_Asteroid_area_entered(_area):
	if !alive:
		return
	alive = false
	var quantity = 0
	match size:
		Sizes.BIG:
			quantity = 2
			get_parent().score += 30
		Sizes.MEDIUM:
			quantity = 4
			get_parent().score += 60
		Sizes.SMALL:
			get_parent().score += 120
			
	get_node("/root/Main/HUD").update_score(get_parent().score)
			
	for i in range(quantity):
		var asteroid = duplicate()
		asteroid.size = size + 1
		asteroid.global_position = to_global(Vector2(0,0))
		asteroid.rotation = rotation + rand_range(-PI / 4, PI / 4)
		get_node("/root/Main").add_child(asteroid)

	queue_free()

	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
