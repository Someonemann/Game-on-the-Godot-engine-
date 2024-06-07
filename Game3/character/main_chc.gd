extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite_2d = %Sprite2D
@onready var collision_shape_2d = %CollisionShape2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_attacking = false

func _physics_process(delta):
	get_input()

	# Add the gravity.
	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction and not is_attacking:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if Input.is_action_just_pressed("Attack") and not is_attacking:
		is_attacking = true
		print ("attack")
		sprite_2d.play("attack")
		collision_shape_2d.disabled = false

func _on_sprite_2d_animation_finished():
	if sprite_2d.animation == "attack":
		collision_shape_2d.disabled = true
		print ("attack over")
		is_attacking = false
		sprite_2d.play("runing")

func get_input():
	pass # You can add custom input handling here if needed
