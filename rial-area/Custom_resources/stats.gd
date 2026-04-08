extends Resource
class_name Stats

signal stats_changed

## 最大生命值
@export var max_health : int = 10 : set = set_max_health
@export var art: SpriteFrames

## 生命值
var health: int = max_health : set = set_health
## 防御值
var block: int : set = set_block

func set_health(value : int) -> void:
	health = clampi(value, 0, max_health)
	stats_changed.emit()


func set_max_health(value : int) -> void:
	var diff := value - max_health
	max_health = value
	
	if diff > 0: # 如果最大生命值增加health也加上增加的值
		health = health + diff
	elif health > max_health: # 如果最大生命值减少导致小于当前health就让health等于max_health
		health = max_health
	
	stats_changed.emit()

func set_block(value : int) -> void:
	block = clampi(value, 0, 999)
	stats_changed.emit()

func take_damage(damage : int) -> void:
	if damage <= 0:
		return
	var initial_damage = damage
	damage = clampi(damage - block, 0, damage)
	self.block = clampi(block - initial_damage, 0, block)
	self.health -= damage

func heal(amount : int) -> void:
	health += amount


func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	return instance
