extends KinematicBody2D

var velocity = Vector2.ZERO  #(x,y)坐标系，zero= 0,0
var is_jump = true #跳跃是否能触发

onready var animation_player = $AnimationPlayer  #
onready var sprite = $Sprite

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP) #(左右，上下)
	if is_on_floor(): #物体碰撞为true
		is_jump = true


func _input(event): #监听键盘
	if event.is_action_pressed("jump") and is_jump: #触发：按下空格键和is_jump为true
		velocity.y = -800 #y轴上移动
		is_jump = false

func _process(delta):  #帧函数(一帧时间)
	
	# 0:左右按键未触发， 1:右键触发， -1:左键触发
	var direction = Input.get_action_strength("move-right") - Input.get_action_strength("move_left") #获取按键值为1
	velocity.x = direction * 350 #每帧移动速度
	velocity.y += 2000 * delta #Y轴
	
	if is_jump == false:  #如果is_jump为 flase 播放跳跃动画
		animation_player.play("jump")
	elif direction == 0:  #如果左右按键为0 播放静态动画
		animation_player.play("idle")
	else:                 #播放行走动画
		animation_player.play("walk")
		
	if direction != 0:
		sprite.flip_h = direction < 0  # -1:反转动画, 1不反转动画
	
	
#const gravity = 2000  
#const speed = 350  #速度
#
#const jump_force = 800  #跳跃高度
#
#
#
#var velocity = Vector2.ZERO  #(x,y)坐标系，zero= 0,0
#var is_jumping = false
#
#onready var animatoin_player = $AnimationPlayer
#onready var sprite = $Sprite
#
#func _physics_process(delta):
#	velocity = move_and_slide(velocity, Vector2.UP)
#	if is_on_floor():
#		is_jumping = false
#
#
#func _input(event):
#	if event.is_action_pressed("jump") and not is_jumping :
#		velocity.y = -jump_force
#		is_jumping = true
#
#
#
##重力
## _process(delta)：帧函数(每帧的时间)
#func _process(delta):
#
#	var direction = Input.get_action_strength("move-right") - Input.get_action_strength("move_left")
#
#
#	velocity.x = direction * speed
#
#	# 人物y坐标 
#	velocity.y += gravity * delta
#
#	if is_jumping:
#		animatoin_player.play("jump")
#	elif direction == 0:
#		animatoin_player.play("idle")
#	else:
#		animatoin_player.play("walk")
#		sprite.flip_h = direction < 0
