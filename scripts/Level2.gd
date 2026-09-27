extends "res://scripts/LevelBase.gd"

@onready var dialogue_ui: CanvasLayer = $DialogueUI
@onready var luna: CharacterBody2D = $Luna

var acompanamiento_ok: bool = false
var respiracion_ok: bool = false

func _ready() -> void:
	level_index = 2
	level_name = "Ansiedad"
	super._ready()
	luna.npc_name = "Luna"
	luna.can_talk = false
	luna.speed = 60
	luna.walk_radius = 40
	print("Nivel 2 listo")

func _process(_delta: float) -> void:
	if !acompanamiento_ok and $Player.global_position.distance_to($Luna.global_position) < 30:
		acompanamiento_ok = true
		luna.can_talk = true
		dialogue_ui.show_dialogue(["Luna: Aún duele, pero hoy pude respirar."], [])
		complete_level()
