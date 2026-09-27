extends "res://scripts/LevelBase.gd"

@onready var dialogue_ui: CanvasLayer = $DialogueUI
@onready var marcos: CharacterBody2D = $Marcos
@onready var celular: Area2D = $Celular

var fotos_rotas: int = 0
var dialogo_terminado: bool = false

func _ready() -> void:
	level_index = 1
	level_name = "Soledad"
	super._ready()
	marcos.npc_name = "Marcos"
	marcos.can_talk = true
	if celular:
		celular.body_entered.connect(_on_celular_entered)
		celular.input_event.connect(_on_celular_input)
		print("Nivel 1 listo")

func _on_celular_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("Celular cerca")

func _on_celular_input(_viewport, event: InputEvent, _shape_idx) -> void:
	if event.is_action_pressed("interact"):
		if not dialogo_terminado:
			dialogue_ui.show_dialogue(["Marcos: ...déjame.", "El celular está roto, pero el recuerdo sigue ahí."], ["Debe doler mucho ver su contacto ahí", "¿Quieres hablar?", "Supéralo, hay más"], _on_dialog_choice)

func _on_dialog_choice(index: int) -> void:
	match index:
		0:
			Global.empatia_total += 1
			print("Empatía +1")
		1:
			print("Diálogo neutro")
		2:
			Global.empatia_total -= 1
			print("Empatía -1")
	dialogo_terminado = true
	dialogue_ui.show_dialogue(["Marcos: Gracias por no apurarme."], [])
	complete_level()
