class_name TrickSystem
extends Node

signal trick_performed(trick_name: String, points: int, combo_multiplier: int)
signal combo_banked(total_score: int, trick_count: int)
signal cooldown_on_cooldown  # Player tried during cooldown — shake head

const TRICK_COOLDOWN_DURATION := 3.0

const TRICK_SCORES := {
	"180": 100,
	"Bar Spin": 150,
	"Tail Whip": 200,
	"No-Hander": 200,
	"Slap the Finger": 200,
	"Front Flip": 300,
	"Back Flip": 300,
	"360": 350,
	"Bri Flip": 600,
}

const TRICK_INPUTS := [
	["trick_tail_whip", "Tail Whip"],
	["trick_front_flip", "Front Flip"],
	["trick_back_flip", "Back Flip"],
	["trick_180", "180"],
	["trick_360", "360"],
	["trick_bar_spin", "Bar Spin"],
	["trick_no_hander", "No-Hander"],
	["trick_bri_flip", "Bri Flip"],
	["trick_slap", "Slap the Finger"],
]

var player: CharacterBody3D

var _cooldown_remaining := 0.0
var _on_cooldown := false
var _airborne_tricks: Array[String] = []
var _combo_score := 0
var _total_score := 0
var _coins := 0


func _process(delta: float) -> void:
	if _on_cooldown:
		_cooldown_remaining -= delta
		if _cooldown_remaining <= 0.0:
			_on_cooldown = false
			_cooldown_remaining = 0.0


func handle_trick_input() -> void:
	for pair in TRICK_INPUTS:
		var action: String = pair[0]
		var name: String = pair[1]
		if Input.is_action_just_pressed(action):
			_attempt_trick(name)
			return


func _attempt_trick(trick_name: String) -> void:
	if _on_cooldown:
		emit_signal("cooldown_on_cooldown")
		return

	var base_points: int = TRICK_SCORES.get(trick_name, 100)
	var combo_mult: int = max(1, _airborne_tricks.size() + 1)
	_airborne_tricks.append(trick_name)
	_combo_score += base_points * combo_mult
	emit_signal("trick_performed", trick_name, base_points, combo_mult)


func on_landed() -> void:
	if _airborne_tricks.size() > 0:
		_total_score += _combo_score
		_coins += _combo_score / 100
		emit_signal("combo_banked", _combo_score, _airborne_tricks.size())
		_airborne_tricks.clear()
		_combo_score = 0
		_on_cooldown = true
		_cooldown_remaining = TRICK_COOLDOWN_DURATION


func get_cooldown_fraction() -> float:
	if not _on_cooldown:
		return 1.0
	return 1.0 - (_cooldown_remaining / TRICK_COOLDOWN_DURATION)


func get_total_score() -> int:
	return _total_score


func get_coins() -> int:
	return _coins
