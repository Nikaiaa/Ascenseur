extends Node3D

@onready var character
var raycast
var texture
var cursor_hand = preload("res://UI/Cursor.png")
var cursor_default = preload("res://UI/Cursor_Default.png") 
signal button_pressed 
# Called when the node enters the scene tree for the first time.
func _ready():
	character = $Character
	raycast = character.get_node("CharacterBody3D/Rotation/Camera3D/RayCast3D")
	texture = character.get_node("CharacterBody3D/Rotation/Camera3D/TextureRect")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if raycast.is_colliding(): 
		var collider = raycast.get_collider()
		texture.texture = cursor_hand
		if collider.is_in_group("Test"):
			button_pressed.emit()
		else:
			pass
	else: 
		texture.texture = cursor_default
		
