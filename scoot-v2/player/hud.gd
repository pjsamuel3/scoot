extends Control

@onready var _score_label: Label = $ScoreLabel
@onready var _combo_label: Label = $ComboLabel
@onready var _coins_label: Label = $CoinsLabel
@onready var _trick_toast: Label = $TrickToast
@onready var _cooldown_bar: ProgressBar = $CooldownBar
@onready var _toast_timer: Timer = $ToastTimer
@onready var _trick_system: TrickSystem


func setup(trick_system: TrickSystem) -> void:
	_trick_system = trick_system
	trick_system.trick_performed.connect(_on_trick_performed)
	trick_system.combo_banked.connect(_on_combo_banked)
	_trick_toast.modulate.a = 0.0
	_combo_label.visible = false


func _process(_delta: float) -> void:
	if not _trick_system:
		return
	_score_label.text = "SCORE  %d" % _trick_system.get_total_score()
	_coins_label.text = "%d COINS" % _trick_system.get_coins()
	_cooldown_bar.value = _trick_system.get_cooldown_fraction() * 100.0


func _on_trick_performed(trick_name: String, _points: int, combo_mult: int) -> void:
	var display := trick_name
	if combo_mult > 1:
		display = "%s  x%d" % [trick_name, combo_mult]
	_trick_toast.text = display
	_trick_toast.modulate.a = 1.0
	_toast_timer.start(1.5)
	if combo_mult > 1:
		_combo_label.text = "x%d COMBO" % combo_mult
		_combo_label.visible = true


func _on_combo_banked(total: int, count: int) -> void:
	if count > 1:
		_trick_toast.text = "+%d  (%d tricks!)" % [total, count]
		_trick_toast.modulate.a = 1.0
		_toast_timer.start(2.0)
	_combo_label.visible = false


func _on_toast_timer_timeout() -> void:
	_trick_toast.modulate.a = 0.0
