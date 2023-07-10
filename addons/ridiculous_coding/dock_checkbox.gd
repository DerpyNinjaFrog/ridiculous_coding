@tool
extends CheckButton

@export var type : String = 'explosions'

signal checkbox_toggled(checkbox, toggled)

func _ready() -> void:
	toggled.connect(_on_toggled)

func _on_toggled(toggled: bool) -> void:
	checkbox_toggled.emit(type, toggled)
