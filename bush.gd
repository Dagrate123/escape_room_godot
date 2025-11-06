extends Node2D
 
var hand_cursor = preload("res://main room/Micro Icon Pack/Computer Systems/1. Pointer.png")
var on_cursor = preload("res://main room/Micro Icon Pack/Computer Systems/3. Hand Hover.png")
 
var inside_dropable = false
 
func _ready() -> void:
	Input.set_custom_mouse_cursor(hand_cursor) #setter hånda til custom 
 
func change_cursor_hand():
	Input.set_custom_mouse_cursor(on_cursor) #endrer cursor
	scale = Vector2(1.05, 1.05) #gjør den større
	inside_dropable = true #og den detecter at musen er inni dropable
 
func change_cursor_back():
	Input.set_custom_mouse_cursor(hand_cursor)
	scale = Vector2(1, 1)
	inside_dropable = false
		 
 
func _input(event: InputEvent) -> void: #når du klikker så fjernes busken
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if inside_dropable:
			queue_free()
 
