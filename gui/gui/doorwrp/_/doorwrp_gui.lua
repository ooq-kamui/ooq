log.scrpt("doorwrp_gui.lua")

g.Doorwrp = {}

function g.Doorwrp.init(_s)

	extnd.init(_s, g.Gui)

	_s._prt.doorwrp = p.Doorwrp.cre(_s)

	_s:opn("doorwrp")
end

