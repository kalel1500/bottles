class_name CollArray

var array: Array

func _init(array: Array) -> void:
	self.array = array

func value():
	return self.array

func where(field: String, value: String) -> CollArray:
	var filtered := []
	for item in self.array:
		if item[field] == value:
			filtered.append(item)

	return get_script().new(filtered)

func whereObj(obj: Dictionary) -> CollArray:
	var filtered := []
	for item in self.array:
		var is_matching = true # Assume an entry matches the filter

		for key in obj.keys():
			if item[key] != obj[key]:
				is_matching = false
				break # Stop checking on first mismatch

		if is_matching:
			filtered.append(item)

	return get_script().new(filtered)

func pluck(field: String) -> CollArray:
	var plucked := []
	for item in self.array:
		plucked.append(item[field])

	return get_script().new(plucked)
