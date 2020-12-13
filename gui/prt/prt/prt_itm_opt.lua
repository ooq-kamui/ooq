log.script("p.prt_itm_opt.lua")

p.Prt_itm_opt = {}

function p.Prt_itm_opt.init(_s)

	_s._itm_opt = {}
	
	

end

function p.Prt_itm_opt.arw_act_othr(_s, inc_dir, keyact)
	_s:cursor_itm_opt_ch(inc_dir)
end

function p.Prt_itm_opt.cursor_itm_opt_ch(_s, inc_dir)
	-- default
end

-- fr shop_tree

function p.Prt_itm_opt.cursor_itm_opt(_s)
	local bear_name = _s._itm_opt[_s:cursor_itm_idx()]
	return bear_name
end

function p.Prt_itm_opt.cursor_itm_opt__(_s, val)
	_s._itm_opt[_s:cursor_itm_idx()] = val
end

function p.Prt_itm_opt.cursor_itm_opt_ch(_s, dir)

	local val = _s:cursor_itm_opt()

	if     dir == "inc" then val = u.inc_loop(val, Fruit.name_idx_max)
	elseif dir == "dec" then val = u.dec_loop(val, Fruit.name_idx_max)
	end
	_s:cursor_itm_opt__(val)

	local bear_name = "fruit"..int.pad(val)
	nd.anm__(_s:cursor_itm_nd("bear"), bear_name)
end
