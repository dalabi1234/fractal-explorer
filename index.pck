GDPC                                                                                         X   res://.godot/exported/133200997/export-77c0c8652ba42c32ef48ab4715599c54-The plane.res   �3      �      �gNɨc|�\��2�Y�    X   res://.godot/exported/133200997/export-a00ca0e08a1ac5e46d330a7c1b8d7acb-MainScene.scn   `"      -      �S%J���9
%s8�    ,   res://.godot/global_script_class_cache.cfg  �6             ��Р�8���8~$}P�    D   res://.godot/imported/1px.png-894ec182c48b4f590b69cc448f917bbd.ctex         ^       �Ǽ���.+p����    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexP      �      �̛�*$q�*�́        res://.godot/uid_cache.bin  p:      �       ��6�0G$ ��z�       res://1px.png.import`       �       ȝ����Z�ܙ�cKޤ       res://FractalParent.gd         +      �ٖ(����٦D�       res://JulCode.gdshader         Q      
X��#�=�|A���u�       res://MainScene.tscn.remap  �5      f       :� ��;	Y�i��Λ       res://ManCode.gdshader  �.      .      ��������I���A�       res://The plane.tres.remap   6      f       d\]C�����,�T       res://icon.svg  �6      �      C��=U���^Qu��U3       res://icon.svg.import   0      �       A�s
W��^q�2@�       res://project.binaryp;      /      �}�Qɪv��A�:���G    �C�fGST2            ����                        &   RIFF   WEBPVP8L   /    ���������  ��[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cgg6n4kqruvc4"
path="res://.godot/imported/1px.png-894ec182c48b4f590b69cc448f917bbd.ctex"
metadata={
"vram_texture": false
}
 extends Control


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
3�m!AGST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[ wT�]6	�S�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cpbwx30y1l2pr"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 �Ż��$}�Mm��shader_type canvas_item;

uniform float seedReal;
uniform float seedImag;
uniform float viewReal;
uniform float viewImag;
uniform float viewZoom;
uniform float viewItter;


vec2 cMul(vec2 Z, vec2 W) {
	return vec2(Z.x*W.x - Z.y*W.y, Z.x*W.y + Z.y*W.x);}

vec2 cMod(vec2 Z) {
	return vec2 (length(Z),0.0);}

vec2 cSqrt(vec2 Z) {
	return vec2(cos(atan(Z.y,Z.x)/2.0),sin(atan(Z.y,Z.x)/2.0))*sqrt(length(Z));
}

