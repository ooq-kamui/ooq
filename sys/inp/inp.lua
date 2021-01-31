log.scrpt("inp.lua")

-- input ctl

Inp = {
	-- static
	keys = {"arw_l", "arw_r", "arw_u", "arw_d",
			"a", "z", "x", "s",
			"q", "w",},
	chain_limit_time = 0.5, -- chain press limit time
	long_fill_num    = 0.5, -- long press fill time
}
ha.add_by_ar(Inp.keys)

-- static

function Inp.cre()

	local t_url = url._("/sys", "fac_inp")
	local id = fac.cre(t_url)
	return id
end

function Inp.key_by_ha(keyHa)

	local key = ha.de(keyHa)
	return key
end

function Inp.arwHa_2_inp_dir(key) -- key:hash

	local dir = Inp_gui.arwHa_2_inp_dir[key]
	return dir
end

-- script method

function Inp.init(_s)
	
	extend._(_s, Inp)

	--
	-- gui
	--
	Inp_gui.id  = id._()
	Inp_gui.gui = url._(Inp_gui.id, "gui")

	--
	-- obj
	--
	_s._id = id._()
	pst.scrpt(_s._id, "acquire_input_focus")
	-- pst.scrpt(_s._id, "acquire_input_focus")

	_s.chain_limit = {} -- time from prev pressed
	_s.chain_cnt   = {} -- chain success count

	_s.long_fill = {}  -- keep time
	_s.dt        = 0.1 -- keep logic interval time ... 

	_s.keep = nil -- atonce

	_s._is_inp_focus = _.f

	-- inp
	_s.key    = nil -- action_id
	_s.keyact = nil -- action

	_s.keep_long = {}
end

function Inp.upd(_s, dt)
	_s:_upd_dec_chain_limit(dt)
	_s:_upd_inc_long(dt)
end

function Inp._upd_dec_chain_limit(_s, dt)

	for key, val in pairs(_s.chain_limit) do
		if _s.chain_limit[key] > 0 then
			_s.chain_limit[key] = _s.chain_limit[key] - dt
			if _s.chain_limit[key] <= 0 then
				_s.chain_cnt[key] = 0
			end
		end
	end
end

function Inp._upd_inc_long(_s, dt)

	if not _s.key then return end
	
	-- long_fill
	for key, time in pairs(_s.long_fill) do
		_s.long_fill[key] = _s.long_fill[key] + dt
	end
end

-- method

function Inp.__(_s, key, keyact)

	_s.key    = key    -- action_id
	_s.keyact = keyact -- action

	-- use _upd_inc_long
	if     keyact.pressed  then
		_s.long_fill[key] = 0
	elseif keyact.released then
		_s.long_fill[key] = nil
	end
end

function Inp.p(_s, key) -- press
	return _s:_is_key_act(key, "pressed")
end

function Inp.k(_s, key) -- press keep

	if _s.key == ha._(key) and not _s.keyact.released then
		return _.t
	end
	return _.f
end

function Inp.f(_s, key) -- release -> free
	local ret = _s:_is_key_act(key, "released")
	return ret
end

function Inp._is_key_act(_s, key, act)

	local ret = _.f
	if not (_s.key == ha._(key)) then
		-- nothing
	elseif (act == "pressed"  and _s.keyact.pressed )
	    or (act == "released" and _s.keyact.released) then
		ret = _.t
	end
	return ret
end

function Inp.within(_s, key) -- within

	local ret = _.f
	if _s.chain_limit[key] > 0 then
		ret = _.t
	end
	return ret
end

function Inp.cc(_s, key) -- get chain count

	local cc = _s.chain_cnt[key] or 0
	return cc
end

function Inp.ccWithin(_s, key, cnt) -- success cnt + is possible chain

	local ret = _.f
	if _s:cc(key) >= cnt and _s:within(key) then
		ret = _.t
	end
	return ret
end

