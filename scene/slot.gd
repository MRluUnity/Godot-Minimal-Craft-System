#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name Slot extends PanelContainer

# TODO name ===============>信 号<===============
#region 信号
signal chick_slot(slot_index : int)
#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var label: Label = $Label
var item : BaseItem:
	set(v):
		item = v
		reset_slot()
		if item:
			set_slot(item.texture, item.item_name)
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_left"):
			chick_slot.emit(get_index())
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法
func set_slot(texture : AtlasTexture, name : String) -> void:
	texture_rect.texture = texture

	label.text = name

func reset_slot() -> void:
	texture_rect.texture = null
	label.text = ""
#endregion
