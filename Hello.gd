extends Panel

func _ready():
    get_node("Button").connect("pressed",self, '_on_Button_pressed',['self.get_global_mouse_position()'])

func _on_Button_pressed(arg): 
    get_node("Label").text = arg[0]
    
