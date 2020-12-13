log.script("p.bag_itm.lua")

p.Bag_itm = {}
p.Bag_itm.itm_lb_2_r_view_prt_lb = {
	wand001 = "bag_block",
	wand002 = "bag_wall",
	wand003 = nil,
	wand004 = nil,
}

-- static

function p.Bag_itm.cre(parent_gui)
	local p_Prt = p.Bag_itm
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Bag_itm.init(_s, parent_gui)

	_s._lb = "bag_itm"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Bag_prt)
	extend.init(_s, p.Prt_itm)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend.init(_s, p.Prt_selected)
	extend.init(_s, p.Bag_prt_itm)
	extend._(_s, p.Bag_itm)

	_s._dsp_idx_max = 3

	_s:itm__by_ar({"wand001", "wand002", "wand003", "wand004"})
	
	local node, anim
	for idx, name in pairs(_s._itm) do
		node = _s:itm_clone()
		anim = name
		nd.anm__(node[_s:lb("itm")], anim)
	end

	_s:selected__cursor_itm()
	_s:cursor_pos__()
end

-- key 2 act

function p.Bag_itm.key_2_act_itm(_s, prm)

	p.Prt.key_2_act_itm(_s, prm)
	
	local key    = prm.key
	local keyact = prm.keyact

	if keyact == "f" then
		if     ar.inHa(key, {"s"}) then
			-- _s:decide()
			-- _s:clz()
			_s:parent_gui_clz()
		end
	end
end

-- method

function p.Bag_itm.decide(_s)
	-- log._("bag itm decide")

	p.Prt_selected.selected__cursor_itm(_s)

	_s:plychara_itm_selected__()

	_s:bag_r_view__()
	-- log._("bag itm decide end")
end

function p.Bag_itm.plychara_itm_selected__(_s)
	pst._("#script", "plychara_itm_selected__", {itm_selected = _s:selected_itm()})
end

function p.Bag_itm.bag_r_view__(_s)
	
	local itm_lb = _s:cursor_itm()
	local prt_lb = p.Bag_itm.itm_lb_2_r_view_prt_lb[itm_lb]
	_s._parent_gui:r_view_prt__(prt_lb)
end

function p.Bag_itm.cursor_mv_exe(_s)
	_s:decide()
end
