log.scrpt("shelf_gui.lua")

g.Shelf = {}

function g.Shelf.init(_s)

	extnd.init(_s, g.Gui)

	_s._prt.shelf = p.Shelf.cre(_s)

	_s._prt.zu_anml   = p.Zu_anml.cre(_s)
	_s._prt.zu_dish   = p.Zu_dish.cre(_s)
	_s._prt.zu_flower = p.Zu_flower.cre(_s)

	_s._prt.confirm = p.Confirm.cre(_s)
	_s._confirm     = _s._prt.confirm

	_s:opn("shelf")
end
