extends StaticBody
class_name Platform

onready var mesh = $MeshInstance
onready var material = SpatialMaterial.new()
onready var area = $Area
onready var color: Color setget set_color, get_color
var scored = false

onready var player = get_tree().root.find_node("Player", true, false)
onready var collisions = $CollisionShape

func _ready():
	material.albedo_color = color
	mesh.set_surface_material(0, material)
	area.connect("body_entered", self, "_on_player_entered")

func _physics_process(_delta):
	collisions.disabled = player.get_color() != get_color()

func get_color() -> Color:
	return material.albedo_color

func set_color(new_color: Color) -> void:
	color = new_color
	if material:
		material.albedo_color = new_color

func _on_player_entered(body):
	if body == player:
		WorldGen.shift_rows(get_parent())
		if not scored:
			player.score += 1
			scored = true