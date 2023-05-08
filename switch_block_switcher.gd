@tool
extends StaticBumpingBlock

@export_category("Switch Block")
@export_group("General")
@export var id: int = 0:
	set(to):
		id = to
		if Engine.is_editor_hint() || (!Engine.is_editor_hint() && _is_ready):
			shader.set_shader_parameter(&"hue", wrapf(float(id) * 0.02, -1, 1))

@onready var _is_ready: bool = true
@onready var shader: ShaderMaterial = $AnimatedSprite2D.material


func _physics_process(_delta) -> void:
	if Engine.is_editor_hint(): return
	super(_delta)
	
	if _triggered: return
	
	var player = Thunder._current_player
	if is_player_colliding(cast_below) && player.speed.y <= 50 && !player.is_on_floor():
		bump(false)
		for i in get_tree().get_nodes_in_group("switch_" + str(id)):
			if i.has_method(&"switch"): i.switch()
