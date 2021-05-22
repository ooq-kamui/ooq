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

	_s:itm__by_ar({"block001", "block002", "block003"})
	_s._itm_txt = _s._itm
	
	local node
	for idx, item in pairs(_s._itm) do
		node = _s:itm_clone()
		nd.txt__(node[_s:lb("itm")], _s._itm_txt[idx])
	end
end

-- method

function p.Shop_block.decide(_s)
end
