extends Area2D
#Areej _ s

func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "MaskDude":
		print("Game Over")
		
		get_tree().reload_current_scene()

func _ready() -> void:
	pass 



func _process(delta: float) -> void:
	pass
