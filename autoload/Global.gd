extends Node

var niveles_desbloqueados: Array = [1]
var niveles_completados: Array = []
var empatia_total: int = 0
var current_level_name: String = ""

func reset_progress() -> void:
	niveles_desbloqueados = [1]
	niveles_completados = []
	empatia_total = 0

func unlock_next_level(level_index: int) -> void:
	if !niveles_desbloqueados.has(level_index + 1):
		niveles_desbloqueados.append(level_index + 1)

func complete_level(level_index: int) -> void:
	if !niveles_completados.has(level_index):
		niveles_completados.append(level_index)
		unlock_next_level(level_index)

func is_level_unlocked(level_index: int) -> bool:
	return niveles_desbloqueados.has(level_index)

func get_level_scene(level_index: int) -> String:
	match level_index:
		1:
			return "res://scenes/nivel_1_soledad.tscn"
		2:
			return "res://scenes/nivel_2_ansiedad.tscn"
		3:
			return "res://scenes/nivel_3_presion.tscn"
		_:
			return "res://scenes/final.tscn"
