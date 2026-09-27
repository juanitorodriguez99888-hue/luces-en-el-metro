extends CharacterBody2D

@export var npc_name: String = "NPC"
@export var can_talk: bool = true
@export var walk_radius: float = 0.0
@export var speed: float = 0.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label

var base_position: Vector2 = Vector2.ZERO
var is_talking: bool = false

func _ready() -> void:
	add_to_group("interactable")
	base_position = global_position
	_setup_sprite_frames()
	if label != null:
		label.text = npc_name

func _physics_process(_delta: float) -> void:
	if walk_radius > 0 and speed > 0:
		var t = Time.get_ticks_msec() / 1000.0
		var offset = Vector2(
			cos(t * speed / 10.0) * walk_radius,
			sin(t * speed / 10.0 * 1.3) * walk_radius
		)
		global_position = base_position + offset

func interact(_player: Node) -> void:
	if !can_talk:
		return
	if is_talking:
		return
	is_talking = true
	print("NPC interactuado: ", npc_name)
	# Esta lógica la completan los niveles específicos.

func _setup_sprite_frames() -> void:
	if sprite.sprite_frames == null:
		var frames = SpriteFrames.new()
		frames.add_animation("idle")
		frames.add_animation("walk")
		for i in range(2):
			var image = Image.create(16, 16, false, Image.FORMAT_RGBA8)
			image.fill(Color(0.8, 0.8, 0.9, 1.0))
			if i == 1:
				image.fill(Color(0.6, 0.7, 0.9, 1.0))
			var tex = ImageTexture.create_from_image(image)
			frames.add_frame("idle", tex)
			frames.add_frame("walk", tex)
		sprite.sprite_frames = frames
		sprite.play("idle")
