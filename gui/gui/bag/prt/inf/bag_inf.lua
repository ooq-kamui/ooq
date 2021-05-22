log.scrpt("p.bag_inf.lua")

p.Bag_inf = {
	base_pos = n.vec(0, Disp.yh - Map.sq * 1.5),
}

-- static

function p.Bag_inf.cre(parent_gui)
	local p_Prt = p.Bag_inf
	local gui_prt = p.Prt.cre(p_Prt, parent_gui)
	return gui_prt
end

-- script method

function p.Bag_inf.init(_s, parent_gui)

	_s._lb = "bag_inf"
	
	extnd.init(_s, p.Prt, parent_gui)
	extnd._(_s, p.Bag_prt)
	extnd._(_s, p.Bag_inf)
	
	_s:nd__("gold")
	_s:nd__("coin")

	_s:base_pos__(p.Bag_inf.base_pos)
end

function p.Bag_inf.opn(_s)
	-- log._("bag_inf.opn")

	nd.txt__(_s:nd("gold"), "x"..Ply_data.gold())

	p.Bag_prt.opn(_s)
end

