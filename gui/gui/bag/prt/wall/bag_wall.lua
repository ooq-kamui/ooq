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
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Bag_prt)
	extend.init(_s, p.Prt_itm)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend.init(_s, p.Prt_selected)
	extend.init(_s, p.Bag_prt_itm)
	extend._(_s, p.Bag_wall)

	-- _s._dsp_idx_max = 7
	_s._dsp_idx_max = 6
	
	_s:itm__by_ar(Tile.wall)
	
	local node, anim
	for idx, tile in pairs(_s._itm) do
		node = _s:itm_clone()
		anim = "wall"..int.pad(tile, 3)
		nd.anm__(node[_s:lb("itm")], ha._(anim))
		nd.order__by_blw(node[_s:lb("itm")], _s:selected_nd())
	end

	_s:selected__cursor_itm()
	_s:cursor_pos__()
end

-- method

function p.Bag_wall.decide(_s)
	log._("bag wall decide")

	-- if Wand.wand002.tile_idx == _s._selected_itm_idx then return end
	if _s:is_selected_eq_cursor() then return end

	p.Prt_selected.selected__cursor_itm(_s)

	-- Wand.wand002.tile_idx = _s._selected_itm_idx
	Wand.wand_wall.tile_idx = _s._selected_itm_idx

	Se.pst_ply("forward")
end

