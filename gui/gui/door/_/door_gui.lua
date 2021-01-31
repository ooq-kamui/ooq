log.scrpt("door_gui.lua")

g.Door = {}

function g.Door.init(_s)

	extend.init(_s, g.Gui)

	_s._prt.door = p.Door.cre(_s)

	_s:opn("door")
end
