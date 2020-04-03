extends KinematicBody2D
signal hit

const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

onready var sprite = $Sprite

var player_velo = Vector2()
var y_velo = 0
var facing_right = false
var collision_velocity = Vector2()
var updated_velocity = Vector2()

func check_mob(): 
    var collision = get_slide_collision(0)
    if collision:
        print(collision.collider)

func handle_collision(collision): 
#    if collision.normal == Vector2(0,-1):
#        player_velo = player_velo.bounce(collision.normal)
#    else:
#        player_velo = player_velo.slide(Vector2(1,0))
#        print(player_velo)
#        player_velo = old_velo
    if collision.normal == Vector2(0,-1):
        collision_velocity = player_velo.bounce(collision.normal)
    if collision.collider.has_method('hit'):
        collision.collider.hit()

func _physics_process(delta):
    var move_dir = 0
    if Input.is_action_pressed("move_right"):
        move_dir +=1
    if Input.is_action_pressed("move_left"):
        move_dir -=1
#    if collision_velocity == updated_velocity:
    player_velo = Vector2(move_dir * MOVE_SPEED, y_velo)
#    else: 
#        player_velo=collision_velocity
#    var collision = move_and_collide(player_velo*delta)
#    var old_velo = player_velo
    updated_velocity = move_and_slide(player_velo, Vector2(0,-1))
#    player_velo.bounce()
#    var grounded = false
    var collision = get_slide_collision(0)
#    if collision:
#        handle_collision(collision)
#        grounded = collision.normal == Vector2(0,-1)
#        grounded = true
#    check_mob(collision)

    var grounded = is_on_floor()
#    if grounded: print (grounded)

    y_velo +=GRAVITY
    var max_fall_speed = MAX_FALL_SPEED
    if is_on_wall() and y_velo >0:
        max_fall_speed = MAX_FALL_SPEED/5
    if grounded and Input.is_action_just_pressed("jump"):
        y_velo = -JUMP_FORCE
    if grounded and y_velo >= 5:
        y_velo = 5
    if y_velo >max_fall_speed:
        y_velo = max_fall_speed

        

#export (int) var run_speed = 500
#export (int) var jump_speed = -800
#export (int) var gravity = 1200
#
#var velocity = Vector2()
#var jumping = false
#
#func get_input():
#    velocity.x = 0
#    var right = Input.is_action_pressed('ui_right')
#    var left = Input.is_action_pressed('ui_left')
#    var jump = Input.is_action_just_pressed('ui_select')
#
#    if jump and is_on_floor():
#        jumping = true
#        velocity.y = jump_speed
#    if right:
#        velocity.x += run_speed
#    if left:
#        velocity.x -= run_speed
#
#func _physics_process(delta):
#    get_input()
#    velocity.y += gravity * delta
#    if jumping and is_on_floor():
#        jumping = false
#    velocity = move_and_slide(velocity, Vector2(0, -1))
