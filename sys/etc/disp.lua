log.scrpt("disp.lua")

Disp = {
	x = str._2_int(sys.get_config("display.width" )), -- 1300
	y = str._2_int(sys.get_config("display.height")), --  500
}
Disp.xh = Disp.x / 2
Disp.yh = Disp.y / 2
Disp.center = n.vec(Disp.xh, Disp.yh)
