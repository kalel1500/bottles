extends Control

@onready var btnNext = $Button

var pannels = {}
var puzzle = []

var example_dictionary = {
	1: {1:1,2:1,3:1,4:1},
	2: {1:2,2:2,3:2,4:2},
	3: {1:3,2:3,3:3,4:3},
	4: {1:4,2:4,3:4,4:4},
	5: {1:5,2:5,3:5,4:5},
	6: {1:6,2:6,3:6,4:6},
	7: {1:7,2:7,3:7,4:7},
	8: {1:8,2:8,3:8,4:8},
	9: {1:9,2:9,3:9,4:9},
	10: {1:10,2:10,3:10,4:10},
	11: {},
	12: {},
}
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

func print_puzzle_dictionary() -> void:
	self.print_puzzle(example_dictionary, false)




func creatr_puzzle() -> Dictionary:
	var puzzle = {}
	for n in range(10):
		var bottle = []

		while bottle.size() < 4:
			var num = rng.randi_range(1,10)
			if !bottle.has(num):
				bottle.push_back(num)

		var bottleDic = {}
		for key in range(4):
			bottleDic[key] = bottle[key]

		puzzle[n] = bottleDic

	puzzle[12] = {}
	puzzle[13] = {}
	return puzzle

func render_puzzle(puzzle: Dictionary):
	var posOriginal = Vector2(305, 100)
	var pos = posOriginal
	for key in puzzle:
		var bottle = puzzle[key]
		render_bottle(bottle, pos, key)
		if key == 5:
			pos.x = posOriginal.x
			pos.y += 200
		else:
			pos.x += 100

func render_bottle(bottle: Dictionary, position: Vector2, key: int):
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

	var reverse = bottle.values().duplicate()
	reverse.reverse()
	var joined_string = "\n".join(reverse)
	label.text = joined_string

func resolve_puzzle(puzzle: Dictionary):
	#var fillable2 = CollDictionary.new(example_dictionary)
	#fillable2.where()
	var testDic = {
		"one": {"name": "pepe"},
		"two": {"name": "juan"},
		"tree": {"name": "pepe"},
	}
	var test = CollDictionary.new(testDic)
	var tes2 = test.filter(func(item, key): return item.name == "pepe")
	print(tes2.value())

#	filled[0].pop_back()
#	fillable[0].push_back()


func _on_btnNext_pressed():
	var pannel = pannels[0]
	remove_child(pannel)
	var fistBottle = puzzle[0]
	fistBottle.erase(fistBottle.keys().back())
	render_bottle(puzzle[0], Vector2(pannel.position.x, pannel.position.y), 0)

