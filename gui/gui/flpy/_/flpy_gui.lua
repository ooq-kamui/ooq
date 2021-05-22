log.scrpt("flpy_gui.lua")

g.Flpy = {}

function g.Flpy.init(_s)
	
	extnd.init(_s, g.Gui)
	extnd._(_s, g.Flpy)

	_s._prt.flpy     = p.Flpy.cre(_s)
	_s._prt.ply_data = p.Ply_data.cre(_s)

	_s._prt.confirm = p.Confirm.cre(_s)
	_s._confirm     = _s._prt.confirm

	_s:opn("flpy")
end

