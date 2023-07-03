class_name DataStructures
extends Node
# i just wanted a circle buffer but i copied it from a CS course and i now feel like shit so 
# now there's more






class CircleBuffer:
	
	var front :int
	var back : int
	var size :int
	
	var data :Array
	
	
	func _init(dsize:int):
		data.resize(dsize)
	
	
	func is_full():
		return size == len(data)
	
	func add(item):
		front += 1
		if front  > len(data) - 1:
			front = 0
			if back < len(data) - 2:
				back += 1
		if back > len(data) - 1:
			back = 0
		
		data[front] = item
		
		if is_full():
			back += 1
		if size < len(data):
			size += 1
	
	func get_first_element():
		return data[front]

	func remove_back():
		if back >= data.size()-1:
			back = 0
		
		var item = data[back]
		
		if item != null:
			data[back] = null
			back = 0

	func _to_string():
		return str(data)
		
	func clear():
		for i in range(data.size()):data[i] = null



class LinkedList:
	var size :int = 1
	var start :LinkedData= LinkedData.new()

	func get_element(idx:int):
		var list_element := start
		var traversal_index = 0
		while true:
			if list_element == null:return
			
			if traversal_index == idx:return list_element.data		
			list_element = list_element.next
			traversal_index += 1
			
			
	func add_at(data,idx:int):
		var elem = LinkedData.new()
		var previous_start :LinkedData =start
		elem.data = data
		
		
		# special case to replace the first element
		if idx == 0:
			if start.data != null:
				start = insert_before(start,data)
			else:
				start.data = data
			return
			
		var traversal_idx = 0
		
		var current_node := start
		while true:
		
			if traversal_idx == idx:
				insert_after(current_node,data)
				return
		
			if current_node.next == null:
				insert_after(current_node,null)
		
			traversal_idx += 1
			current_node = current_node.next
	
	
	func insert_before(node:LinkedData,data):
		var nodeb :LinkedData= LinkedData.new()
		
		nodeb.previous = node.previous
		
		if node.previous:
			node.previous.next = nodeb
		nodeb.next = node
		nodeb.data = data
		
		size += 1
		return nodeb

	func insert_after(node:LinkedData,data):
		var nodeb :LinkedData= LinkedData.new()
		nodeb.data = data
		
		
		nodeb.previous = node
		if node.next:
			nodeb.next = node.next
			node.next.previous = nodeb
			
		node.next = nodeb

		
		size += 1
		return nodeb
			

			
			





		
		
	
	
	
	func _to_string():
		var strr = "["
		
		var element := start
		while true:
			if element != start:
				strr = str(strr,",")
				
			strr = str(strr,element.data)
			element = element.next
			
			if element ==null:
				break
		
		return str(strr,"]")
		
		pass
		
		
	
class LinkedData:
	var next :LinkedData
	var previous :LinkedData
	var data 
	

	
	
	
