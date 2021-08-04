log.scrpt("p.shop_kagu.lua")

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
	_s._itm_pitch   = 105
	_s._dsp_idx_max =   4
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd._(   _s, p.Shop_kagu)
	
	-- _s:whel__init()

	_s:nd__("ply_data_gold")

	local kagu = ar.key(Mstr.kagu)
	_s:itm__6_ar(kagu)
end

function p.Shop_kagu.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)

	local name = _s:itm_i(itm_idx)

	nd.txtr__(nd_ar[_s:lb("icn")], "kagu")
	nd.anm__( nd_ar[_s:lb("icn")], name)

	local price = Mstr.kagu[name].price
	nd.txt__( nd_ar[_s:lb("price")], price.."G")
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
	
	if not _s:is_item_buyabl() then
		_s:cursor_itm_iyaiya()
	else
		_s:exe()
	end
end

function p.Shop_kagu.is_item_buyabl(_s)
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

	nd.anm.poyon(_s:cursor_itm_nd("icn"), nil, p.Shop.buy_time, 2)

	local cls, name = _s:cursor_itm_cls_name()
	pst._("#script", "buy", {_cls = cls, _name = name})

	Ply_data.gold__sub(_s:cursor_itm_price())
	_s:ply_data_gold__()
	Se.pst_ply("exe")
end

