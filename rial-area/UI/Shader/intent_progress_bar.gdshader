shader_type canvas_item;

uniform float stamina : hint_range(0.0, 1.0) = 1.0; // 当前精力百分比
uniform vec4 stamina_color : source_color = vec4(0.35, 0.8, 0.35, 1.0);
uniform vec4 bg_color : source_color = vec4(0.08, 0.08, 0.08, 0.6);

uniform float inner_radius : hint_range(0.0, 0.9) = 0.58;
uniform float outer_radius : hint_range(0.0, 1.0) = 0.82;
uniform float start_angle_deg : hint_range(-360.0, 360.0) = -90.0; // 从正上方开始
uniform float max_angle_deg : hint_range(0.0, 360.0) = 360.0;      // 总弧度，完整圆就是360

uniform float edge_softness : hint_range(0.0001, 0.1) = 0.01;
uniform float shine_strength : hint_range(0.0, 1.0) = 0.18;
uniform float empty_alpha : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec2 uv = UV * 2.0 - 1.0;
    float dist = length(uv);

    // 半径遮罩：生成圆环
    float outer_mask = 1.0 - smoothstep(outer_radius, outer_radius + edge_softness, dist);
    float inner_mask = smoothstep(inner_radius - edge_softness, inner_radius, dist);
    float ring_mask = outer_mask * inner_mask;

    // atan(x, y) 在 Godot 里是 atan(y, x)，这里用 atan(uv.y, uv.x)
    float angle = degrees(atan(uv.y, uv.x));
    angle = mod(angle - start_angle_deg + 360.0, 360.0);

    float usable_angle = clamp(max_angle_deg, 0.0, 360.0);
    float progress_angle = stamina * usable_angle;

    // 限制在弧度范围内
    float arc_mask = 1.0 - step(usable_angle, angle);

    // 当前已填充部分
    float fill_mask = 1.0 - step(progress_angle, angle);
    fill_mask *= arc_mask;

    // 背景环
    vec4 col = bg_color;
    col.a *= ring_mask * arc_mask * empty_alpha;

    // 精力颜色
    vec4 fill_col = stamina_color;

    // 简单高光：外圈略亮一点
    float radial_t = clamp((dist - inner_radius) / max(outer_radius - inner_radius, 0.0001), 0.0, 1.0);
    float shine = pow(radial_t, 2.5) * shine_strength;
    fill_col.rgb += shine;

    // 混合填充部分
    col = mix(col, fill_col, fill_mask);

    // 最终透明
    col.a *= ring_mask;

    COLOR = col;
}
