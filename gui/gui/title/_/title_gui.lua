log.scrpt("title_gui.lua")

g.Title = {}

function g.Title.init(_s)
	
	extend.init(_s, g.Gui)

	_s._prt.logo      = p.Logo.cre(_s)
	_s._prt.ply_slt  = p.Ply_slt.cre(_s)
	_s._prt.ply_data = p.Ply_data.cre(_s)
	
	_s._prt.bg      = p.Bg.cre(_s)
	_s._prt.confirm = p.Confirm.cre(_s)
	_s._confirm     = _s._prt.confirm
	
	_s:opn("logo")
end

