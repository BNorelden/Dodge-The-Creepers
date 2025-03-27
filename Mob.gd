extends RigidBody2D

@export var min_speed = 150.0
@export var max_speed = 250.0


func _ready() -> void:
	#randomize()
	#print($AnimatedSprite2D.sprite_frames.get_animation_names())
	
	# frames no longer exist and ai said its sprite_frames instead of frames 3 hrs on this
	#print($AnimatedSprite2D.frames.get_animation_names())
	$AnimatedSprite2D.play
	#var mob_types = $AnimatedSprite2D.frames.get_animation_name() # V3
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names() # V4
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
