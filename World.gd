extends Node2D

export (PackedScene) var Mob

onready var tilemap = $TileMap
onready var player = $Player
onready var mobTimer = $MobTimer
var screen_size
func _physics_process(delta):
    if player.position.y > 400*32:
        player.position.y = 0
func _ready():
    randomize()
    screen_size = get_viewport_rect().size
    
    create_map()
    mobTimer.start()
#func _physics_process(delta):
    
#        print(player.position)
    
const PLATFORM_LENGTH = 4
func generate_mobs(mod): 
    var below_screen = player.position.y + screen_size.y + mod *100
#    print(below_screen)
    var mob = Mob.instance()
    add_child(mob)
    var direction = 0 if randi() % 2 == 0 else PI
    var start_x = screen_size.x -100 if direction else 100
    mob.position = Vector2(start_x, below_screen)
    mob.rotation = direction
    var velocity_to_set = Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0)
    velocity_to_set = velocity_to_set.rotated(direction)
#    print('----')
#    print(velocity_to_set)
#    print('----')
    mob.set_velocity(velocity_to_set)
#    mob.linear_velocity = Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0)
#    mob.linear_velocity = mob.linear_velocity.rotated(direction)
#    print('linear')
#    print(mob.linear_velocity)
    
func create_map():
    var making_platform = 0
    var platform_row = -1
    var is_valid = false
    
    for j in range(23,450):
        for i in range(15):
            match i:
                0:
                    tilemap.set_cell(i,j,0, true)
                14:
                    tilemap.set_cell(i,j,0)   
                _:
                    if  ((making_platform >0 and making_platform<PLATFORM_LENGTH) or rand_range(0,100) < 1):
                        if is_valid: 
                            making_platform +=1
                            tilemap.set_cell(i,j,1) 
                        elif abs(j - platform_row )>10:
                            platform_row = j
                            is_valid=true
                            making_platform +=1
                            tilemap.set_cell(i,j,1) 
                        else:
                            making_platform = 0
                            is_valid=false 
                    else:
                        making_platform = 0 
                        is_valid = false
                    
            


func _on_Mob_body_entered(body):
     
     print(body)
    


func _on_MobTimer_timeout():
     
    generate_mobs(0)
    generate_mobs(4)
    generate_mobs(1)
