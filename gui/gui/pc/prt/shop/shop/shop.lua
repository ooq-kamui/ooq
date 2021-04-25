log.scrpt("p.shop.lua")

p.Shop = {

	buy_time = 1,
}

-- static

function p.Shop.cre(parent_gui)
	local p_Prt = p.Shop
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Shop.init(_s, parent_gui)

	_s._lb = "shop"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Shop)
	
	_s._itm_pitch = 50
	_s._dsp_idx_max = 4
	
	_s:itm__by_ar({"shop_flower", "shop_tree", "shop_kagu_itm", "shop_kagu"})
	_s._itm_txt = {"はな", "き", "べんりな かぐ", "ふつうの かぐ"}
	
	local node
	for idx, item in pairs(_s._itm) do
		node = _s:itm_clone()
		nd.txt__(node[_s:lb("itm")], _s._itm_txt[idx])
	end
end

-- method

function p.Shop.opn(_s, prm)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")
	Se.pst_ply("irassyai")
end

function p.Shop.decide(_s)
	_s:behind()
	_s._parent_gui:opn(_s:cursor_itm())
end
