extends Control

@onready var btnNext = $Button

var pannels = {}
var puzzle = []

var example_array = [
		[1,1,1,1],
		[2,2,2,2],
		[3,3,3,3],
		[4,4,4,4],
		[5,5,5,5],
		[6,6,6,6],

		[7,7,7,7],
		[8,8,8,8],
		[9,9,9,9],
		[10,10,10,10],
		[0,0,0,0],
		[0,0,0,0],
	]

var rng = RandomNumberGenerator.new()

func _ready():
	puzzle = creatr_puzzle()
	render_puzzle(puzzle)
	resolve_puzzle(puzzle)
	btnNext.pressed.connect(_on_btnNext_pressed)


func print_puzzle(iterable, isArray: bool) -> void:
	var iterable1 = range(iterable.size()) if isArray else iterable
	var result = []
	for key in iterable1:
		var iterable2 = range(iterable[key].size()) if isArray else iterable[key]
		for key2 in iterable2:
			var text = 'key: '+str(key)+'||'+'key2: '+str(key2)+'||'+'value: '+str(iterable[key][key2])
			result.push_back(text)
			print(text)

func print_puzzle_array() -> void:
	self.print_puzzle(example_array, true)




func creatr_puzzle() -> Array:
	var puzzle = [[],[]]
	for n in range(10):
		var bottle = []

		while bottle.size() < 4:
			var num = rng.randi_range(1,10)
			if !bottle.has(num):
				bottle.push_back(num)

		puzzle.push_front(bottle)

	return puzzle

func render_puzzle(puzzle: Array):
	var posOriginal = Vector2(305, 100)
	var pos = posOriginal
	for key in puzzle.size():
		var bottle = puzzle[key]
		render_bottle(bottle, pos, key)
		if key == 5:
			pos.x = posOriginal.x
			pos.y += 200
		else:
			pos.x += 100

func render_bottle(bottle: Array, position: Vector2, key: int):
	var panel = Panel.new()
	var label = Label.new()
	self.add_child(panel)
	panel.add_child(label)
	pannels[key] = panel

	panel.size.x = 20
	panel.size.y = 110
	panel.position.x = position.x
	panel.position.y = position.y

	label.size.x = 10
	label.size.y = 110
	label.layout_mode = 1
	label.anchors_preset = PRESET_CENTER

	var reverse = bottle.duplicate()
	reverse.reverse()
	var joined_string = "\n".join(reverse)
	label.text = joined_string

func _filter_fillable_bootles(bottle: Array):
	return bottle.size() < 4

func _filter_filled_bootles(bottle: Array):
	return bottle.size() > 0

func _filter_resolved_bootles(bottle: Array):
	return bottle.size() == 4 && bottle.filter(func(color: int): return bottle[0] == color).size() == 4

func resolve_puzzle(puzzle: Array):
	var fillable = puzzle.filter(_filter_fillable_bootles)
	fillable.sort_custom(func(a, b): return a.size() < b.size())
	var filled = puzzle.filter(_filter_filled_bootles)
	var resolvedBottles = filled.filter(_filter_resolved_bootles)
	print(fillable)
	print(filled)
	print(resolvedBottles)
#	filled[0].pop_back()
#	fillable[0].push_back()


func _on_btnNext_pressed():
	var pannel = pannels[0]
	remove_child(pannel)
	puzzle[0].pop_back()
	render_bottle(puzzle[0], Vector2(pannel.position.x, pannel.position.y), 0)

