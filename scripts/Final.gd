extends Node2D

@onready var replay_button: Button = $CenterContainer/Panel/VBoxContainer/ReplayButton
@onready var credits_button: Button = $CenterContainer/Panel/VBoxContainer/CreditsButton

func _ready() -> void:
	replay_button.pressed.connect(_on_replay_pressed)
	credits_button.pressed.connect(_on_credits_pressed)

func _on_replay_pressed() -> void:
	Global.reset_progress()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_credits_pressed() -> void:
	print("Créditos: diseño, música, iluminación y empatía.")
