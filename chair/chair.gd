extends Node2D

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var _sprite: Sprite = $Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
    pass
#    rotate_chair()


func rotate_chair() -> void:
    anim_player.play("test")
#    _sprite.rotate(PI/2)
#    var tween: Tween = Tween.new()
#    tween.interpolate_property(_sprite, "rotation_degrees", 64, Tween.EASE_OUT, 1.0)
