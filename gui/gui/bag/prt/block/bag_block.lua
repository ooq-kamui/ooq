log.scrpt("p.bag_block.lua")

p.Bag_block = {}

-- static

function p.Bag_block.cre(parent_gui)
	local p_Prt = p.Bag_block
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- scrpt method

function p.Bag_block.init(_s, parent_gui)

	_s._lb = "bag_block"
	_s._dsp_idx_max  = 7
	_s._itm_scrl_dir = "v"
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Bag_prt)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd.init(_s, p.Prt_selected)
	extnd.init(_s, p.Bag_prt_itm)
	extnd._(   _s, p.Bag_block)
	
	_s:itm__6_ar(Tile.magic_block)
	
	_s:selected__cursor_itm()
	_s:cursor_pos__()
end

function p.Bag_block.whel_i_nd__(_s, whel_idx, itm_idx)
	-- log._("p.Bag_block.whel_i_nd__ start", whel_idx, itm_idx)

	local nd_ar  = _s:whel_i_nd_ar(whel_idx)

	local t_tile = _s:itm_i(itm_idx)
	local anim   = "block"..int.pad(t_tile, 3)
	nd.anm__(nd_ar[_s:lb("itm")], ha._(anim))

	-- nd.order__6_blw(nd_ar[_s:lb("itm")], _s:selected_nd())

	-- log._("p.Bag_block.whel_i_nd__ end")
end

-- method

function p.Bag_block.decide(_s)
	-- log._("bag block decide")

	if _s:is_selected_eq_cursor() then return end

	p.Prt_selected.selected__cursor_itm(_s)
	Wand.wand_block.block_idx = _s:selected_itm_idx()
	
	Se.pst_ply("forward")
end

