extends Node

signal game_over

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var asteroid_scene

enum AsteroidSizes {
	BIG,
	MEDIUM,
	SMALL
}
var deaths = 0
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AsteroidTimer_timeout():
	var asteroid = asteroid_scene.instance()
	asteroid.size = AsteroidSizes.BIG
	
	var asteroid_spawn_location = $AsteroidPath/AsteroidSpawnLocation
	asteroid_spawn_location.offset = randi()
	
	var direction = asteroid_spawn_location.rotation + PI / 2
	asteroid.position = asteroid_spawn_location.position
	
	direction += rand_range(-PI / 4, PI / 4)
	
	asteroid.rotation = direction
	
	add_child(asteroid)


func _on_Player_hit():
	var node = $HUD/LivesGridContainer.get_node("Life" + str(deaths))
	$HUD/LivesGridContainer.remove_child(node)
	deaths += 1
	if deaths >= 3:
		emit_signal("game_over")
		$Player.queue_free()
		return
	$RespawnTimer.start()
	pass # Replace with function body.


func _on_RespawnTimer_timeout():
	$Player.Respawn()
	pass # Replace with function body.
