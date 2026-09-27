extends Node2D

@onready var nivel1_button: Button = $VBoxContainer/Nivel1
@onready var nivel2_button: Button = $VBoxContainer/Nivel2
@onready var nivel3_button: Button = $VBoxContainer/Nivel3

func _ready() -> void:
	_update_buttons()
	nivel1_button.pressed.connect(_go_to_level_1)
	nivel2_button.pressed.connect(_go_to_level_2)
	nivel3_button.pressed.connect(_go_to_level_3)

func _update_buttons() -> void:
	nivel1_button.disabled = !Global.is_level_unlocked(1)
	nivel2_button.disabled = !Global.is_level_unlocked(2)
	nivel3_button.disabled = !Global.is_level_unlocked(3)

func _go_to_level_1() -> void:
	get_tree().change_scene_to_file("res://scenes/nivel_1_soledad.tscn")

func _go_to_level_2() -> void:
	get_tree().change_scene_to_file("res://scenes/nivel_2_ansiedad.tscn")

func _go_to_level_3() -> void:
	get_tree().change_scene_to_file("res://scenes/nivel_3_presion.tscn")
