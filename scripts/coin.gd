extends Area2D

func _on_coin_finished() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$Sprite.set_animation("Off")
		$Coin.play()
		
		GLOBALS.score += 1
