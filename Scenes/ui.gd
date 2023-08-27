extends CanvasLayer

class_name  UI

const MAX_TIMER_VALUE = 30

signal timer_runs_out

@onready var lifes_container = %LifesContainer
@onready var timeout_timer = $TimeoutTimer
@onready var progress_bar = %ProgressBar
@onready var center_container = $MarginContainer/CenterContainer
@onready var game_result_label = %GameResultLabel
@onready var panel_container = $MarginContainer/CenterContainer/PanelContainer


var life_texture = preload("res://Assets/FroggerIdle.png")
var lifes_textures: Array[TextureRect] = []

func set_lives(lives_amount: int):
	for i in lives_amount:
		var texture_rect = TextureRect.new()
		texture_rect.custom_minimum_size = Vector2(32, 16)
		texture_rect.texture = life_texture
		texture_rect.texture_filter = TextureRect.TEXTURE_FILTER_NEAREST
		lifes_container.add_child(texture_rect)
		lifes_textures.append(texture_rect)

func _ready():
	timeout_timer.timeout.connect(on_timeout)
	timeout_timer.start()
	
func on_timeout():
	var new_progress_bar_value = progress_bar.value - 1
	progress_bar.set_value(new_progress_bar_value)
	if new_progress_bar_value == 0:
		timer_runs_out.emit()
		timeout_timer.stop()

func reset_timer():
	progress_bar.set_value(MAX_TIMER_VALUE)
	timeout_timer.start()

func loose_life():
	var life_texture = lifes_textures.pop_back()
	life_texture.queue_free()

func show_lose_ui():
	timeout_timer.stop()
	panel_container.theme_type_variation = "PanelContainerRed"
	game_result_label.text = "You lost!"
	center_container.show()

func show_win_ui():
	timeout_timer.stop()
	game_result_label.text = "You won!"
	center_container.show()

func _on_button_pressed():
	get_tree().reload_current_scene()
