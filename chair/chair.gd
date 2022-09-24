extends Node2D

var _stage: int = -1 setget set_stage, get_stage

onready var anim_player: AnimationPlayer = $AnimationPlayer


# 0 - 25s+ | 1 - 20s+
# 2 - 15s+ | 3 - 10s+
# 4 - 5s+  | 5 - 0s+
func animate(stage: int) -> void:
    print("animate stage: %s" % stage)
    set_stage(stage)
    match stage:
        0:
            anim_player.play("stage_one")
        1:
            anim_player.play("stage_one")
        2:
            anim_player.play("stage_two")
        3:
            anim_player.play("stage_three")
        4:
            anim_player.play("stage_four")
        5:
            anim_player.play("stage_five")
        _:
            push_error("chair animate(): unhandled stage value in match")


func set_stage(value: int) -> void:
    _stage = value


func get_stage() -> int:
    return _stage
