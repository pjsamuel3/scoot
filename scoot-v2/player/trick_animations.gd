class_name TrickAnimations
extends Node

# Maps trick names to (axis, full_rotations_fraction) tuples
# axis: 0=X (pitch), 1=Y (yaw), 2=Z (roll); fraction: how many turns (1.0 = full 360)
const TRICK_ROTATIONS := {
	"Front Flip":      [0,  1.0],
	"Back Flip":       [0, -1.0],
	"180":             [1,  0.5],
	"360":             [1,  1.0],
	"Tail Whip":       [2,  1.0],
	"Bar Spin":        [0,  0.5],
	"No-Hander":       [2,  0.5],
	"Bri Flip":        [1,  1.5],
	"Slap the Finger": [0,  0.25],
}

const TRICK_DURATION := 0.55

@export var rotation_root_path: NodePath = "../CharacterRotationRoot"

var _rotation_root: Node3D
var _tween: Tween
var _accumulated_rotation := Vector3.ZERO


func _ready() -> void:
	_rotation_root = get_node(rotation_root_path)


func play(trick_name: String) -> void:
	var entry: Array = TRICK_ROTATIONS.get(trick_name, [])
	if entry.is_empty():
		return

	var axis: int = entry[0]
	var turns: float = entry[1]
	var angle: float = turns * TAU

	if _tween and _tween.is_running():
		_tween.kill()

	var delta_rot := Vector3.ZERO
	delta_rot[axis] = angle

	var start_rot: Vector3 = _rotation_root.rotation
	var end_rot: Vector3 = start_rot + delta_rot

	_tween = create_tween()
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_trans(Tween.TRANS_CUBIC)
	_tween.tween_property(_rotation_root, "rotation", end_rot, TRICK_DURATION)
