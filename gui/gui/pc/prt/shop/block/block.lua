log.scrpt("p.shop_block.lua")

p.Shop_block = {}

-- static

function p.Shop_block.cre(parent_gui)
	local p_Prt = p.Shop_block
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Shop_block.init(_s, parent_gui)

	_s._lb = "shop_block"
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(_s, p.Shop_block)
	
	_s._itm_pitch = 50

	_s:itm__6_ar({"block001", "block002", "block003"})
	_s._itm_txt = _s._itm
end

function p.Shop_block.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)

	nd.txt__(nd_ar[_s:lb("itm")], _s._itm_txt[itm_idx])
end

-- method

function p.Shop_block.decide(_s)
end

