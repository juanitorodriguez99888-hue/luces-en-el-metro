extends Node2D

@export var level_index: int = 1
@export var level_name: String = "Nivel"

@onready var tile_map: TileMap = $TileMap
@onready var darkness: CanvasModulate = $CanvasModulate
@onready var lights_root: Node2D = $Luzes
@onready var player: CharacterBody2D = $Player

var level_completed: bool = false

func _ready() -> void:
	if Global.niveles_completados.has(level_index):
		_activate_lights()
	else:
		_disable_lights()
		if darkness != null:
			darkness.color = Color(0.12, 0.12, 0.18, 1.0)

func _disable_lights() -> void:
	for child in lights_root.get_children():
		if child is PointLight2D:
			child.enabled = false
			child.energy = 0.0

func _activate_lights() -> void:
	for child in lights_root.get_children():
		if child is PointLight2D:
			child.enabled = true
			var tween = create_tween()
			tween.tween_property(child, "energy", 1.5, 1.0)
	if tile_map != null:
		var t = create_tween()
		t.tween_property(tile_map, "modulate", Color(1.1, 1.0, 0.9), 1.5)
	if darkness != null:
		var t2 = create_tween()
		t2.tween_property(darkness, "color", Color(1.0, 1.0, 1.0), 2.0)

func complete_level() -> void:
	if level_completed:
		return
	level_completed = true
	Global.complete_level(level_index)
	_activate_lights()
