log.scrpt("xy.lua")

xy = {}

function xy.idx_2_xy(idx, xy_size)
	
	local t_xy = n.vec()
	t_xy.y, t_xy.x = page._(idx, xy_size.x)
	return t_xy
end

function xy._2_pos(p_xy, xy_size, pitch)
	local pos = n.vec(u.x_by_itm_w(p_xy.x, xy_size.x, pitch.w), - u.x_by_itm_w(p_xy.y, xy_size.y, pitch.h))
	return pos
end

function xy._2_idx(p_xy, xy_size)
	local idx
	idx = (p_xy.y - 1) * xy_size.y + p_xy.x
	return idx
end

