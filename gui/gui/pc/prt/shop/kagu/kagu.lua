log.script("p.shop_kagu.lua")

p.Shop_kagu = {}

-- static

function p.Shop_kagu.cre(parent_gui)
	local p_Prt = p.Shop_kagu
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Shop_kagu.init(_s, parent_gui)

	_s._lb = "shop_kagu"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Shop_kagu)
	
	_s._itm_pitch = 105
	_s._dsp_idx_max = 4

	local kagu = ar.key(Mstr.kagu)
	_s:itm__by_ar_lim(kagu)

	_s:nd__("ply_data_gold")
	
	local node, name, price
	for idx, name in pairs(_s._itm) do

		-- if idx > 10 then break end -- test
		log._("shop kagu init", idx, name)

		node = _s:itm_clone()
		-- kagu
		nd.txtr__(node[_s:lb("icn")], "kagu")
		nd.anm__(node[_s:lb("icn")], name)
		-- price
		price = Mstr.kagu[name].price
		nd.txt__(node[_s:lb("price")], price.."G")
	end
end

-- method

function p.Shop_kagu.opn(_s, prm)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:ply_data_gold__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")
end

function p.Shop_kagu.ply_data_gold__(_s)
	nd.txt__(_s._nd.ply_data_gold, int._2_str(Ply_data.gold()).."G")
end

function p.Shop_kagu.decide(_s)
	
	if not _s:is_item_buyable() then
		Se.pst_ply("back")
		_s:cursor_itm_iyaiya()
	else
		_s:exe()
	end
end

function p.Shop_kagu.is_item_buyable(_s)
	local ret = _.f
	if Ply_data.gold() >= _s:cursor_itm_price() then
		ret = _.t
	end
	return ret
end

function p.Shop_kagu.cursor_itm_cls_name(_s)
	local cls  = "kagu"
	local name = _s:cursor_itm()
	return cls, name
end

function p.Shop_kagu.cursor_itm_price(_s)
	local name = _s:cursor_itm()
	local price = Mstr.kagu[name].price
	return price
end

function p.Shop_kagu.exe(_s)
	local cls, name = _s:cursor_itm_cls_name()
	pst._("#script", "buy", {cls = cls, name = name})

	Ply_data.gold__sub(_s:cursor_itm_price())
	_s:ply_data_gold__()
	Se.pst_ply("exe")
end
