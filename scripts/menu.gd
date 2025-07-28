extends Control

func _ready() -> void:
	%Iniciar.grab_focus()

func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
