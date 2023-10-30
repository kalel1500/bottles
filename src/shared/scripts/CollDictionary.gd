class_name CollDictionary

var dictionary: Dictionary

func _init(dictionary: Dictionary) -> void:
	self.dictionary = dictionary

func value():
	return self.dictionary

func where(field: String, value: String) -> CollDictionary:
	var filtered := {}
	for key in self.dictionary:
		if self.dictionary[key] == value:
			filtered[key] = self.dictionary[key]

	return get_script().new(filtered)

func filter(callback: Callable):
	var filtered := {}
	for key in self.dictionary:
		if callback.call(self.dictionary[key], key):
			filtered[key] = self.dictionary[key]

	return get_script().new(filtered)
