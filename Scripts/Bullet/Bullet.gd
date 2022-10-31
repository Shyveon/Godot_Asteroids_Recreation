extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 400
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _draw():
	draw_line(Vector2(0,0), Vector2(0,-3), Color.white, 0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	update()
	pass

func _physics_process(_delta):
	velocity = Vector2(0,-speed).rotated(rotation)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.


func _on_Bullet_area_entered(area):
	queue_free()
	pass # Replace with function body.
