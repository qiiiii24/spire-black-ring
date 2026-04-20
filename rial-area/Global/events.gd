extends Node
#region Battle
# 开牌瞄准开始|结束信号
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
#  开牌拖动开始|结束信号
signal card_drag_started(card_ui: CardUI)
signal card_drag_ended(card_ui: CardUI)
# 卡牌释放
signal card_release
# 打出卡牌的信号
signal card_played(card: Card)
# 
signal card_tooltip_requested(card: Card)
signal tooltip_hide_requested

# Player-related events
# 玩家抽牌
signal player_hand_drawn
# 玩家弃牌
signal player_hand_discarded
# 玩家回合结束（应该没有用）
signal player_turn_ended
# 玩家受伤
signal player_hit
# 玩家死亡
signal player_died

# Enemy-related events
# 敌人动作执行完毕
signal enemy_action_completed(enemy: Enemy)
# 敌人回合结束
signal enemy_turn_ended
# 敌人死亡
signal enemy_died(enemy: Enemy)
# 胜利或者失败发出
signal battle_over_screen_requested(text: String, type: BattleOverPanel.Type)
signal battle_won
#endregion


#region World
signal enter_battle
signal exit_battle

signal enter_shop

## 统一的退出交互
signal exit_interact
#endregion
