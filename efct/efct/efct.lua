log.scrpt("efct.lua")

Efct = {

	lifetime = 3,
	lifetime_tile_vnsh = 1,

	etc = {
		-- loop
		"davit-felspell",
		"davit-firespin",
		"davit-freezing",
		"davit-loading",
		"davit-magic8",
		"davit-magicbubbles",
		"davit-midnight",
		"davit-nebula",
		"davit-phantom",
		"davit-protectioncircle",
		"davit-sunburn",
		"davit-vortex",
		-- once
		"davit-weaponhit",
	},
	fire = {
		-- loop
		"davit-bluefire",
		"davit-brightfire",
		"davit-fire",
		-- once
		"davit-magickahit",
	},
	tile_magic = {
		-- loop
		--
		-- once
		"davit-casting",
		"davit-flamelash",
		"davit-magicspell",
	},
	tile_vnsh = {
		"tile-vnsh-davit-magicbubble",
	},
	sand_smoke = {
		"sand-smoke",
	},
	gold = {
		"gold",
	},
	label = {
		"label",
	},
}
Efct.tile_magic_dflt = Efct.tile_magic
Efct.fire_dflt       = Efct.fire
Efct.tile_vnsh_dflt  = Efct.tile_vnsh

-- static

function Efct.df_rnd()
	local mlt = rnd.int(1, 3)
	local df  = Map.sqq * mlt
	return df
end

-- cre x ..

function Efct.cre_3(p_efct, p_pos, prm, p_scl)

	p_efct = p_efct or rnd.ar(Efct.tile_magic_dflt)
	p_pos  = p_pos  or pos.pos_w()
	p_scl  = p_scl  or 2

	local x_df = Efct.df_rnd()
	local y_df = Efct.df_rnd()

	local t_pos1 = vec.cp(p_pos, nil, - y_df)
	local t_pos2 = vec.cp(p_pos, nil,   y_df)

	local t_id1 = Efct.cre(p_efct, t_pos1, prm, p_scl)

	local fnc = function (slf, hndl, elpsd)
		Efct.cre_2(p_efct, t_pos2, prm, p_scl, x_df)
	end
	local delay_time = 0.2
	local hndl = timer.delay(delay_time, _.f, fnc)

	return t_id1
end

function Efct.cre_4(p_efct, p_pos, prm, p_scl)

	p_efct = p_efct or rnd.ar(Efct.tile_magic_dflt)
	p_pos  = p_pos  or pos.pos_w()
	p_scl  = p_scl  or 2

	local x_df = Efct.df_rnd()
	local y_df = Efct.df_rnd()

	local t_pos1 = vec.cp(p_pos, nil, - y_df)
	local t_pos2 = vec.cp(p_pos, nil,   y_df)

	local t_id1, t_id2 = Efct.cre_2(p_efct, t_pos1, prm, p_scl, x_df)

	local fnc = function (slf, hndl, elpsd)
		Efct.cre_2(p_efct, t_pos2, prm, p_scl, x_df)
	end
	local delay_time = 0.3
	local hndl = timer.delay(delay_time, _.f, fnc)

	return t_id1, t_id2
end

function Efct.cre_2(p_efct, p_pos, prm, p_scl, x_df)

	p_efct = p_efct or rnd.ar(Efct.tile_magic_dflt)
	p_pos  = p_pos  or pos.pos_w()
	p_scl  = p_scl  or 2
	x_df   = x_df   or Efct.df_rnd()

	local t_pos1 = vec.cp(p_pos, - x_df, nil)
	local t_pos2 = vec.cp(p_pos,   x_df, nil)

	local t_id1 = Efct.cre(p_efct, t_pos1, prm, p_scl)

	local fnc = function (slf, hndl, elpsd)
		Efct.cre(p_efct, t_pos2, prm, p_scl)
	end
	-- local delay_time = 0.2
	local delay_time = 0
	local hndl = timer.delay(delay_time, _.f, fnc)

	return t_id1
end

-- cre

function Efct.cre_fire(p_efct, p_pos, prm, p_scl)

	p_efct = p_efct or rnd.ar(Efct.fire_dflt)

	local t_id = Efct.cre(p_efct, p_pos, prm, p_scl)
	return t_id
end

