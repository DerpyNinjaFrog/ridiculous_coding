<<<<<<< HEAD
@tool
extends EditorPlugin

signal typing

# Scenes preloaded
const Boom: PackedScene = preload("res://addons/ridiculous_coding/boom.tscn")
const Blip: PackedScene = preload("res://addons/ridiculous_coding/blip.tscn")
const Newline: PackedScene = preload("res://addons/ridiculous_coding/newline.tscn")
const Dock: PackedScene = preload("res://addons/ridiculous_coding/dock.tscn")

# Inner Variables
const PITCH_DECREMENT := 2.0

var shake: float = 0.0
var shake_intensity:float  = 0.0
var timer: float = 0.0
var last_key: String = ""
var pitch_increase: float = 0.0
var editors = {}
var dock

func _enter_tree() -> void:
	var editor: EditorInterface = get_editor_interface()
	var script_editor: ScriptEditor = editor.get_script_editor()
	script_editor.editor_script_changed.connect(editor_script_changed)

	# Add the main panel
	dock = Dock.instantiate()
	typing.connect(dock._on_typing)
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, dock)

func _exit_tree() -> void:
	if dock:
		remove_control_from_docks(dock)
		dock.free()

func get_all_text_editors(parent : Node) -> void:
=======
tool
extends EditorPlugin

var shake = 0.0
var shake_intensity = 0.0
var timer = 0.0
var last_key = ""
var pitch_increase := 0.0
var editors = {}

const PITCH_DECREMENT := 2.0

const Boom = preload("boom.tscn")
const Blip = preload("blip.tscn")
const Newline = preload("newline.tscn")

const Dock = preload("res://addons/ridiculous_coding/dock.tscn")
var dock

signal typing


func _enter_tree():
	var editor = get_editor_interface()
	var script_editor = editor.get_script_editor()
	script_editor.connect("editor_script_changed", self, "editor_script_changed")

	# Add the main panel
	dock = Dock.instance()
	connect("typing", dock, "_on_typing")
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, dock)
	

func _exit_tree():
	if dock:
		remove_control_from_docks(dock)
		dock.free()
		

func get_all_text_editors(parent : Node):
>>>>>>> 956a8497f35508b47de4618367e87e6e17e8a05e
	for child in parent.get_children():
		if child.get_child_count():
			get_all_text_editors(child)
			
		if child is TextEdit:
<<<<<<< HEAD
			editors[child] = { 
				"text": child.text, 
				"line": child.get_caret_line() 
			}
			
			if child.caret_changed.is_connected(caret_changed):
				child.caret_changed.disconnect(caret_changed)
			child.caret_changed.connect(caret_changed.bind(child))
			
			if child.text_changed.is_connected(text_changed):
				child.text_changed.disconnect(text_changed)
			child.text_changed.connect(text_changed.bind(child))
			
			if child.gui_input.is_connected(gui_input):
				child.gui_input.disconnect(gui_input)
			child.gui_input.connect(gui_input)


func gui_input(event: InputEvent) -> void:
	# Get last key typed
	if event is InputEventKey and event.pressed:
		event = event as InputEventKey
		last_key = OS.get_keycode_string(event.get_keycode_with_modifiers())


func editor_script_changed(script) -> void:
=======
			editors[child] = { "text": child.text, "line": child.cursor_get_line() }
			
			if child.is_connected("cursor_changed", self, "cursor_changed"):
				child.disconnect("cursor_changed", self, "cursor_changed")
			child.connect("cursor_changed", self, "cursor_changed", [child])
				
			if child.is_connected("text_changed", self, "text_changed"):
				child.disconnect("text_changed", self, "text_changed")
			child.connect("text_changed", self, "text_changed", [child])

			if child.is_connected("gui_input", self, "gui_input"):
				child.disconnect("gui_input", self, "gui_input")
			child.connect("gui_input", self, "gui_input")


func gui_input(event):
	# Get last key typed
	if event is InputEventKey and event.pressed:
		event = event as InputEventKey
		last_key = OS.get_scancode_string(event.get_scancode_with_modifiers())
		

func editor_script_changed(script):
>>>>>>> 956a8497f35508b47de4618367e87e6e17e8a05e
	var editor = get_editor_interface()
	var script_editor = editor.get_script_editor()
	
	editors.clear()
	get_all_text_editors(script_editor)


<<<<<<< HEAD
func _process(delta: float) -> void:
	var script_editor = get_editor_interface().get_script_editor()
	if not script_editor.get_current_editor():
		return
	var base_editor = script_editor.get_current_editor().get_base_editor()
	
	if shake > 0:
		shake -= delta
		base_editor.position = Vector2(randf_range(-shake_intensity,shake_intensity), randf_range(-shake_intensity,shake_intensity))
#		editor.get_base_control().position = Vector2(randf_range(-shake_intensity,shake_intensity), randf_range(-shake_intensity,shake_intensity))
	else:
		base_editor.position = Vector2.ZERO
#		editor.get_base_control().position = Vector2.ZERO
	
=======
func _process(delta):
	var editor = get_editor_interface()
	
	if shake > 0:
		shake -= delta
		editor.get_base_control().rect_position = Vector2(rand_range(-shake_intensity,shake_intensity), rand_range(-shake_intensity,shake_intensity))
	else:
		editor.get_base_control().rect_position = Vector2.ZERO

>>>>>>> 956a8497f35508b47de4618367e87e6e17e8a05e
	timer += delta
	if (pitch_increase > 0.0):
		pitch_increase -= delta * PITCH_DECREMENT


<<<<<<< HEAD
func shake_screen(duration, intensity) -> void:
=======
func shake(duration, intensity):
>>>>>>> 956a8497f35508b47de4618367e87e6e17e8a05e
	if shake > 0:
		return
		
	shake = duration
	shake_intensity = intensity