function Inp.l(_s, key) -- press long

	local ret = _.f
	
	if not _s.long_fill[ha._(key)] then
		-- nothing
	elseif _s.long_fill[ha._(key)] >= Inp.long_fill_num then
		ret = _.t
	end
	return ret
end

function Inp.next(_s)
	
	local key = Inp.key_by_ha(_s.key) -- input key , refac?

	-- chain press
	if _s:p(key) then
		_s.chain_limit[key] = Inp.chain_limit_time
		if _s:within(key) then
			_s.chain_cnt[key] = _s:cc(key) + 1
		end
	end

	-- keep
	if     _s:k(key) then
		_s.keep = key
	elseif _s:f(key) then
		_s.keep = nil
	end
end

function Inp.with(_s, key) -- key keep and ...

	local ret = _.f
	if _s.keep == key then
		ret = _.t
	end
	return ret
end

function Inp.with_p(_s, key1, key2) -- key1 keep and key2 press

	local ret = _.f
	if _s.keep == key1 and _s:p(key2) then
		ret = _.t
	end
	return ret
end

function Inp.with_k(_s, key1, key2) -- key1 keep and key2 keep

	local ret = _.f
	if _s.keep == key1 and _s:k(key2) then
		ret = _.t
	end
	return ret
end

function Inp.on_inp(_s, key, keyact)

	_s:__(key, keyact)
	_s:on_inp_plyr()
	_s:next()
end

function Inp.on_inp_plyr(_s)
	
	if Inp_gui.focus_gui then return end

	local p_id = Game.plychara_id()

	-- mv
	if     _s:k("arw_l") then
		-- log._("ar_l")
		pst.scrpt(p_id, "mv", {dir = "l", s = _s:p("arw_l"), l = _s:l("arw_l")})

	elseif _s:k("arw_r") then
		-- log._("ar_r")
		pst.scrpt(p_id, "mv", {dir = "r", s = _s:p("arw_r"), l = _s:l("arw_r")})

	elseif _s:k("arw_u") then
		pst.scrpt(p_id, "mv", {dir = "u"})

	elseif _s:k("arw_d") then
		pst.scrpt(p_id, "mv", {dir = "d"})

	-- button
	elseif _s:p("z") then -- jmp
		pst.scrpt(p_id, "jmp")

	elseif _s:p("a") then -- item
		
		local dir_h, hchain, dir_v, vchain, l
		-- h
		dir_h = ""; hchain = 0
		if     _s:ccWithin("arw_l", 2) then
			dir_h = "l"; hchain = 2
		
		elseif _s:with("arw_l") then
			dir_h = "l"
		
		elseif _s:ccWithin("arw_r", 2) then
			dir_h = "r"; hchain = 2

		elseif _s:with("arw_r") then
			dir_h = "r"
		end

		-- v
		dir_v = ""; vchain = 0; l = _.f
		if     _s:l("arw_u")  then
			dir_v = "u"; l = _.t
		elseif _s:ccWithin("arw_u", 2) then
			dir_v = "u"; vchain = 2
		elseif _s:ccWithin("arw_u", 1) then
			dir_v = "u"; vchain = 1
			
		elseif _s:l("arw_d") then
			dir_v = "d"; l = _.t
		elseif _s:ccWithin("arw_d", 2) then
			dir_v = "d"; vchain = 2
		elseif _s:ccWithin("arw_d", 1) then
			dir_v = "d"; vchain = 1
		end
		pst.scrpt(p_id, "itm_use", {dir_h = dir_h, hchain = hchain, dir_v = dir_v, vchain = vchain, l = l})

	elseif _s:p("x") then
		pst.scrpt(p_id, "hld__ox")

	elseif _s:p("s") then
		pst.scrpt(p_id, "menu_opn")

	elseif _s:p("q") then
		pst.scrpt(Sys.cmr_id(), "zoom__o")
	elseif _s:p("w") then
		pst.scrpt(Sys.cmr_id(), "zoom__i")
	end
end

function Inp.final(_s)
	pst.scrpt(_s._id, "release_input_focus")
end

