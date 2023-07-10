<<<<<<< HEAD
@tool
=======
tool
>>>>>>> 956a8497f35508b47de4618367e87e6e17e8a05e
extends Node2D

var destroy = false
var last_key = ""
var sound = true

<<<<<<< HEAD
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var label: Label = $Label


func _ready():
	if sound:
		audio_stream_player.play()
	
	animated_sprite_2d.frame = 0
	animated_sprite_2d.play("default")
	animation_player.play("default")
	timer.start()
	label.text = last_key
	label.modulate = Color(randf_range(0,2), randf_range(0,2), randf_range(0,2))

=======
func _ready():
	if sound:
		$AudioStreamPlayer.play()
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play("default")
	$AnimationPlayer.play("default")
	$Timer.start()
	$Label.text = last_key
	$Label.modulate = Color(rand_range(0,2), rand_range(0,2), rand_range(0,2))
>>>>>>> 956a8497f35508b47de4618367e87e6e17e8a05e

func _on_Timer_timeout():
	if destroy:
		queue_free()
