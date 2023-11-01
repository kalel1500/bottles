extends Control

@onready var btnNext = $Button

var pannels = {}
var puzzle = []

var exampe_mixed = [
	{"id":1, "colors": [{"id":1, "value": 1},{"id":2, "value": 1},{"id":3, "value": 1},{"id":4, "value": 1},]},
	{"id":2, "colors": [{"id":1, "value": 1},{"id":2, "value": 1},{"id":3, "value": 1},{"id":4, "value": 1},]},
	{"id":3, "colors": [{"id":1, "value": 1},{"id":2, "value": 1},{"id":3, "value": 1},{"id":4, "value": 1},]},
	{"id":4, "colors": [{"id":1, "value": 1},{"id":2, "value": 1},{"id":3, "value": 1},{"id":4, "value": 1},]},
	{"id":5, "colors": [{"id":1, "value": 1},{"id":2, "value": 1},{"id":3, "value": 1},{"id":4, "value": 1},]},
	{"id":6, "colors": [{"id":1, "value": 1},{"id":2, "value": 1},{"id":3, "value": 1},{"id":4, "value": 1},]},
	{"id":7, "colors": [{"id":1, "value": 1},{"id":2, "value": 1},{"id":3, "value": 1},{"id":4, "value": 1},]},
	{"id":8, "colors": [{"id":1, "value": 1},{"id":2, "value": 1},{"id":3, "value": 1},{"id":4, "value": 1},]},
	{"id":9, "colors": [{"id":1, "value": 1},{"id":2, "value": 1},{"id":3, "value": 1},{"id":4, "value": 1},]},
	{"id":10, "colors": [{"id":1, "value": 1},{"id":2, "value": 1},{"id":3, "value": 1},{"id":4, "value": 1},]},
	{"id":11, "colors": []},
	{"id":12, "colors": []},
]
var rng = RandomNumberGenerator.new()

func _ready():
	puzzle = creatr_puzzle()
	render_puzzle(puzzle)
	resolve_puzzle(puzzle)
	btnNext.pressed.connect(_on_btnNext_pressed)

func print_puzzle(iterable: Array) -> void:
	var result = []
	for bottle in iterable:
		for color in bottle.colors:
			var text = 'key: '+str(bottle.id)+'||'+'key2: '+str(color.id)+'||'+'value: '+str(color.value)
			result.push_back(text)
			print(text)



func creatr_puzzle() -> Array:
	var puzzle = []
	for n in range(10):
		var newBottleColors = []

		for n2 in range(4):
			var id = n2+1
			var num = rng.randi_range(1,10)
			var color = {"id": id, "value": num}
			newBottleColors.push_back(color)

		var bottle = {"id": n+1, "colors": newBottleColors}
		puzzle.push_back(bottle)

	puzzle.push_back({"id": 11, "colors": []})
	puzzle.push_back({"id": 12, "colors": []})

	return puzzle

func render_puzzle(puzzle: Array):
	var posOriginal = Vector2(305, 100)
	var pos = posOriginal
	for key in puzzle.size():
		var bottle = puzzle[key]
		render_bottle(bottle, pos)
		if key == 5:
			pos.x = posOriginal.x
			pos.y += 200
		else:
			pos.x += 100

func render_bottle(bottle: Dictionary, position: Vector2):
	var panel = Panel.new()
	var label = Label.new()
	self.add_child(panel)
	panel.add_child(label)
	pannels[bottle.id] = panel

	panel.size.x = 20
	panel.size.y = 110
	panel.position.x = position.x
	panel.position.y = position.y

	label.size.x = 10
	label.size.y = 110
	label.layout_mode = 1
	label.anchors_preset = PRESET_CENTER

	var colors = CollArray.new(bottle.colors)
	colors = colors.pluck('value').value()
	#var reverse = colors.duplicate()
	colors.reverse()
	var joined_string = "\n".join(colors)
	label.text = joined_string

func _filter_fillable_bootles(bottle: Dictionary):
	return bottle.colors.size() < 4

func _filter_filled_bootles(bottle: Dictionary):
	var colors: Array = bottle.colors
	var isNotCompleted = colors.size() < 4
	var isNotEmpty = colors.size() > 0
	var isNotResolved = colors.filter(func(color: Dictionary): return colors[0].value != color.value).size() > 0
	return isNotEmpty and (isNotCompleted || isNotResolved)

func _filter_resolved_bootles(bottle: Dictionary):
	var colors: Array = bottle.colors
	var isCompleted = colors.size() == 4
	var isResolved = colors.filter(func(color: Dictionary): return colors[0].value == color.value).size() == 4
	return isCompleted and isResolved

func resolve_puzzle(puzzle: Array):
	var fillable = puzzle.filter(_filter_fillable_bootles)
	fillable.sort_custom(func(a, b): return a.size() < b.size())
	var filled = puzzle.filter(_filter_filled_bootles)
	var resolved = puzzle.filter(_filter_resolved_bootles)
#	print(fillable)
#	print("-----------")
#	print(filled)
#	print("-----------")
#	print(resolved)

	print("-----------")
	for item in filled:
		print(item)
	print("-----------")
	for item in fillable:
		print(item)
	print("-----------")
	for item in resolved:
		print(item)


func _on_btnNext_pressed():
	var pannel = pannels[1]
	remove_child(pannel)
	puzzle[0].colors.pop_back()
	render_bottle(puzzle[0], Vector2(pannel.position.x, pannel.position.y))

