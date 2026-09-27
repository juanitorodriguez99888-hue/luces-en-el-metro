extends Node

var niveles_desbloqueados: Array = [1]
var niveles_completados: Array = []
var empatia_total: int = 0

func _ready() -> void:
	pass

func reset_progress() -> void:
	niveles_desbloqueados = [1]
	niveles_completados = []
	empatia_total = 0

func complete_level(level_index: int) -> void:
	if !niveles_completados.has(level_index):
		niveles_completados.append(level_index)
	if !niveles_desbloqueados.has(level_index + 1):
		niveles_desbloqueados.append(level_index + 1)

func unlocks(level_index: int) -> bool:
	return niveles_desbloqueados.has(level_index)
