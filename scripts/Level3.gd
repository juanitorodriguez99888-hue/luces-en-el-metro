extends "res://scripts/LevelBase.gd"

@onready var dialogue_ui: CanvasLayer = $DialogueUI

var cajas_entregadas: int = 0

func _ready() -> void:
	level_index = 3
	level_name = "Presión"
	super._ready()
	print("Nivel 3 listo")

func _on_caja_entregada(nombre: String) -> void:
	match nombre:
		"ESCUELA":
			dialogue_ui.show_dialogue(["Eso es muchísima presión para una sola persona."], [])
		"CASA":
			dialogue_ui.show_dialogue(["Debe ser muy difícil escuchar eso en casa."], [])
		"EQUIPO":
			dialogue_ui.show_dialogue(["Tiene sentido que te canses de ser siempre el fuerte."], [])
	cajas_entregadas += 1
	if cajas_entregadas >= 3:
		dialogue_ui.show_dialogue(["Marcos y Luna aparecen para ayudarte. La red de apoyo ya está aquí."], [])
		complete_level()

func _process(_delta: float) -> void:
	if $CajaEscuela and $CajaEscuela.overlaps_body($Player):
		_on_caja_entregada("ESCUELA")
	if $CajaCasa and $CajaCasa.overlaps_body($Player):
		_on_caja_entregada("CASA")
	if $CajaEquipo and $CajaEquipo.overlaps_body($Player):
		_on_caja_entregada("EQUIPO")
