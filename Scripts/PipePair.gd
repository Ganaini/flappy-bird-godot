extends Node2D

@export var speed: float = 200.0

func _process(delta: float) -> void:
	position.x -= speed * delta

	if position.x < -800:
		queue_free()

func _ready():
	$ScoreZone.body_entered.connect(_on_score_zone_entered)

func _on_score_zone_entered(body):
	print("SCORE ZONE TRIGGERED by: ", body)
	if body.name == "CharacterBody2D":
		get_node("/root/Main").add_score()
		$ScoreZone.queue_free()  # Prevent scoring twice
  
