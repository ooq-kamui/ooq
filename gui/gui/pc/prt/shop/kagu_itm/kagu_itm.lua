log.script("p.shop_kagu_itm.lua")

p.Shop_kagu_itm = {}

-- static

function p.Shop_kagu_itm.cre(parent_gui)
	local p_Prt = p.Shop_kagu_itm
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Shop_kagu_itm.init(_s, parent_gui)

	_s._lb = "shop_kagu_itm"
	
	extend.init(_s, p.Prt, parent_gui)
	extend.init(_s, p.Prt_itm_lst)
	extend.init(_s, p.Prt_cursor)
	extend._(_s, p.Shop_kagu_itm)
	
	_s._itm_pitch = 75
	_s._dsp_idx_max = 5

	local kagu_itm = ar.key(Mstr.kagu_itm)
	_s:itm__by_ar(kagu_itm)
	
	_s:nd__("ply_data_gold")
	
	local node, name, price
	for idx, cls in pairs(_s._itm) do
		
		name = cls.."001"
		node = _s:itm_clone()
		nd.txtr__(node[_s:lb("icn")], cls)
		nd.anm__(node[_s:lb("icn")], name)
		-- price
		nd.txt__(node[_s:lb("price")], _s:price(cls, name))
	end
end

-- method

function p.Shop_kagu_itm.opn(_s, prm)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:ply_data_gold__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")
end

function p.Shop_kagu_itm.ply_data_gold__(_s)
	nd.txt__(_s._nd.ply_data_gold, int._2_str(Ply_data._gold).."G")
end

function p.Shop_kagu_itm.decide(_s)
	
	if not _s:is_cursor_itm_buyable() then
		Se.pst_ply("back")
		_s:cursor_itm_iyaiya()
	else
		_s:exe()
	end
end

function p.Shop_kagu_itm.is_cursor_itm_buyable(_s)
	local ret = _.f
	if Ply_data.gold() >= _s:cursor_itm_price() then
		ret = _.t
	end
	return ret
end

function p.Shop_kagu_itm.cursor_itm_cls_name(_s)
	local cls = _s:cursor_itm()
	local name = cls.."001"
	return cls, name
end

function p.Shop_kagu_itm.price(_s, cls, name)
	
	local price = Mstr.kagu_itm[cls][name].price
	price = price / 100 -- < test
	return price
end

function p.Shop_kagu_itm.cursor_itm_price(_s)
	local cls, name = _s:cursor_itm_cls_name()
	local price = _s:price(cls, name)
	return price
end

function p.Shop_kagu_itm.exe(_s)
	local cls, name = _s:cursor_itm_cls_name()
	pst._("#script", "buy", {cls = cls, name = name})

	Ply_data.gold__sub(_s:cursor_itm_price())
	_s:ply_data_gold__()
	
	Se.pst_ply("exe")
end
