extends CharacterBody2D  # 👈 تغيير: صرنا نتحكم بالجسم نفسه

@export var speed := 40.0
@export var patrol_distance := 100.0

var dir := 1
var start_x : float

# لكي نتحكم في الصورة، نعرف متغير يوصلنا لها
@onready var sprite = $AnimatedSprite2D 

func _ready():
 # 👈 تغيير: نطلب من الصورة تشغيل الأنيميشن
 sprite.play("Idle")
 # نحن الآن الجسم، فنأخذ مكاننا مباشرة
 start_x = global_position.x 

func _process(delta):
 # --- 1. الحركة ---
 # 👈 تغيير: نحرك (position) حقنا مباشرة بدون get_parent
 position.x += dir * speed * delta
 
 # --- 2. الحدود ---
 var current_x = global_position.x
 
 if current_x >= start_x + patrol_distance:
  dir = -1
  sprite.flip_h = false # 👈 تغيير: نقلب الصورة وليس الجسم
  
 elif current_x <= start_x - patrol_distance:
  dir = 1
  sprite.flip_h = true # 👈 تغيير: نقلب الصورة وليس الجسم

# --- 3. القتال ---
# ⚠️ ملاحظة: ستحتاجين إعادة ربط الإشارة (تابعي الخطوة 4)
func _on_hitbox_body_entered(body):
 if body.name == "MaskDude":
  var y_diff = body.global_position.y - global_position.y
  
  if y_diff < -5:
   print("✅ دعس!")
   queue_free() # 👈 تغيير: نحذف أنفسنا مباشرة
   body.velocity.y = -300
  else:
   print("❌ خسارة!")
   get_tree().reload_current_scene()
