extends Node2D
 
var hand_cursor = preload("res://main room/Micro Icon Pack/Computer Systems/1. Pointer.png")
var on_cursor = preload("res://main room/Micro Icon Pack/Computer Systems/3. Hand Hover.png")
 
var draggable = false
var inside_dropable = false
var body_ref: Node2D
var offset: Vector2
var initialPos: Vector2

func _ready() -> void:
	Input.set_custom_mouse_cursor(hand_cursor)
 
func _process(_delta: float) -> void:
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
			print("start_dragging")
 
		elif Input.is_action_pressed("click") and Global.is_dragging:
			global_position = get_global_mouse_position() - offset
			print("følger etter musen")
 
		elif Input.is_action_just_released("click") and Global.is_dragging:
			Global.is_dragging = false
			print("released")
			var tween = get_tree().create_tween()
			print("tweening")
 
			if inside_dropable and body_ref:
				tween.tween_property(self, "global_position", body_ref.global_position, 0.2).set_ease(Tween.EASE_OUT)
				print("jeg er på plass")
				queue_free()
				change_cursor_back()
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)
				print("jeg er tilbake")
 
 
func change_cursor_hand():
	Input.set_custom_mouse_cursor(on_cursor)
	if not Global.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)
 
 
func change_cursor_back():
	Input.set_custom_mouse_cursor(hand_cursor)
	if not Global.is_dragging:
		draggable = false
		scale = Vector2(1, 1)
 
 
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("oh yeah")
 
 
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		inside_dropable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_ref = body
 
 
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		inside_dropable = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
