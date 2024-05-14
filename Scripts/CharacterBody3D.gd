extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var MOUSE_SENSITIVITY = 0.3
var rotation_helper
var camera
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	camera = $Rotation/Camera3D
	rotation_helper = $Rotation
	

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event):
	#si la souris bouge et qu'elle est capturée
	if event is InputEventMouseMotion : #and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED: 
		rotation_helper.rotate_x(deg_to_rad(event.relative.y * -MOUSE_SENSITIVITY))#rotate la caméra en y d'abord
		self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))#puis en x
				
		#on bloque la rota verticale à 50° pour pas se dévisser la nuque
		var camera_rot = rotation_helper.rotation_degrees 
		camera_rot.x = clamp(camera_rot.x, -50, 50)
		rotation_helper.rotation_degrees = camera_rot
