extends CanvasLayer

signal start_game


func update_score(score):
	$scoreLabel.text = str(score)
	
func show_message(text):
	$messageLabel.text = text 
	$messageLabel.show()
	$messageTimer.start()
	
func show_gameover():
	show_message("Game Over")
	await $messageTimer.timeout
	$messageLabel.text = "Dodge The Creeps"
	$messageLabel.show()
	await get_tree().create_timer(1.0).timeout
	$Button.show()	


func _on_button_pressed() -> void:
	$Button.hide()
	emit_signal("start_game")

func _on_message_timer_timeout() -> void:
	$messageLabel.hide()
