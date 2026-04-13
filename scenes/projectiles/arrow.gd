extends Node2D

@export var speed: float = 500
@export var damage: int = 30
var direction: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


# that for the hitboxes
func _on_area_2d_area_entered(area: Area2D) -> void:
	#needs refactoring to hitbox\hurbox 
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	# Cleanup when it leaves the screen so the game doesn't lag
	print("bullet left the screen")
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
