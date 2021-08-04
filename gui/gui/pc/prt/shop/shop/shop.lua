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
	_s._itm_pitch   = 50
	_s._dsp_idx_max =  4
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(   _s, p.Shop)
	
	-- _s:whel__init()

	_s:itm__6_ar({"shop_flower", "shop_tree", "shop_kagu_itm", "shop_kagu"})
	_s._itm_txt = {"はなのたね", "きのみ", "べんりな かぐ", "ふつうの かぐ"}
end

function p.Shop.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)

	nd.txt__(nd_ar[_s:lb("itm")], _s._itm_txt[itm_idx])
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
