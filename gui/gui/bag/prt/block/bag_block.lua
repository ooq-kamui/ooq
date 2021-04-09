log.scrpt("p.bag_block.lua")

p.Bag_block = {}

-- static

function p.Bag_block.cre(parent_gui)
	local p_Prt = p.Bag_block
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Bag_block.init(_s, parent_gui)

	_s._lb = "bag_block"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Bag_prt)
	extend.init(_s, p.Prt_itm)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend.init(_s, p.Prt_selected)
	extend.init(_s, p.Bag_prt_itm)
	extend._(_s, p.Bag_block)

	_s._dsp_idx_max = 7
	
	_s:itm__by_ar(Tile.magic_block)
	
	local node, anim
	for idx, t_tile in pairs(_s._itm) do
		node = _s:itm_clone()
		anim = "block"..int.pad(t_tile, 3)
		log._("anim", anim)
		nd.anm__(node[_s:lb("itm")], ha._(anim))
		nd.order__by_blw(node[_s:lb("itm")], _s:selected_nd())
	end
	
	_s:selected__cursor_itm()
	_s:cursor_pos__()
end

-- method

function p.Bag_block.decide(_s)
	-- log._("bag block decide")

	if _s:is_selected_eq_cursor() then return end

	p.Prt_selected.selected__cursor_itm(_s)
	Wand.wand_block.block_idx = _s:selected_itm_idx()
	
	Se.pst_ply("forward")
end

