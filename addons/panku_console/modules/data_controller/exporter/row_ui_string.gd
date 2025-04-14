extends "./row_ui.gd"

@export var name_label_2 : Label

@export var code_edit:CodeEdit
@export var revert_changed_button : Button
@export var submit_changed_button : Button
#@export var line_edit:LineEdit

var _last_update : String = "<none>"
var _is_update_done : bool = false

func get_ui_val() -> String: 
	return code_edit.text
	#return line_edit.text

func update_ui(val:String):
	code_edit.text = val
	#line_edit.text = val

func is_active() -> bool:
	return code_edit.has_focus() or revert_changed_button.has_focus() or submit_changed_button.has_focus()
	#return line_edit.has_focus()

func _ready():
	_last_update = get_ui_val()
	revert_changed_button.disabled = true
	name_label_2.text = name_label.text
	revert_changed_button.pressed.connect(
		func():
			if _last_update != "<none>":
				update_ui(_last_update)
				ui_val_changed.emit(get_ui_val())
				revert_changed_button.disabled = true
				_last_update = "<none>"
				
	)
	submit_changed_button.pressed.connect(
	#line_edit.text_submitted.connect(
		func():
			if not submit_changed_button.disabled:
				ui_val_changed.emit(get_ui_val())
				revert_changed_button.disabled = false
				submit_changed_button.disabled = true
	)
	code_edit.focus_exited.connect(
	#line_edit.focus_exited.connect(
		func():
			update_ui(get_ui_val())
	)
	code_edit.focus_entered.connect(
		func():
			_last_update = get_ui_val()
	)
	code_edit.text_changed.connect(
		func():
			submit_changed_button.disabled = false
			_is_update_done = false
	)
	code_edit.text_set.connect(
		func():
			submit_changed_button.disabled = get_ui_val() == _last_update
			_is_update_done = true
	)	
