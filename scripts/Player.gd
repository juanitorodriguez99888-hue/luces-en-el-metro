extends CharacterBody2D

@export var speed: float = 100.0
@export var interaction_range: float = 40.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: Area2D = $InteractionArea
@onready var point_light: PointLight2D = $PointLight2D

var current_interactable: Node2D = null

func _ready() -> void:
	add_to_group("player")
	_setup_sprite_frames()
	point_light.enabled = true
	point_light.energy = 0.8
	point_light.texture_scale = 1.0

func _physics_process(_delta: float) -> void:
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input != Vector2.ZERO:
		velocity = input * speed
		sprite.play("walk")
		if input.x < 0:
			sprite.flip_h = true
		elif input.x > 0:
			sprite.flip_h = false
	else:
		velocity = Vector2.ZERO
		sprite.play("idle")
	move_and_slide()
	_update_interactable()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("interact"):
		if current_interactable != null:
			if current_interactable.has_method("interact"):
				current_interactable.interact(self)

func _update_interactable() -> void:
	var nearest: Node2D = null
	var closest_dist: float = INF
	for body in interaction_area.get_overlapping_bodies():
		if body.is_in_group("interactable"):
			var dist = global_position.distance_to(body.global_position)
			if dist < closest_dist:
				closest_dist = dist
				nearest = body
	current_interactable = nearest

func _setup_sprite_frames() -> void:
	if sprite.sprite_frames == null:
		var frames = SpriteFrames.new()
		frames.add_animation("idle")
		frames.add_animation("walk")
		for i in range(2):
			var image = Image.create(16, 16, false, Image.FORMAT_RGBA8)
			image.fill(Color(0.2, 0.5, 0.9, 1.0))
			if i == 1:
				image.fill(Color(0.35, 0.6, 0.95, 1.0))
			var tex = ImageTexture.create_from_image(image)
			frames.add_frame("idle", tex)
			frames.add_frame("walk", tex)
		sprite.sprite_frames = frames
		sprite.play("idle")
