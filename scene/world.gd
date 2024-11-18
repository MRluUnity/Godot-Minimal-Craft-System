#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
extends Node2D

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量
const THREE = preload("res://resource/craft_tables/three.tres")
const BAG = preload("res://resource/bag/bag.tres")
const SLOT = preload("res://scene/slot.tscn")
#endregion

# TODO name ===============>变 量<===============
#region 变量
@onready var craft_grid_container: GridContainer = %CraftGridContainer
@onready var bag_grid_container: GridContainer = %BagGridContainer
@onready var dragged_slot: Slot = %DraggedSlot
var craft_table : Dictionary = {}
var bag_table : Array
var dragged_item : BaseItem:
	set(v):
		dragged_item = v
		dragged_slot.reset_slot()
		dragged_slot.hide()
		if dragged_item:
			dragged_slot.show()
			dragged_slot.set_slot(dragged_item.texture, dragged_item.item_name)
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	craft_table = THREE.craft_table_dic
	bag_table = BAG.bag_items

	for i : Slot in craft_grid_container.get_children():
		i.chick_slot.connect(_on_craft_chick_slot)
	for i in bag_table.size():
		var slot : Slot = SLOT.instantiate()
		bag_grid_container.add_child(slot)
		slot.chick_slot.connect(_on_bag_chick_slot)
		slot.item = bag_table[i]
	print(craft_table)


func _process(_delta: float) -> void:
	dragged_slot.global_position = get_global_mouse_position() + Vector2(16, 16)

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法
func _on_button_pressed() -> void:
	var index : Array[int]
	var craft : Array[String]
	var number : int = 0
	for i : Slot in craft_grid_container.get_children():
		if i.item == null:
			number += 1
			continue
		craft.append(i.item.item_name)
		if not craft.is_empty():
			index.append(number)
			number = 0
	index.pop_front()
	index.append(-1)

	print(index)
	print(craft)

	if craft_table.find_key({"位码" : index, "配方" : craft}):
		create_label("成功合成")

func _on_craft_chick_slot(slot_index : int) -> void:
	var slot : Slot = craft_grid_container.get_child(slot_index)
	var current_item : BaseItem
	if dragged_item:
		current_item = dragged_item
	dragged_item = slot.item
	if current_item:
		slot.item = current_item
	else :
		slot.item = null

func _on_bag_chick_slot(slot_index : int) -> void:
	var slot : Slot = bag_grid_container.get_child(slot_index)
	var current_item : BaseItem
	if dragged_item:
		current_item = dragged_item
	dragged_item = slot.item
	if current_item:
		slot.item = current_item
	else :
		slot.item = null
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法
func create_label(label_text : String) -> void:
	var label : Label = Label.new()
	label.add_theme_font_size_override("font_size", 32.)
	label.text = label_text
	get_child(0).add_child(label)
	label.global_position = Vector2(0, 0)
	get_tree().create_timer(1).timeout.connect(func(): label.queue_free())



#endregion
