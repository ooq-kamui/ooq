log.scrpt("p.shop_tree.lua")

p.Shop_tree = {}

-- static

function p.Shop_tree.cre(parent_gui)
	local p_Prt = p.Shop_tree
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Shop_tree.init(_s, parent_gui)

	_s._lb = "shop_tree"
	_s._itm_pitch   = 75
	_s._dsp_idx_max =  5
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd.init(_s, p.Prt_itm_lst)
	extnd.init(_s, p.Prt_cursor)
	extnd.init(_s, p.Prt_itm_opt)
	extnd._(   _s, p.Shop_tree)
	
	_s:nd__("ply_data_gold")

	local tree = ar.key(Mstr.tree)
	_s:itm__6_ar(tree)
	_s:whel__init()
end

function p.Shop_tree.whel_i_nd__(_s, whel_idx, itm_idx)

	local nd_ar = _s:whel_i_nd_ar(whel_idx)
	
	nd.txtr__(nd_ar[_s:lb("seed")], "seed")
	nd.anm__( nd_ar[_s:lb("seed")], "seed005")

	local name = _s:itm_i(itm_idx)
	nd.anm__( nd_ar[_s:lb("tree")], name)

	local price = Mstr.tree[name].price
	nd.txt__( nd_ar[_s:lb("price")], price.."G")

	_s._itm_opt[itm_idx] = 1 -- bear fruit
end

-- method

function p.Shop_tree.opn(_s, prm)
	
	_s:itm__plt()
	_s:cursor_pos__()
	_s:ply_data_gold__()
	_s:base_dsp__(_.t)
	_s:focus__(_.t)
	Se.pst_ply("forward")

	nd.anm.dkdk(_s:nd("arw_lr"), 1)
end

function p.Shop_tree.ply_data_gold__(_s)
	nd.txt__(_s._nd.ply_data_gold, int._2_str(Ply_data.gold()).."G")
end

function p.Shop_tree.decide(_s)
	
	if not _s:is_cursor_itm_buyabl() then
		_s:cursor_itm_iyaiya()
	else
		_s:exe()
	end
end

function p.Shop_tree.is_cursor_itm_buyabl(_s)
	local ret = _.f
	if Ply_data.gold() >= _s:cursor_itm_price() then
		ret = _.t
	end
	return ret
end

function p.Shop_tree.cursor_itm_cls_name(_s)
	local cls = "seed"
	local name = "seed005"
	local tree_name = _s:cursor_itm()
	return cls, name, tree_name
end

function p.Shop_tree.cursor_itm_prm(_s)

	local prm = {
		_cls       = "seed",
		_name      = "seed005",
		_grw_cls   = "tree",
		_grw_name  = _s:cursor_itm(),
		_bear_cls  = "fruit",
		_bear_name = "fruit"..int.pad(_s:cursor_itm_opt()),
	}
	return prm
end

function p.Shop_tree.cursor_itm_price(_s)

	local tree_name = _s:cursor_itm()
	local price = Mstr.tree[tree_name].price
	return price
end

function p.Shop_tree.exe(_s)

	nd.anm.poyon(_s:cursor_itm_nd("seed"), nil, p.Shop.buy_time, 2)
	
	local prm = _s:cursor_itm_prm()
	pst._("#script", "buy", prm)

	Ply_data.gold__sub(_s:cursor_itm_price())
	_s:ply_data_gold__()
	Se.pst_ply("exe")
end

