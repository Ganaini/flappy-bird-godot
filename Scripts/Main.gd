extends Node2D

@onready var bird: CharacterBody2D = $CharacterBody2D
@onready var pipe_container: Node = $PipeContainer
@export var pipe_scene: PackedScene
@export var spawn_time: float = 2.0
@export var pipe_y_variation: float = 100.0
@onready var parallax_bg = $ParallaxBackground

var time_passed: float = 0.0
var score: int = 0

func _process(delta: float) -> void:
	time_passed += delta
	if time_passed >= spawn_time:
		spawn_pipe()
		time_passed = 0.0
	parallax_bg.scroll_offset.x -= 50 * delta  # adjust speed as needed
 
func spawn_pipe():
	var pipe = pipe_scene.instantiate()
	pipe.position = Vector2(600, randf_range(200.0 - pipe_y_variation, 200.0 + pipe_y_variation))
	pipe_container.add_child(pipe)

func _on_Bird_body_entered(body):
	if body.is_in_group("Pipe"):
		show_game_over()  

func show_game_over():
	$GameOverUI.visible = true
	Engine.time_scale = 0.0  # freezes gameplay but keeps UI interactive

func _on_restart_pressed() -> void:
	Engine.time_scale = 1.0  # resume game speed
	get_tree().reload_current_scene()

func _ready():
	# (Optional: reset time scale on scene reload just in case)
	Engine.time_scale = 1.0
	score = 0
	$ScoreLabel.text = "Score: %d" % score

func add_score():
	score += 1
	print("Score is now: ", score)
	$ScoreLabel.text = "Score: %d" % score
