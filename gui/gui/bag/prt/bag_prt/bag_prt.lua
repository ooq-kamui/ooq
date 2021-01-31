log.scrpt("p.bag_prt.lua")

p.Bag_prt = {}

-- script method

function p.Bag_prt.init(_s)

	-- _s._focus = _.t
	-- _s._focus = _.f
end

-- method

function p.Bag_prt.opn(_s)
	log._("p.Bag_prt opn", _s._lb)

	_s:base_dsp__o()

	-- _s._focus = _.t
	-- _s:focus__(_.t)

	log._("p.Bag_prt opn", _s._lb, _s._focus)
end

