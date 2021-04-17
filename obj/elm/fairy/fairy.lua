log.scrpt("fairy.lua")

Fairy = {
	act_intrvl_time  = 100,
	name_idx_max     = 1,
	plychara_dst_max = 3,
}
Fairy.cls = "fairy"
Fairy.fac = Obj.fac..Fairy.cls
Cls.add(Fairy)

-- static

function Fairy.cre(p_pos, prm)
	-- log._("Fairy.cre")
	local Cls = Fairy
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Fairy.init(_s)

	extend.init(_s, Sp)
	extend._(_s, Fairy)

	local plychara_id = Game.plychara_id()
	_s:parent__(plychara_id, 0.1, n.vec(0, Map.sqh))

	_s._tilepos = n.vec()
	_s:tilepos__init(rnd.ar(u.lr))
end

function Fairy.tilepos__init(_s, p_dir)

	if     p_dir == "l" then
		_s._tilepos.x = - 1
		_s._tilepos.y =   0

	elseif p_dir == "r" then
		_s._tilepos.x =   1
		_s._tilepos.y =   0
	end
end

function Fairy.upd(_s, dt)
end

function Fairy.on_msg(_s, msg_id, prm, sndr)
	-- log._("fairy on_msg", msg_id)
	-- log.pp("msg_id", prm)

	if     ha.eq(msg_id, "magic") then
		_s:magic()

	elseif ha.eq(msg_id, "magic_wall") then
		_s:magic_wall()

	elseif ha.eq(msg_id, "fire") then
		_s:fire()

	elseif ha.eq(msg_id, "mv__dir") then
		_s:mv__dir(prm.dir)

	elseif ha.eq(msg_id, "mv__plychara_v") then
		_s:mv__plychara_v(prm.dir)
	else
		Sp.on_msg(_s, msg_id, prm, sndr)
	end
end

function Fairy.magic(_s)

	Magic.cre(_s:pos_w())

	-- Efct.cre_magic()
end

function Fairy.magic_wall(_s)

	local t_tilepos = map.pos_2_tilepos( _s:pos_w() )
	Wall.__(t_tilepos, Wand.wand_wall.tile_idx)
end

function Fairy.fire(_s)

	Fire.cre(_s:pos_w())

	-- Efct.cre_magic()
end

-- mv

function Fairy.mv__dir(_s, p_dir)

	_s:tilepos__add_dir(p_dir)
	_s:mv__by_tilepos()
end

function Fairy.tilepos__add_dir(_s, p_dir)

	local dst_max = Fairy.plychara_dst_max -- alias

	if     p_dir == "u" then

		if _s._tilepos.x == 0 and _s._tilepos.y <= 0 then
			_s:tilepos__init(rnd.ar(u.lr))
		else
			_s._tilepos.y = int.inc_stop(_s._tilepos.y, dst_max, - dst_max)
		end
	elseif p_dir == "d" then

		if _s._tilepos.x == 0 and _s._tilepos.y >= 0 then
			_s:tilepos__init(rnd.ar(u.lr))
		else
			_s._tilepos.y = int.dec_stop(_s._tilepos.y, dst_max, - dst_max)
		end
	elseif p_dir == "l" then

		if _s._tilepos.x < 0 then
			_s._tilepos.x = int.dec_stop(_s._tilepos.x, dst_max, - dst_max)
		else
			_s:tilepos__init("l")
		end
	elseif p_dir == "r" then

		if _s._tilepos.x > 0 then
			_s._tilepos.x = int.inc_stop(_s._tilepos.x, dst_max, - dst_max)
		else
			_s:tilepos__init("r")
		end
	end
end

function Fairy.mv__plychara_v(_s, p_dir)

	_s:tilepos__plychara_v(p_dir)
	_s:mv__by_tilepos()
end

function Fairy.tilepos__plychara_v(_s, p_dir)

	_s._tilepos.x = 0

	if     p_dir == "u" then
		_s._tilepos.y =   1

	elseif p_dir == "d" then
		_s._tilepos.y = - 1
	end
end

function Fairy.mv__by_tilepos(_s)

	local t_pos = _s:pos_by_tilepos()
	_s:mv__pos(t_pos)
end

function Fairy.pos_by_tilepos(_s)

	local t_pos = _s._tilepos * Map.sq
	return t_pos
end

