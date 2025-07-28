extends CharacterBody2D
class_name Player

var axis: Vector2 = Vector2.ZERO
var death: bool = false

@export_category("⚙️ Config")
@export_group("Required References")
@export var gui: CanvasLayer

@export_group("Motion")
@export var speed: int = 128
@export var gravity: int = 16
@export var jump: int = 368

func _process(_delta: float) -> void:
	match death:
		true:
			death_ctrl()
		false:
			motion_ctrl()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if not death and is_on_floor():
			jump_ctrl(1)


func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis.normalized()

func death_ctrl() -> void:
	velocity.x = 0
	velocity.y += gravity
	
	move_and_slide()


func motion_ctrl() -> void:
	
	#Get axis, return 1, 0, -1 depending on the input 
	#With these lines, we will change the orientation of the player
	if get_axis().x != 0:
		$Sprite.scale.x = get_axis().x
		
	velocity.x = get_axis().x * speed
	velocity.y += gravity
	
	move_and_slide()
	
	match is_on_floor():
		true: 
			if get_axis().x != 0:
				$Sprite.set_animation("Run")
			else:
				$Sprite.set_animation("Idle")
				
		false:
			if get_axis().y < 0:
				$Sprite.set_animation("Jump")
			else:
				$Sprite.set_animation("Fall")


func jump_ctrl(power: int) -> void:
	velocity.y = -jump * power
	$Sounds/Jump.play()

func damage_ctrl() -> void:
	death = true
	$Sprite.set_animation("Death")


func _on_hit_point_body_entered(body: Node2D) -> void:
	print(velocity.y)
	if body is Enemy and velocity.y >= 0:
		$Sounds/Hit.play()
		body.damage_ctrl(1)
		jump_ctrl(0.5)

func _on_sprite_animation_finished():
	if $Sprite.animation == "Death":
		gui.game_over()
