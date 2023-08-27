extends Node

class_name HomeSlots

signal all_home_slots_filled
signal home_slot_filled

var home_slots_count = 1
var filled_slots = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var home_slots = get_children() as Array[HomeSlot]
#	home_slots_count = home_slots.size()
	for home_slot in home_slots:
		home_slot.frog_entered_home.connect(on_frog_entered_home)

func on_frog_entered_home():
	filled_slots += 1
	home_slot_filled.emit()
	if filled_slots == home_slots_count:
		all_home_slots_filled.emit()
	
