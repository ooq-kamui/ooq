log.scrpt("p.prt_cursor_mtrx.lua")

p.Prt_cursor_mtrx = {}

-- cursor

function p.Prt_cursor_mtrx.init(_s)

	_s._cursor_xy = n.vec(1, 1)
end

function p.Prt_cursor_mtrx.is_cursor_mv(_s, arwHa)
	-- log._("cursor_mtrx is_cursor_mv", arwHa)

	local inc_dir
	if     ha.eq(arwHa, "arw_l") then inc_dir = "dec"
	elseif ha.eq(arwHa, "arw_r") then inc_dir = "inc"
	elseif ha.eq(arwHa, "arw_u") then inc_dir = "dec_y"
	elseif ha.eq(arwHa, "arw_d") then inc_dir = "inc_y"
	end
	local ret = _.t
	return ret, inc_dir
end

function p.Prt_cursor_mtrx.cursor_mv(_s, dir)
	-- log._("prt mtrx cursor_mv", dir)

	local edge    = _.f
	
	if     ar.in_(dir, {"dec", "inc"}) then

		if     u.eq(dir, "dec") then
			
			_s._cursor_xy.x, edge = int.dec_loop(_s._cursor_xy.x, _s._xy_size.x)
			
		elseif u.eq(dir, "inc") then
			
			_s._cursor_xy.x, edge = int.inc_loop(_s._cursor_xy.x, _s._xy_size.x)
		end
		
		if edge then _s:page_mv(dir) end
		
	elseif dir == "dec_y" then
		
		_s._cursor_xy.y, edge = int.dec_loop(_s._cursor_xy.y, _s._xy_size.y)
		
	elseif dir == "inc_y" then
		
		_s._cursor_xy.y, edge = int.inc_loop(_s._cursor_xy.y, _s._xy_size.y)
	end
	_s:cursor_pos__()
	
	-- se
	if _.t then Se.pst_ply("cursor_mv") end
end

function p.Prt_cursor_mtrx.cursor_pos__(_s)

	local t_pos = xy._2_pos(_s._cursor_xy, _s._xy_size, _s._itm_pitch)
	-- log._("mtrx cursor_pos__", _s._cursor_xy, t_pos)
	
	nd.pos__(_s._nd.cursor, t_pos)
end

function p.Prt_itm_mtrx.is_edge(_s, edge)

	local ret = _.f
	if     edge == "u" then ret = (_s._cursor_xy.y == 1)
	elseif edge == "d" then ret = (_s._cursor_xy.y == _s._xy_size.y)
	elseif edge == "l" then ret = (_s._cursor_xy.x == 1)
	elseif edge == "r" then ret = (_s._cursor_xy.x == _s._xy_size.x)
	end
	return ret
end
