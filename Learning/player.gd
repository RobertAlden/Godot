extends CharacterBody2D

@export var speed = 400

var x_dir = 0
var y_dir = 0
var direction =  Vector2(x_dir,y_dir)
var moveTarget = Vector2.ZERO
var jumpSize = 16
var traveling = false

func get_input():
  if !traveling:
    x_dir = Input.get_axis("left","right")
    y_dir = Input.get_axis("up","down")
    direction = Vector2(x_dir,y_dir)
    if x_dir != 0:
      moveTarget += direction*jumpSize
      traveling = true
    elif y_dir != 0:
      moveTarget += direction*jumpSize
      traveling = true
    
  
func apply_movement():
  traveling = round(moveTarget) != round(position)
  if traveling:
    velocity = direction * speed
    move_and_slide()
    if sign(get_position_delta().x) != 0:
      $Helicopter.scale.x = sign(get_position_delta().x)
    
    
# Called when the node enters the scene tree for the first time.
func _ready():
  set_unique_name_in_owner(true)
  $AnimationPlayer.play("hover")
  moveTarget = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
  get_input()
  apply_movement()
