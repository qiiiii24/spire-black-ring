extends Resource
class_name Card

# 类型
enum Type {ATTACK, SKILL, POWER}
# 攻击子类型 近战 远程
enum AttackType {NONE, MELEE, RANGED}
# 稀有度
enum Rarity {COMMON, UNCOMMON, RARE}
# 目标（单个目标，或者全部敌人，或者自己）
enum Target {SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE}

# 稀有度颜色
const RARITY_COLORS := {
	Card.Rarity.COMMON: Color.GRAY,
	Card.Rarity.UNCOMMON: Color.CORNFLOWER_BLUE,
	Card.Rarity.RARE: Color.GOLD,
}

@export_group("Card Attributes")
## 卡牌名字
@export var card_name: String
## 卡牌类型
@export var type: Type
## 攻击类型（只有ATTACK时才有意义）
@export var attack_type: AttackType = AttackType.NONE
## 卡牌稀有度
@export var rarity: Rarity
## 目标
@export var target: Target
## 费用
@export var cost: int
## 是否可消耗
@export var exhausts: bool = false

@export_group("Card Visuals")
## 图片
@export var icon: Texture
## 卡牌类型图片
@export var type_icon: Texture
## 描述(卡牌上的)
@export_multiline var tooltip_text: String
## 在卡牌上悬停一段时间后出现德描述
@export_multiline var detailed_explanation : String
## 打出卡牌的音效
@export var sound: AudioStream

## 检验是否是单一目标
func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY



#
#func play(targets: Array[Node], char_stats: CharacterStats, modifiers: ModifierHandler) -> void:
	#Events.card_played.emit(self)
	#char_stats.mana -= cost
	#
	#if is_single_targeted():
		#apply_effects(targets, modifiers)
	#else:
		#apply_effects(_get_targets(targets), modifiers)
#
#
#func apply_effects(_targets: Array[Node], _modifiers: ModifierHandler) -> void:
	#pass
#
#
#func get_default_tooltip() -> String:
	#return tooltip_text
#
#
#func get_updated_tooltip(_player_modifiers: ModifierHandler, _enemy_modifiers: ModifierHandler) -> String:
	#return tooltip_text

func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets:
		return []
		
	var tree := targets[0].get_tree()
	
	match target:
		Target.SELF:
			return tree.get_nodes_in_group("player")
		Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("enemies")
		_:
			return []

func play(targets: Array[Node], char_stats: CharacterStats) -> void:
	Events.card_played.emit(self)
	char_stats.mana -= cost
	
	if is_single_targeted():
		apply_effects(targets)
	else:
		apply_effects(_get_targets(targets))
		

#func apply_effects(_targets: Array[Node], _modifiers: ModifierHandler) -> void:
	#pass

func apply_effects(_targets: Array[Node]) -> void:
	pass
