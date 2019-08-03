extends StaticBody
class_name Platform

onready var mesh = $MeshInstance
onready var material = SpatialMaterial.new()

onready var player = get_tree().root.find_node("Player", true, false)
onready var collisions = $CollisionShape

func _ready():
	material.albedo_color = Colors.get_random_color()
	mesh.set_surface_material(0, material)

func _physics_process(_delta):
#	pass
	collisions.disabled = player.get_color() != get_color()

func get_color() -> Color:
	return material.albedo_color