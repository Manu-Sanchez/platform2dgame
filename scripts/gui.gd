extends CanvasLayer

func _process(_delta) -> void:
	$MarginContainer/Score.text = "SCORE: " + "%04d" % GLOBALS.score
	
func game_over() -> void:
	get_tree().paused = true
	
	$ColorRect/VBoxContainer/HBoxContainer/Retry.grab_focus()

	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($ColorRect/VBoxContainer/GameOver, "modulate", Color(1,1,1,0.8), 1.0)
	
	$Sounds/GameOver.play()

func _on_retry_pressed() -> void:
	print("retry")
	get_tree().reload_current_scene()

func _on_exit_pressed() -> void:
	get_tree().quit()
