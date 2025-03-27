extends Node

#@export (PackedScene) var mob_scene #V3 Godot
@export var mob_scene: PackedScene
var score = 0

func _ready() -> void:
	randomize()
	
func new_game():
	score = 0
	$HUD.update_score(score)
	
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition2D.position)
	
	
	$HUD.show_message("Get Ready...")
	$StartTimer.start()
	$Music.play()
	#yield($StartTimer, "timeout") #v3
	await($StartTimer.timeout)
	
	$ScoreTimer.start()
	$MobTimer.start()
	
	
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_gameover()
	$Music.stop()
	$DeathSound.play()

func _on_mob_timer_timeout() -> void:
	var mob_spawn_location = $MobPath/MobSpawnLocation
#	mob_spawn_location.offset = randf() * mob_spawn_location.path_length  # Random spot along the path length #V3
	var path_length = $MobPath.curve.get_baked_length()  # Calculate path length from parent Path2D 
	mob_spawn_location.progress = int(randf() * path_length)  # Assign random offset # a work around instead of v3 offset

	var mob = mob_scene.instantiate()
	add_child(mob)
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)
	


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
