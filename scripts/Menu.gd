extends Node2D

@onready var play_button: Button = $PlayButton
@onready var credits_button: Button = $CreditsButton

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	credits_button.pressed.connect(_on_credits_pressed)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/selector_estaciones.tscn")

func _on_credits_pressed() -> void:
	print("Créditos: juego hecho con pasión, empatía y color.")
