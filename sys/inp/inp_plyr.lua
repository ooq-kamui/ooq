log.scrpt("inp_plyr.lua")

Inp.plyr = {

	-- static
	keys = {
		"arw_l", "arw_r", "arw_u", "arw_d",
		"a", "z", "x", "s",
		"q", "w",
	},
	chain_limit_time = 0.5, -- chain press limit time
	long_fil_num     = 0.5, -- long press fil time
}
ha.add_by_ar(Inp.plyr.keys)

-- static

function Inp.plyr.key_by_ha(keyHa)

	local key = ha.de(keyHa)
	return key
end

function Inp.plyr.arwHa_2_inp_dir(key) -- key:hash

	local dir = Inp.gui.arwHa_2_inp_dir[key]
	return dir
end

-- script method

-- init

function Inp.plyr.init_plyr(_s)
	
	_s._plyr = {}

	_s._plyr._chain_lmt = {} -- time from prev pressed
	_s._plyr._chain_cnt = {} -- chain success count

	_s._plyr._long_fil = {}  -- keep time
	_s._plyr._dt       = 0.1 -- keep logic interval time ... 

	_s._plyr._keep = nil -- atonce

	_s._plyr._key    = nil -- action_id
	_s._plyr._keyact = nil -- action

	_s._plyr._keep_long = {}
end

-- upd

function Inp.plyr.upd_plyr(_s, dt)

	_s:upd_plyr_dec_chain_limit(dt)
	_s:upd_plyr_inc_long(dt)
end

function Inp.plyr.upd_plyr_dec_chain_limit(_s, dt)

	for key, val in pairs(_s._plyr._chain_lmt) do
		if _s._plyr._chain_lmt[key] > 0 then
			_s._plyr._chain_lmt[key] = _s._plyr._chain_lmt[key] - dt
			if _s._plyr._chain_lmt[key] <= 0 then
				_s._plyr._chain_cnt[key] = 0
			end
		end
	end
end

function Inp.plyr.upd_plyr_inc_long(_s, dt)

	if not _s._plyr._key then return end
	
	-- long_fil
	for key, time in pairs(_s._plyr._long_fil) do
		_s._plyr._long_fil[key] = _s._plyr._long_fil[key] + dt
	end
end

-- on_inp

function Inp.plyr.on_inp_plyr(_s, key, keyact)
	-- log._("Inp on_inp_plyr")

	_s:__(key, keyact)
	_s:on_inp_plyr_pst()
	_s:nxt()
end

function Inp.plyr.__(_s, key, keyact)

	_s._plyr._key    = key    -- action_id
	_s._plyr._keyact = keyact -- action

	-- use _upd_inc_long
	if     keyact.pressed  then
		_s._plyr._long_fil[key] = 0
	elseif keyact.released then
		_s._plyr._long_fil[key] = nil
	end
end

function Inp.plyr.on_inp_plyr_pst(_s)
	
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

function Inp.plyr.nxt(_s)
	
	local key = _s:key_by_ha(_s._key) -- input key , refac?

	-- chain press
	if _s:p(key) then
		_s._plyr._chain_lmt[key] = Inp.plyr.chain_limit_time
		if _s:within(key) then
			_s._plyr._chain_cnt[key] = _s:cc(key) + 1
		end
	end

	-- keep
	if     _s:k(key) then
		_s._plyr._keep = key
	elseif _s:f(key) then
		_s._plyr._keep = nil
	end
end

--

function Inp.plyr.p(_s, key) -- press
	return _s:is_key_act(key, "pressed")
end

function Inp.plyr.k(_s, key) -- press keep

	if _s._plyr._key == ha._(key) and not _s._plyr._keyact.released then
		return _.t
	end
	return _.f
end

function Inp.plyr.f(_s, key) -- release -> free
	local ret = _s:is_key_act(key, "released")
	return ret
end

function Inp.plyr.is_key_act(_s, key, act)

	local ret = _.f
	if not (_s._plyr._key == ha._(key)) then
		-- nothing
	elseif (act == "pressed"  and _s._plyr._keyact.pressed )
	    or (act == "released" and _s._plyr._keyact.released) then
		ret = _.t
	end
	return ret
end

function Inp.plyr.within(_s, key) -- within

	local ret = _.f
	if _s._plyr._chain_lmt[key] > 0 then
		ret = _.t
	end
	return ret
end

function Inp.plyr.cc(_s, key) -- get chain count

	local cc = _s._plyr._chain_cnt[key] or 0
	return cc
end

function Inp.plyr.ccWithin(_s, key, cnt) -- success cnt + is possible chain

	local ret = _.f
	if _s:cc(key) >= cnt and _s:within(key) then
		ret = _.t
	end
	return ret
end

function Inp.plyr.l(_s, key) -- press long

	local ret = _.f
	
	if not _s._plyr._long_fil[ha._(key)] then
		-- nothing
	elseif _s._plyr._long_fil[ha._(key)] >= Inp.plyr.long_fil_num then
		ret = _.t
	end
	return ret
end

function Inp.plyr.with(_s, key) -- key keep and ...

	local ret = _.f
	if _s._plyr._keep == key then
		ret = _.t
	end
	return ret
end

function Inp.plyr.with_p(_s, key1, key2) -- key1 keep and key2 press

	local ret = _.f
	if _s._plyr._keep == key1 and _s:p(key2) then
		ret = _.t
	end
	return ret
end

function Inp.plyr.with_k(_s, key1, key2) -- key1 keep and key2 keep

	local ret = _.f
	if _s._plyr._keep == key1 and _s:k(key2) then
		ret = _.t
	end
	return ret
end