void fragment() {
	// Defining z based on Transformed screen coordinates
	vec2 z = ((UV.xy - 0.5) * vec2(1.,-1.) / viewZoom) + vec2(viewReal,viewImag);
	
	vec2 s = vec2(seedReal,seedImag);
	vec2 c = z;
	z = cSqrt(z);
	//z += s;
	
	float Itter = 1.0;

	for (float i = 1.;i<viewItter+1.0;i++) {
		if (length(z)<2.0) {
			//z = abs(z);
			//z = cMul(z,z) - cMul(vec2(0.5,0.2),z);
			z = cMul(z,z);
			z += s;
			Itter = i;
		}
		
	}
	
	vec4 AxesAndUnitCircle = vec4(
		float((-0.002/viewZoom < c.x && c.x < 0.002/viewZoom) || (-0.002/viewZoom < c.y && c.y < 0.002/viewZoom)),
		step(1. - 0.003/viewZoom,length(c)) - step(1. + 0.003/viewZoom,length(c))+float(length(z)<2.0)/2.0,
		0,
		1.0);
	
	vec4 ItterationColorMapThing = vec4(
		float(bool(viewItter<Itter+1.0)),
		float(bool(viewItter<Itter+1.0)) + Itter/viewItter,
		float(bool(viewItter<Itter+1.0)) + fract(Itter/sqrt(viewItter)),
		1.0);
	
	
	COLOR = AxesAndUnitCircle + ItterationColorMapThing;
}
��t�G`�ԓ��Q�[�RSRC                    PackedScene            ��������                                                  HBoxContainer    ManRect    JulRect    resource_local_to_scene    resource_name    shader    shader_parameter/viewReal    shader_parameter/viewImag    shader_parameter/viewZoom    shader_parameter/viewItter    script    shader_parameter/seedReal    shader_parameter/seedImag    interpolation_mode    interpolation_color_space    offsets    colors 	   gradient    width    height    use_hdr    fill 
   fill_from    fill_to    repeat 	   _bundled       Script    res://FractalParent.gd ��������   Shader    res://ManCode.gdshader ��������
   Texture2D    res://1px.png �O��{GH   Shader    res://JulCode.gdshader ��������	   Material    res://The plane.tres @���?+@A
   Texture2D    res://icon.svg ��փ�.�P      local://ShaderMaterial_5lp45 �         local://ShaderMaterial_cud4l �         local://Gradient_03w5d Z          local://GradientTexture2D_tscri s         local://ShaderMaterial_bajaq �         local://Gradient_68hop           local://GradientTexture2D_i54l8 5         local://PackedScene_btnxc          ShaderMaterial                        @�              �>	        �A
         ShaderMaterial                                                    �>	        �A
      	   Gradient    
         GradientTexture2D                      �        �  
         ShaderMaterial                                              	      
      	   Gradient    
         GradientTexture2D                      X        X  
         PackedScene          	         names "         Control    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    ManNode    JulNode    HBoxContainer    ManRect 	   material    custom_minimum_size    size_flags_horizontal    size_flags_stretch_ratio    texture    stretch_mode    TextureRect    JulRect    Man    visible 	   centered 	   Sprite2D    Sprite 	   position    Jul    offset    	   variants                        �?                                                          
     HB  HB     �?                                                 
     �B  �B                           
     zD          node_count             nodes     �   ��������        ����	                                                @   	  @               
   
   ����                                                        ����            	                   
                                ����            	                                              ����                                             ����                                       ����                                           conn_count              conns               node_paths              editable_instances              version       
      RSRC;�shader_type canvas_item;

uniform float viewReal;
uniform float viewImag;
uniform float viewZoom;
uniform float viewItter;


vec2 cMul(vec2 Z, vec2 W) {
	return vec2(Z.x*W.x - Z.y*W.y, Z.x*W.y + Z.y*W.x);}

vec2 cMod(vec2 Z) {
	return vec2 (length(Z),0.0);}

void fragment() {
	// Defining z based on Transformed screen coordinates
	vec2 z = ((UV.xy - 0.5) * vec2(1.,-1.) / viewZoom) + vec2(viewReal,viewImag);
	
	vec2 c = z;
	
	
	float Itter = 1.0;
	
	for (float i = 0.;i<viewItter;i++) {
		if (length(z)<2.0) {
			//z=abs(z);
			//z = cMul(z,z) - cMul(vec2(0.5,0.2),z);
			z = cMul(z,z);
			z += c;
			Itter = i;
		}
		
	}
	
	vec4 AxesAndUnitCircle = vec4(
		float((-0.003/viewZoom < c.x && c.x < 0.003/viewZoom) || (-0.003/viewZoom < c.y && c.y < 0.003/viewZoom)),
		step(1. - 0.003/viewZoom,length(c)) - step(1. + 0.003/viewZoom,length(c))+float(length(z)<2.0)/2.0,
		0,
		1.0);
	
	vec4 ItterationColorMapThing = vec4(
		float(bool(viewItter<Itter+1.0)) + Itter/viewItter,
		float(bool(viewItter<Itter+1.0)),
		float(bool(viewItter<Itter+1.0)) + fract(Itter/sqrt(viewItter)),
		1.0);
	
	
	//float axesBool = 0.0;
	//if ((-0.003/viewZoom < c.x && c.x < 0.003/viewZoom) || (-0.003/viewZoom < c.y && c.y < 0.003/viewZoom)) {axesBool = 1.0;}
	//else {axesBool = 0.0;}
	
	COLOR = AxesAndUnitCircle + ItterationColorMapThing;
}
��RSRC                    ShaderMaterial            ��������                                                  resource_local_to_scene    resource_name    shader    shader_parameter/viewReal    shader_parameter/viewImag    shader_parameter/viewZoom    shader_parameter/viewItter    script       Shader    res://ManCode.gdshader ��������      local://ShaderMaterial_k4aas �         ShaderMaterial                         �?                        RSRCu�	+�e�ԯ�I2��[remap]

path="res://.godot/exported/133200997/export-a00ca0e08a1ac5e46d330a7c1b8d7acb-MainScene.scn"
�>x1����_[remap]

path="res://.godot/exported/133200997/export-77c0c8652ba42c32ef48ab4715599c54-The plane.res"
�f���Ni�list=Array[Dictionary]([])
�	4P-<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
=M0X`��)�   �CNCQn'   res://export/index.apple-touch-icon.png��8D�<D   res://export/index.icon.png��v�H�
]   res://export/index.png�O��{GH   res://1px.png��փ�.�P   res://icon.svg��dg�ux   res://MainScene.tscn@���?+@A   res://The plane.tres�C��¶�[|SY�ECFG      application/config/name         Man Jul    application/run/main_scene         res://MainScene.tscn   application/config/features$   "         4.1    Forward Plus       application/config/icon         res://icon.svg  "   display/window/size/viewport_width      �  #   display/window/size/viewport_height           input/man_re_upd              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis       
   axis_value       �?   script         input/man_re_downd              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis       
   axis_value       ��   script         input/man_im_upd              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       ��   script         input/man_im_downd              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       �?   script         input/man_zo_upd              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   E   	   key_label             unicode    e      echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       �?   script         input/man_zo_down|              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   Q   	   key_label             unicode    q      echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device     ����   button_index   	      pressure          pressed          script         input/man_center|              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   F   	   key_label             unicode    f      echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device     ����   button_index         pressure          pressed          script         input/man_it_up|              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   Y   	   key_label             unicode    y      echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device     ����   button_index         pressure          pressed          script         input/man_it_down|              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   T   	   key_label             unicode    t      echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device     ����   button_index         pressure          pressed          script         input/jul_re_upd              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   L   	   key_label             unicode    l      echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       �?   script         input/jul_re_downd              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   J   	   key_label             unicode    j      echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       ��   script         input/jul_im_upd              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   I   	   key_label             unicode    i      echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       ��   script         input/jul_im_downd              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   K   	   key_label             unicode    k      echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       �?   script         input/jul_zo_upd              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   O   	   key_label             unicode    o      echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       �?   script         input/jul_zo_down|              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   U   	   key_label             unicode    u      echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device     ����   button_index   
      pressure          pressed          script         input/jul_center|              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   H   	   key_label             unicode    h      echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device     ����   button_index         pressure          pressed          script         input/jul_it_up|              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   Y   	   key_label             unicode    y      echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device     ����   button_index         pressure          pressed          script         input/jul_it_down|              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   T   	   key_label             unicode    t      echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device     ����   button_index         pressure          pressed          script      #   rendering/renderer/rendering_method         gl_compatibility���\��G���