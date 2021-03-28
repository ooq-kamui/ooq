log.scrpt("efct.lua")

Efct = {

	lifetime = 3,

	davit = {
		fire = {
			"davit-bluefire",
			"davit-brightfire",
			"davit-fire",
			"davit-magickahit",
		},
		magic = {
			"davit-casting",
			"davit-felspell",
			"davit-firespin",
			"davit-flamelash",
			"davit-freezing",
			"davit-loading",
			"davit-magic8",
			"davit-magicbubbles",
			"davit-magicspell",
			"davit-midnight",
			"davit-nebula",
			"davit-phantom",
			"davit-protectioncircle",
			"davit-sunburn",
			"davit-vortex",
			"davit-weaponhit",
		},
	},
}

-- static

function Efct.cre(p_efct, p_pos, prm, p_scl)

	p_efct = p_efct or rnd.ar(Efct.davit.magic)
	p_pos  = p_pos  or pos.pos_w()
	p_scl  = p_scl  or 2

	local t_url = "/ef-fac#" .. p_efct
	log._("efct cre", t_url)

	local t_id = fac.cre(t_url, p_pos, nil, prm, p_scl)
	return t_id
end

-- script method

function Efct.init(_s)
	log._("efct init")

	extend._(_s, Efct)

	_s:id__()
	-- _s._hndl = {}

	_s:del__()
end

-- method

function Efct.del__(_s)

	local fnc = function (slf, hndl, elpsd)
		_s:fade_o_del()
	end
	local hndl = timer.delay(Efct.lifetime, _.f, fnc)
end

function Efct.fade_o_del(_s)

	local fnc = function ()
		_s:del()
	end
	_s:fade_o(fnc)
end

function Efct.fade_o(_s, fnc)
	anm.fade_o(_s._id, nil, fnc)
end

-- base

function Efct.id(_s)
	return _s._id
end

function Efct.id__(_s)
	_s._id = id._()
end

function Efct.del(_s)
	log._("efct del")
	go.delete(_.t)
end

