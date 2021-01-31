log.scrpt("pc.lua")

g.Pc = {}

function g.Pc.init(_s)
	log._("g.pc init")

	extend.init(_s, g.Gui)

	_s._prt.pc  = p.Pc.cre(_s)

	_s._prt.shop = p.Shop.cre(_s)
	-- _s._prt.shop_block    = gp.Shop_block.cre(_s)
	_s._prt.shop_flower   = p.Shop_flower.cre(_s)
	_s._prt.shop_kagu     = p.Shop_kagu.cre(_s)
	_s._prt.shop_kagu_itm = p.Shop_kagu_itm.cre(_s)
	_s._prt.shop_tree     = p.Shop_tree.cre(_s)

	_s._prt.kzn = p.Kzn.cre(_s)

	_s._prt.snn_lst = p.Snn_lst.cre(_s)
	_s._prt.snn_dtl = p.Snn_dtl.cre(_s)

	_s._prt.cfg = p.Cfg.cre(_s)
	
	_s._prt.confirm = p.Confirm.cre(_s)
	_s._confirm     = _s._prt.confirm

	_s:opn("pc")
end
