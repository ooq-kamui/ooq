log.scrpt("p.bag_prt_itm.lua")

p.Bag_prt_itm = {}

-- script method

function p.Bag_prt_itm.init(_s)
	
	_s._itm_pitch = 50
	_s:base_pos__()
end

-- key 2 act

function p.Bag_prt_itm.key_2_act_itm(_s, prm)

	p.Prt.key_2_act_itm(_s, prm)

	local key    = prm.key
	local keyact = prm.keyact

	if keyact == "f" then
		if     ar.inHa(key, {"s"}) then
			_s:decide()
			_s:parent_gui_clz()
		end
	end
end

-- method

function p.Bag_prt_itm.opn(_s)
	-- log._("p.Bag_prt_itm opn", _s._lb)

	_s:itm__plt()
	_s:base_dsp__o()

	_s._focus = _.t
	-- _s:focus__(_.t)
end

function p.Bag_prt_itm.parent_gui_clz(_s)
	_s._parent_gui:clz()
end

function p.Bag_prt_itm.clz(_s)
	_s:base_dsp__x()
end

function p.Bag_prt_itm.actv__(_s, val)
	_s:cursor_dsp__(val)
end

function p.Bag_prt_itm.arw_act_othr(_s, inc_dir, keyact)
	-- log._("bag prt itm arw_act_othr", keyact)

	if keyact ~= "p" then return end

	_s._parent_gui:focus__ch(inc_dir, keyact)
end