<<<<<<< HEAD


func caret_changed(textedit) -> void:
=======
	
	
func cursor_changed(textedit):
>>>>>>> 956a8497f35508b47de4618367e87e6e17e8a05e
	var editor = get_editor_interface()
	
	if not editors.has(textedit):
		# For some reason the editor instances all change
		# when the file is saved so you need to reload them
		editors.clear()
		get_all_text_editors(editor.get_script_editor())
		
<<<<<<< HEAD
	editors[textedit]["line"] = textedit.get_caret_line()


func text_changed(textedit : TextEdit) -> void:
	var line_height = textedit.get_line_height()
	var pos = textedit.get_caret_draw_pos() + Vector2(0,-line_height/2.0)
	typing.emit()
=======
	editors[textedit]["line"] = textedit.cursor_get_line()


func text_changed(textedit : TextEdit):
	var editor = get_editor_interface()
	var settings = editor.get_editor_settings()
	
	if not editors.has(textedit):
		# For some reason the editor instances all change
		# when the file is saved so you need to reload them
		editors.clear()
		get_all_text_editors(editor.get_script_editor())
	
	# Get line and character count
	var line = textedit.cursor_get_line()
	var column = textedit.cursor_get_column()
	
	# Compensate for code folding
	var folding_adjustment = 0
	for i in range(textedit.get_line_count()):
		if i > line:
			break
		if textedit.is_line_hidden(i):
			folding_adjustment += 1

	# Compensate for tab size
	var tab_size = settings.get_setting("text_editor/indent/size")
	var line_text = textedit.get_line(line).substr(0,column)
	column += line_text.count("\t") * (tab_size - 1)

	# Compensate for scroll
	var vscroll = textedit.scroll_vertical
	var hscroll = textedit.scroll_horizontal
	
	# When you are scrolled to the bottom of a file
	# and you delete some lines from the bottom using Ctrl+X
	# then the vscroll can go down without changing the visible
	# scroll position. That throws off the calculation because
	# we're calculating the position from the lower position but
	# visually the position hasn't moved. By setting vscroll
	# to the new actual position, the editor moves the visible
	# lines to remove the gap. It changes the editor behavior
	# slightly for a better result.
	textedit.scroll_vertical = vscroll
	
	# Compensate for line spacing
	var line_spacing = settings.get_setting("text_editor/theme/line_spacing")
	
	# Load editor font
	var font : DynamicFont = DynamicFont.new()
	font.font_data = load(settings.get_setting("interface/editor/code_font"))
	font.size = settings.get_setting("interface/editor/code_font_size")
	var fontsize = font.get_string_size(" ")
	
	# Compensate for editor scaling
	var scale = editor.get_editor_scale()

	# Compute gutter width in characters
	var line_count = textedit.get_line_count()
	var gutter = str(line_count).length() + 6
	
	# Compute caret position
	var pos = Vector2()
	pos.x = (gutter + column) * fontsize.x * scale - hscroll
	pos.y = (line - folding_adjustment - vscroll) * (fontsize.y + line_spacing - 2) + 16
	pos.y *= scale
	
	emit_signal("typing")
>>>>>>> 956a8497f35508b47de4618367e87e6e17e8a05e
	
	if editors.has(textedit):
		# Deleting
		if timer > 0.1 and len(textedit.text) < len(editors[textedit]["text"]):
			timer = 0.0
			
			if dock.explosions:
				# Draw the thing
<<<<<<< HEAD
				var thing = Boom.instantiate()
=======
				var thing = Boom.instance()
>>>>>>> 956a8497f35508b47de4618367e87e6e17e8a05e
				thing.position = pos
				thing.destroy = true
				if dock.chars: thing.last_key = last_key
				thing.sound = dock.sound
				textedit.add_child(thing)
				
				if dock.shake:
					# Shake
<<<<<<< HEAD
					shake_screen(0.2, 10)
		
		# Typing
		if timer > 0.02 and len(textedit.text) >= len(editors[textedit]["text"]):
			timer = 0.0
			
			# Draw the thing
			var thing = Blip.instantiate()
=======
					shake(0.2, 10)

		# Typing
		if timer > 0.02 and len(textedit.text) >= len(editors[textedit]["text"]):
			timer = 0.0

			# Draw the thing
			var thing = Blip.instance()
>>>>>>> 956a8497f35508b47de4618367e87e6e17e8a05e
			thing.pitch_increase = pitch_increase
			pitch_increase += 1.0
			thing.position = pos
			thing.destroy = true
			thing.blips = dock.blips
			if dock.chars: thing.last_key = last_key
			thing.sound = dock.sound
			textedit.add_child(thing)
			
			if dock.shake:
				# Shake
<<<<<<< HEAD
				shake_screen(0.05, 5)
			
		# Newline
		if textedit.get_caret_line() != editors[textedit]["line"]:
			# Draw the thing
			var thing = Newline.instantiate()
=======
				shake(0.05, 5)
			
		# Newline
		if textedit.cursor_get_line() != editors[textedit]["line"]:
			# Draw the thing
			var thing = Newline.instance()
>>>>>>> 956a8497f35508b47de4618367e87e6e17e8a05e
			thing.position = pos
			thing.destroy = true
			thing.blips = dock.blips
			textedit.add_child(thing)
			
			if dock.shake:
				# Shake
<<<<<<< HEAD
				shake_screen(0.05, 5)
	
	editors[textedit]["text"] = textedit.text
	editors[textedit]["line"] = textedit.get_caret_line()
=======
				shake(0.05, 5)

	editors[textedit]["text"] = textedit.text
	editors[textedit]["line"] = textedit.cursor_get_line()
>>>>>>> 956a8497f35508b47de4618367e87e6e17e8a05e
