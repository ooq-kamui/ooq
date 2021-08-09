log.scrpt("p.bag_wall.lua")

p.Bag_wall = {}

-- static

function p.Bag_wall.cre(parent_gui)
	local p_Prt = p.Bag_wall
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Bag_wall.init(_s, parent_gui)

	_s._lb = "bag_wall"
	_s._dsp_idx_max  = 6 -- 7
	_s._itm_scrl_dir = "v"
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Bag_prt)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd.init(_s, p.Prt_selected)
	extnd.init(_s, p.Bag_prt_itm)
	extnd._(   _s, p.Bag_wall)

	_s:itm__6_ar(Tile.wall)
	
	_s:selected__cursor_itm()
	_s:cursor_pos__()
end

function p.Bag_wall.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar  = _s:whel_i_nd_ar(whel_idx)

	local t_tile = _s:itm_i(itm_idx)
	local anim = "wall"..int.pad(t_tile, 3)
	nd.anm__(nd_ar[_s:lb("itm")], ha._(anim))

	-- nd.order__6_blw(nd_ar[_s:lb("itm")], _s:selected_nd())
end

-- method

function p.Bag_wall.decide(_s)
	-- log._("bag wall decide")

	if _s:is_selected_eq_cursor() then return end

	p.Prt_selected.selected__cursor_itm(_s)

	Wand.wand_wall.tile_idx = _s._selected_itm_idx

	Se.pst_ply("forward")
end

