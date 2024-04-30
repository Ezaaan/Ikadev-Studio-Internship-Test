extends Node

const ITEMS: PackedStringArray = ["Cherry", "Gem", "Box", "Frog"]
var score: int = 0
var holdItem: String = ""
var player: CharacterBody2D = null

func _update_holditem(newItem: String):
	var panel: PanelContainer = Game.player.get_node("Camera2D").get_node("Panel")
	for item: Sprite2D in panel.get_children():
		if(item.name == newItem):
			item.visible = true
		else:
			item.visible = false
	print("Hold Item")
	holdItem = newItem
	print(holdItem)	

func _give_item():
	var panel: PanelContainer = Game.player.get_node("Camera2D").get_node("Panel")
	for item: Sprite2D in panel.get_children():
		item.visible = false
	holdItem = ""
