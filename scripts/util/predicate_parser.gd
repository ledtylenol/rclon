class_name PredicateParser

static func get_predicate(object: Node, file: String) -> Dictionary:
	var i := 0
	var lines := FileAccess.open(file, FileAccess.READ).get_as_text().split('\n')
	var dict := {}
	for line in lines:
		line = line.strip_edges().strip_escapes()
	if lines[0][-2] != ':':
		return {}
	var current_key := lines[0].strip_escapes().substr(0, lines[0].strip_edges().length() - 1)
	dict[current_key] = []
	for line: String in lines:
		if line[-2] == ':':
			current_key = line.strip_escapes().substr(0, line.length() - 2)
			continue
		i = 0
		var x := ""
		var op_str := ""
		var y_str := ""
		while line[i] != ' ':
			print(line[i])
			x += line[i]
			i += 1
		i += 1
		while line[i] != ' ':
			op_str += line[i]
			i += 1
		i += 1
		while line[i] != ' ' and i < line.length() - 1:
			y_str += line[i]
			i += 1
		var y = str_to_var(y_str)
		var res: Callable
		match op_str:
			">":
				res = func() -> bool: return object.get(x) > y
			"<":
				res = func() -> bool: return object.get(x) < y
			">=":
				res = func() -> bool: return object.get(x) >= y
			"<=":
				res = func() -> bool: return object.get(x) <= y
			"!=":
				res = func() -> bool: return object.get(x) != y
		if not dict.has(current_key):
			dict[current_key] = [res]
		else:
			dict[current_key].append(res)
	return dict
