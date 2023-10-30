extends Node

func count_code_time(code: Callable) -> TimeRange:
	var start = Time.get_unix_time_from_system()
	code.call()
	var end = Time.get_unix_time_from_system()
	return TimeRange.new(start, end)
