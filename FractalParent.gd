extends Control


@export var ManNode: Node
@export var JulNode: Node

var Jul = {
	Re = 0.0,
	Im = 0.0,
	Zo = .25,
	It = 25.25,
}

var Man = {
	Re = -0.75,
	Im = 0.0,
	Zo = .25,
	It = 25.25,
}

func UpdateFracView(Man, Jul, ManDir, JulDir, Delta):
	Man.Re += (ManDir.ReUp-ManDir.ReDown)*Delta/Man.Zo;
	Man.Im += (ManDir.ImUp-ManDir.ImDown)*Delta/Man.Zo;
	Man.Zo = Man.Zo*pow(2, (ManDir.ZoUp-ManDir.ZoDown)*Delta);
	Man.It = Man.It*pow(2, (ManDir.ItUp-ManDir.ItDown)*Delta);
	Man.Re = Man.Re*ManDir.Center;
	Man.Im = Man.Im*ManDir.Center
	
	Jul.Re += (JulDir.ReUp-JulDir.ReDown)*Delta/Jul.Zo*JulDir.Center;
	Jul.Im += (JulDir.ImUp-JulDir.ImDown)*Delta/Jul.Zo*JulDir.Center;
	Jul.Zo = Jul.Zo*pow(2, (JulDir.ZoUp-JulDir.ZoDown)*Delta);
	
	Jul.It = Jul.It*pow(2, (JulDir.ItUp-JulDir.ItDown)*Delta);
	Jul.Re = Jul.Re*JulDir.Center;
	Jul.Im = Jul.Im*JulDir.Center;
	
	#Jul.Re = Man.Re;
	#Jul.Im = Man.Im;
	#Jul.Zo = Man.Zo;
	

#func UpdateFracViewOld (ManReUp,ManReDown,ManImUp,ManImDown,ManZoUp,ManZoDown,ManItUp,ManItDown,JulReUp,JulReDown,JulImUp,JulImDown,JulZoUp,JulZoDown,JulItUp,JulItDown,Delta):
#	ManRe += (ManReUp-ManReDown)*Delta/ManZo;
#	ManIm += (ManImUp-ManImDown)*Delta/ManZo;
#	ManZo = ManZo*pow(2, (ManZoUp-ManZoDown)*Delta);
#	ManIt = ManZo*pow(2, (ManItUp-ManItDown)*Delta);
#
#	JulRe += (JulReUp-JulReDown)*Delta/JulZo;
#	JulIm += (JulImUp-JulImDown)*Delta/JulZo;
#	JulZo = JulZo*pow(2, (JulZoUp-JulZoDown)*Delta);
#	JulIt = JulZo*pow(2, (JulItUp-JulItDown)*Delta);
#	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var ManDir = {
		ReUp = int(Input.is_action_pressed("man_re_up")),
		ReDown = int(Input.is_action_pressed("man_re_down")),
		ImUp = int(Input.is_action_pressed("man_im_up")),
		ImDown = int(Input.is_action_pressed("man_im_down")),
		Center = int(not(Input.is_action_pressed("man_center"))),
		
		ZoUp = int(Input.is_action_pressed("man_zo_up")),
		ZoDown = int(Input.is_action_pressed("man_zo_down")),
		ItUp = int(Input.is_action_pressed("man_it_up")),
		ItDown = int(Input.is_action_pressed("man_it_down")),
	}
	
	var JulDir = {
		ReUp = int(Input.is_action_pressed("jul_re_up")),
		ReDown = int(Input.is_action_pressed("jul_re_down")),
		ImUp = int(Input.is_action_pressed("jul_im_up")),
		ImDown = int(Input.is_action_pressed("jul_im_down")),
		Center = int(not(Input.is_action_pressed("jul_center"))),
		
		ZoUp = int(Input.is_action_pressed("jul_zo_up")),
		ZoDown = int(Input.is_action_pressed("jul_zo_down")),
		ItUp = int(Input.is_action_pressed("jul_it_up")),
		ItDown = int(Input.is_action_pressed("jul_it_down")),
	}
	
	UpdateFracView(
		Man,
		Jul,
		ManDir,
		JulDir,
		delta,
	)
	
	# var ManNode = get_node("Man")
	ManNode.material.set_shader_parameter("viewReal", Man.Re)
	ManNode.material.set_shader_parameter("viewImag", Man.Im)
	ManNode.material.set_shader_parameter("viewZoom", Man.Zo)
	ManNode.material.set_shader_parameter("viewItter", Man.It)
	
	# var JulNode = get_node("Jul")
	JulNode.material.set_shader_parameter("seedReal",Man.Re)
	JulNode.material.set_shader_parameter("seedImag",Man.Im)
	JulNode.material.set_shader_parameter("viewReal", Jul.Re)
	JulNode.material.set_shader_parameter("viewImag", Jul.Im)
	JulNode.material.set_shader_parameter("viewZoom", Jul.Zo)
	JulNode.material.set_shader_parameter("viewItter", Jul.It)
	
	
func _physics_process(delta):
	var mouse_pos = get_local_mouse_position()
	$Sprite.position = lerp($Sprite.position, mouse_pos, 0.1)
func lexp(a, b, t):
	return a + (b - a) * (1.0 - exp(-t))
