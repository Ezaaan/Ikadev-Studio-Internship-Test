extends Node2D

@onready
var dropdown = $PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/dropdown
@onready
var roleText: Label = $PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/RoleText
@onready
var descText: Label = $PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/DescriptionText
@onready
var skillCont: HBoxContainer = $PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/SkillContainer
var data = []

func _ready():
	# Read data from csv
	data = _read_csv("res://class.csv")
	
	#Set dropdown elements
	for item in data:
		dropdown.add_item(item[1], int(item[0]) - 1)
	
	# Set default data 
	_set_role_text()
	_set_desc_text()
	_set_skill_container()

# Returns data from csv file
func _read_csv(filepath: String):
	var file = FileAccess.open(filepath, FileAccess.READ)
	var csv = []
	while !file.eof_reached():
		var csv_rows = file.get_csv_line(",")
		csv.append(csv_rows)
	csv.remove_at(0)
	file.close()
	return csv
	
# Change role text
func _set_role_text():
	roleText.text = data[dropdown.get_selected_id()][1]

# Change description text
func _set_desc_text():
	descText.text = data[dropdown.get_selected_id()][2]
	
func _set_skill_container():
	# Clear the children
	for child in skillCont.get_children():
		skillCont.remove_child(child)
	
	# Configure StyleBoxLine for Separator
	var box_line: StyleBoxLine = StyleBoxLine.new()
	box_line.thickness = 2
	box_line.color = Color(255,255,255)
	box_line.grow_begin = 1
	box_line.grow_end = 1
	box_line.vertical = true
	
	# Create first separator
	var new_separator: VSeparator = VSeparator.new()
	
	# Add new skill text dynamically
	for skill in data[dropdown.get_selected_id()][3].split(";", false):
		#Add new skill text element
		var new_child: Label = Label.new()
		new_child.text = skill.strip_edges()
		new_child.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		new_child.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		new_child.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		skillCont.add_child(new_child)
		
		#Add new separator
		new_separator = VSeparator.new()
		new_separator.add_theme_stylebox_override("separator", box_line)
		skillCont.add_child(new_separator)
	# Remove final separator
	skillCont.remove_child(new_separator)

# Change contents
func _on_option_button_item_selected(index):
	_set_role_text()
	_set_desc_text()
	_set_skill_container()
