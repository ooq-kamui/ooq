log.scrpt("bag.lua")

g.Bag = {
	lb  = "bag",
}
g.Bag.lr_w       = 100
g.Bag.lr_df_opn  = g.Bag.lr_w / 2
g.Bag.lr_df_clz  = Map.sq * 3 / 4
g.Bag.lr_pos_opn = n.vec(Disp.xh - g.Bag.lr_df_opn, 0)
g.Bag.lr_pos_clz = n.vec(Disp.xh + g.Bag.lr_df_clz, 0)

-- script method

function g.Bag.init(_s)

	_s._lb = "bag"
	
	extnd.init(_s, g.Gui)
	extnd._(_s, g.Bag)

	_s._l = {prt = {}}
	_s._l.prt.bag_inf   = p.Bag_inf.cre(_s)
	_s._l.prt.bag_itm   = p.Bag_itm.cre(_s)
	
	_s._r = {prt = {}}
	_s._r.prt.bag_block = p.Bag_block.cre(_s)
	_s._r.prt.bag_wall  = p.Bag_wall.cre(_s)
	
	_s:r_view_prt__("bag_block")
	
	_s._nd = {}
	_s._nd.base = nd._("base")
	_s._nd.l    = nd._("l")
	_s._nd.r    = nd._("r")
	_s._nd.itm = {}
	
	_s:dsp__(_.f)

	_s:actv_prt__psh("bag_itm")
	_s:focus__ch()
end

-- method

function g.Bag.opn(_s, prm)
	-- log._("g.Bag opn")

	_s:dsp__(_.t)

	_s:focus__(_.t)
	
	Se.pst_ply("back")

	-- log.pp("bag actv_prt", _s._actv_prt)
end

function g.Bag.clz(_s)
	-- log._("g.Bag clz")

	_s:dsp__(_.f)

	_s:focus__(_.f)
	
	Se.pst_ply("back")
end

function g.Bag.dsp__(_s, val)
	if val then
		_s:base_opn()
		_s:l_opn()
		_s:r_opn()
	else
		_s:base_clz()
		_s:l_clz()
		_s:r_clz()
	end
end

function g.Bag.base_opn(_s)
	nd.pos__(_s._nd.base, Disp.center)
end

function g.Bag.base_clz(_s)
	nd.pos__(_s._nd.base, Disp.center)
end

function g.Bag.l_opn(_s)
	-- log._("bag l_opn")

	nd.anm.mv(_s._nd.l, - g.Bag.lr_pos_opn)
	nd.anm.fade__i(_s._nd.l)
	
	_s._l.prt.bag_inf:opn()
	_s._l.prt.bag_itm:opn()
end

function g.Bag.r_opn(_s)
	-- log._("bag r_opn")
	nd.anm.mv(_s._nd.r,   g.Bag.lr_pos_opn)
	nd.anm.fade__i(_s._nd.r)

	_s:r_view_prt_opn()
end

function g.Bag.r_view_prt_opn(_s)
	
	local r_view_prt = _s:r_view_prt()
	
	if not r_view_prt then return end
	
	r_view_prt:opn()
end

function g.Bag.r_view_prt_clz(_s)
	
	local r_view_prt = _s:r_view_prt()

	if not r_view_prt then return end

	r_view_prt:clz()
end

function g.Bag.r_view_prt(_s)
	
	local r_view_prt_lb = _s:r_view_prt_lb()
	return _s._r.prt[r_view_prt_lb]
end

function g.Bag.r_view_prt__(_s, prt_lb)

	_s:r_view_prt_clz()
	
	_s:r_view_prt_lb__(prt_lb)

	_s:r_view_prt_opn()
end

function g.Bag.r_view_prt_lb__(_s, prt_lb)
	_s._r.view_prt_lb = prt_lb
end

function g.Bag.r_view_prt_lb(_s)
	return _s._r.view_prt_lb
end

function g.Bag.l_clz(_s)
	-- log._("bag l_clz")
	nd.anm.mv(_s._nd.l, - g.Bag.lr_pos_clz)
	nd.anm.fade__o(_s._nd.l)
end

function g.Bag.r_clz(_s)
	-- log._("bag r_clz")
	nd.anm.mv(_s._nd.r,   g.Bag.lr_pos_clz)
	nd.anm.fade__o(_s._nd.r)
end

function g.Bag.actv_prt(_s)
	-- log.pp("gui actv_prt", _s._actv_prt)

	if #_s._actv_prt <= 0 then return end

	local lr
	if     #_s._actv_prt == 1 then lr = "l"
	elseif #_s._actv_prt == 2 then lr = "r"
	end

	local actv_prt_lb = _s:actv_prt_lb()
	local actv_prt = _s["_"..lr].prt[actv_prt_lb]
	return actv_prt
end

function g.Bag.focus__ch(_s)
	-- log._("g.Bag focus__ch")

	local r_view_prt_lb
	if #_s._actv_prt == 1 then
		
		r_view_prt_lb = _s:r_view_prt_lb()
		-- log._("r_view_prt_lb", r_view_prt_lb)
		_s:actv_prt__psh(r_view_prt_lb)
	else
		_s:actv_prt__pop()
	end
	Se.pst_ply("cursor__mv")
end

