log.scrpt("reizoko_gui.lua")

g.Reizoko = {}

function g.Reizoko.init(_s)

	extend.init(_s, g.Gui)

	_s._prt.reizoko = p.Reizoko.cre(_s)

	_s:opn("reizoko")
end
