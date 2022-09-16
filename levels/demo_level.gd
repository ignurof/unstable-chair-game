extends Node2D

onready var chair: Node2D = $Chair


func _ready():
    chair.rotate_chair()
