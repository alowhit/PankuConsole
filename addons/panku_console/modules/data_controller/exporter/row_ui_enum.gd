extends "./row_ui.gd"

@export var opt_btn:OptionButton

func update_ui(val):
	opt_btn.select(val)

func is_active():
	return opt_btn.has_focus()

func _ready():
	opt_btn.item_selected.connect(
		func(index:int):
			ui_val_changed.emit(index)
	)
	
	# wtf, transparent background is a mess
	var popup := opt_btn.get_popup()
	popup.transparent_bg = true
	popup.transparent = true

func setup(params := []):
	opt_btn.clear()
	for i : int in params.size():
		var split = params[i].split(":", false)

		# If key-value pair.
		if split.size() > 1 and split[1].is_valid_int():
			opt_btn.add_item(params[i], split[1].to_int())
		else:
			opt_btn.add_item(params[i], i)
