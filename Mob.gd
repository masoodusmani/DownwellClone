extends RigidBody2D

export var MIN_SPEED = 250  # Minimum speed range.
export var MAX_SPEED = 600  # Maximum speed range.
export var velocity_to_set = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#    if(get_colliding_bodies().size()):
#        print(get_colliding_bodies()) 
    pass
func set_velocity(velocity):
    velocity_to_set = velocity
#    print('set velo')
#    print(velocity)
    

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()


func _on_VisibilityNotifier2D_screen_entered():
#    print('velocity_to_set')
    self.linear_velocity = velocity_to_set
    pass # Replace with function body.
