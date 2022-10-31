extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	draw_line(Vector2(0, -15), Vector2(10, 15), Color.white)
	draw_line(Vector2(10, 15), Vector2(0, 5), Color.white)
	draw_line(Vector2(0, 5), Vector2(-10, 15), Color.white)
	draw_line(Vector2(-10,15), Vector2(0,-15), Color.white)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
