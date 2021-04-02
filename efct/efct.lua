log.scrpt("efct.lua")

Efct = {

	lifetime = 3,

	davit = {
		etc = {
			"davit-magic8",
			"davit-loading",
			"davit-weaponhit",
			"davit-phantom",
			"davit-protectioncircle",
			"davit-magicbubbles",
		},
		fire = {
			once = {
				"davit-magickahit",
			},
			loop = {
				"davit-bluefire",
				"davit-brightfire",
				"davit-fire",
			},
		},
		tile_magic = {
			once = {
				"davit-casting",
				"davit-flamelash",
				"davit-magicspell",
			},
			loop = {
				"davit-felspell",
				"davit-firespin",
				"davit-freezing",
				"davit-midnight",
				"davit-nebula",
				"davit-sunburn",
				"davit-vortex",
			},
		},
	},
}
Efct.tile_magic_dflt = Efct.davit.tile_magic.loop -- once
Efct.fire_dflt       = Efct.davit.fire.loop

-- static

function Efct.df()
	local mlt = rnd.int(1, 3)
	local df  = Map.sqh / 2 * mlt
	return df
end

function Efct.cre_3(p_efct, p_pos, prm, p_scl)

	p_efct = p_efct or rnd.ar(Efct.tile_magic_dflt)
	p_pos  = p_pos  or pos.pos_w()
	p_scl  = p_scl  or 2

	local x_df = Efct.df()
	local y_df = Efct.df()

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

	local x_df = Efct.df()
	local y_df = Efct.df()

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
	x_df   = x_df   or Efct.df()

	local t_pos1 = vec.cp(p_pos, - x_df, nil)
	local t_pos2 = vec.cp(p_pos,   x_df, nil)

	local t_id1 = Efct.cre(p_efct, t_pos1, prm, p_scl)

	local fnc = function (slf, hndl, elpsd)
		Efct.cre(p_efct, t_pos2, prm, p_scl)
	end
	local delay_time = 0.2
	local hndl = timer.delay(delay_time, _.f, fnc)

	return t_id1
end

function Efct.cre_fire(p_efct, p_pos, prm, p_scl)

	-- log._("efct fire cre")

	p_efct = p_efct or rnd.ar(Efct.fire_dflt)

	local t_id = Efct.cre(p_efct, p_pos, prm, p_scl)
	return t_id
end

function Efct.cre_magic(p_efct, p_pos, prm, p_scl)

	p_efct = p_efct or rnd.ar(Efct.tile_magic_dflt)

	local t_id = Efct.cre(p_efct, p_pos, prm, p_scl)

	-- local t_id = Efct.cre_3(p_efct, p_pos, prm, p_scl)
	-- local t_id = Efct.cre_2(p_efct, p_pos, prm, p_scl)
	-- local t_id = Efct.cre_4(p_efct, p_pos, prm, p_scl)

	return t_id
end

function Efct.cre(p_efct, p_pos, prm, p_scl)

	if not p_efct then log._("efct cre p_efct is nil") return end
	-- p_efct = p_efct or rnd.ar(Efct.tile_magic_dflt)

	p_pos  = p_pos  or pos.pos_w()
	p_scl  = p_scl  or 2

	local t_url = "/ef-fac#" .. p_efct
	-- log._("efct cre", t_url)

	local t_id = fac.cre(t_url, p_pos, nil, prm, p_scl)
	return t_id
end

-- script method

function Efct.init(_s)
	log._("efct init")

	extend._(_s, Efct)

	_s:id__()

	-- _s._hndl = {}

	_s:w__0()
	_s:fade__i()

	-- del
	_s:life__()
end

-- method

function Efct.w__0(_s, fnc)
	go.set("#sprite", "tint.w", 0)
end

function Efct.life__(_s)

	local fnc = function (slf, hndl, elpsd)
		_s:fade__o__del()
	end
	local hndl = timer.delay(Efct.lifetime, _.f, fnc)
end

function Efct.fade__o__del(_s)

	local fnc = function ()
		_s:del()
	end
	_s:fade__o(fnc)
end

function Efct.fade__i(_s, fnc)
	anm.fade__i(_s._id, nil, fnc)
end

function Efct.fade__o(_s, fnc)
	anm.fade__o(_s._id, nil, fnc)
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

