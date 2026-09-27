extends CanvasLayer

@onready var panel: Panel = $Panel
@onready var text_label: RichTextLabel = $Panel/MarginContainer/VBoxContainer/Text
@onready var options_container: VBoxContainer = $Panel/MarginContainer/VBoxContainer/Options

var current_lines: Array = []
var current_options: Array = []
var on_finish: Callable = Callable()

func _ready() -> void:
	panel.visible = false

func show_dialogue(lines: Array, options: Array = [], finish_callback: Callable = Callable()) -> void:
	current_lines = lines
	current_options = options
	on_finish = finish_callback
	panel.visible = true
	_show_line(0)

func _show_line(index: int) -> void:
	if index >= current_lines.size():
		if current_options.size() > 0:
			_show_options()
		else:
			hide_dialogue()
			return
	text_label.text = str(current_lines[index])
	_clear_options()

func _show_options() -> void:
	_clear_options()
	for i in range(current_options.size()):
		var btn = Button.new()
		btn.text = current_options[i]
		btn.pressed.connect(_on_option_pressed.bind(i))
		options_container.add_child(btn)

func _clear_options() -> void:
	for child in options_container.get_children():
		child.queue_free()

func _on_option_pressed(index: int) -> void:
	_clear_options()
	if on_finish != Callable():
		on_finish.call(index)
	hide_dialogue()

func hide_dialogue() -> void:
	panel.visible = false
	if on_finish != Callable():
		on_finish = Callable()
