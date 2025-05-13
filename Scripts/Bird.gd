extends CharacterBody2D

@export var flap_strength: float = -300.0
@export var gravity: float = 800.0
@onready var anim = $AnimatedSprite2D
@onready var flap_sound = $FlapSound
@onready var score_sound = $ScoreSound
@onready var death_sound = $DeathSound

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = flap_strength
		flap_sound.play()

	velocity.y += gravity * delta
	move_and_slide()

	if position.y < -400:
		position.y = -400

func _ready():
	anim.play("default")


func _on_area_2d_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pipe"):
		death_sound.play()
		get_node("/root/Main").show_game_over()
	elif area.is_in_group("ScoreZone"):
		score_sound.play()
		get_node("/root/Main").add_score()
		area.queue_free()  # prevent double scoring