function Efct.cre_tile_vnsh(p_efct, p_pos, prm, p_scl)

	p_efct = p_efct or rnd.ar(Efct.tile_vnsh_dflt)
	prm = prm or {}
	prm._lifetime = prm._lifetime or Efct.lifetime_tile_vnsh

	local t_id = Efct.cre(p_efct, p_pos, prm, p_scl)
	return t_id
end

function Efct.cre_magic(p_efct, p_pos, prm, p_scl)

	p_efct = p_efct or rnd.ar(Efct.tile_magic_dflt)

	local t_id = Efct.cre(p_efct, p_pos, prm, p_scl) -- cre_2, cre_3, cre_4
	return t_id
end

function Efct.cre_sand_smoke(p_efct, p_pos, prm, p_scl)

	p_efct = p_efct or rnd.ar(Efct.sand_smoke)

	-- local t_id = Efct.cre_2(p_efct, p_pos, prm, p_scl)
	local t_id = Efct.cre(p_efct, p_pos, prm, p_scl)
	return t_id
end

function Efct.cre_gold(p_pos, prm, p_scl)

	local p_scl = p_scl or 1

	local p_efct = Efct.gold[1]
	local t_id = Efct.cre(p_efct, p_pos, prm, p_scl)

	local time, delay
	local t_y = p_pos.y + Map.sq * 2
	time  = 0.7
	pst.scrpt(t_id, "pos_y__anm", {y = t_y, time = time})
	delay = time
	time  = 1 -- 0.7
	pst.scrpt(t_id, "sckd__", {time = time, delay = delay})

	return t_id
end

function Efct.cre_label(p_pos, prm, p_scl)

	local p_efct = Efct.label[1]

	local txt
	if prm and prm.txt then
		txt     = prm.txt
		prm.txt = nil
	end
	local t_id = Efct.cre(p_efct, p_pos, prm, p_scl)

	prm.txt = txt
	pst.scrpt(t_id, "__txt", prm)
	return t_id
end

function Efct.cre(p_efct, p_pos, prm, p_scl)

	if not p_efct then log._("efct cre p_efct is nil") return end

	p_pos  = p_pos  or pos.pos_w()
	p_scl  = p_scl  or 2
	prm = prm or {}
	prm._lifetime = prm._lifetime or Efct.lifetime

	local t_url = "/ef-fac#" .. p_efct
	log._("efct cre", t_url)

	local t_id = fac.cre(t_url, p_pos, nil, prm, p_scl)
	return t_id
end

-- scrpt method

function Efct.on_msg(_s, msg_id, prm, sndr)

	if     ha.eq(msg_id, "pos_y__anm") then
		_s:pos_y__anm(prm.y, prm.time)

	elseif ha.eq(msg_id, "sckd__") then
		_s:sckd__(prm.time, prm.delay)
	end
end

-- method

function Efct.life__(_s)

	local fnc = function (slf, hndl, elpsd)
		_s:fade__o__del()
	end
	local hndl = timer.delay(_s._lifetime, _.f, fnc)
end

-- base

function Efct.id(_s)
	return _s._id
end

function Efct.id__(_s)
	_s._id = id._()
end

function Efct.del(_s)
	-- log._("efct del")
	go.delete(_.t)
end

function Efct.z(_s)

	local z = id.z(_s:id())
	return z
end

function Efct.z__(_s, p_z)

	p_z = p_z or _s._z

	id.z__(_s:id(), p_z)
end

function Efct.w__0(_s, fnc)

	go.set("#".._s._cmp, "tint.w", 0)
end

-- anm

-- anm tint

function Efct.fade__o__del(_s)

	local fnc = function ()
		_s:del()
	end
	_s:fade__o(fnc)
end

function Efct.fade__i(_s, fnc, delay)

	delay = delay or 0

	anm.fade__i(_s:id(), _s._cmp, nil, delay, fnc)
end

function Efct.fade__o(_s, fnc, delay)

	delay = delay or 0

	anm.fade__o(_s:id(), _s._cmp, nil, delay, fnc)
end

-- anm pos

function Efct.pos__anm(_s, p_pos, time, delay)
	anm.pos__(_s:id(), p_pos, time, delay)
end

function Efct.pos_y__anm(_s, p_y, time)
	anm.pos_y__anm(_s:id(), p_y, time)
end

function Efct.sckd__(_s, time, delay)

	local fnc = function (slf, hndl, elpsd)
		local t_pos = Game.plychara_pos()
		_s:pos__anm(t_pos, time)
		_s:fade__o()
	end
	local hndl = timer.delay(delay, _.f, fnc)
end

