log.script("p.shop_flower.lua")

p.Shop_flower = {}

-- static

function p.Shop_flower.cre(parent_gui)
	local p_Prt = p.Shop_flower
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Shop_flower.init(_s, parent_gui)

	_s._lb = "shop_flower"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Shop_flower)
	
	_s._itm_pitch = 75
	_s._dsp_idx_max = 5

	local flower = ar.key(Mstr.flower)
	-- log.pp("shop_flower", flower)
	_s:itm__by_ar_lim(flower)

	_s:nd__("ply_data_gold")

	-- log.pp("shop flower", Mstr.flower)
	
	local node, price
	for idx, name in pairs(_s._itm) do

		-- if idx > 10 then break end -- test
		log._("shop flower init", idx, name)
		
		node = _s:itm_clone()
		
		-- seed
		nd.txtr__(node[_s:lb("icn")], "seed")
		nd.anm__(node[_s:lb("icn")], "seed001")
		
		-- flower
		nd.anm__(node[_s:lb("flower")], name)
		
		-- price
		price = Mstr.flower[name].price
		nd.txt__(node[_s:lb("price")], price)
	end
end

-- method

function p.Shop_flower.opn(_s, prm)
	
	_s:itm__plt()
	_s:ply_data_gold__()
	
	_s:cursor_pos__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")
end

function p.Shop_flower.ply_data_gold__(_s)
	nd.txt__(_s._nd.ply_data_gold, int._2_str(Ply_data.gold()).."G")
end

function p.Shop_flower.decide(_s)
	
	if not _s:is_cursor_itm_buyable() then
		Se.pst_ply("back")
		_s:cursor_itm_iyaiya()
	else
		_s:exe()
	end
end

function p.Shop_flower.is_cursor_itm_buyable(_s)
	local ret = _.f
	if Ply_data.gold() >= _s:cursor_itm_price() then
		ret = _.t
	end
	return ret
end

function p.Shop_flower.cursor_itm_price(_s)
	local flower_name = _s:cursor_itm()
	local price = Mstr.flower[flower_name].price
	return price
end

function p.Shop_flower.exe(_s)

	nd.anm.poyon(_s:cursor_itm_nd("icn"), nil, nil, 2)
	
	local flower_name = _s:cursor_itm()
	local prm = {cls = "seed", name = "seed001", grw_cls = "flower", grw_name = flower_name}
	pst._("#script", "buy", prm)

	Ply_data.gold__sub(_s:cursor_itm_price())
	_s:ply_data_gold__()
	
	Se.pst_ply("exe")
end
