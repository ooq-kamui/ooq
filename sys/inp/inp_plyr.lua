log.scrpt("inp_plyr.lua")

Inp.plyr = {

	msh_time_lmt = 0.5, -- msh lmt   ( time )
	lng_fil_num  = 0.5, -- lng press ( time )
}
Inp.plyr.keys = {}
ar.add_ar(Inp.plyr.keys, Inp.keys_arw)
ar.add_ar(Inp.plyr.keys, Inp.keys_btn)
ha.add_by_ar(Inp.plyr.keys)

-- script method

-- init

function Inp.plyr.init_plyr(_s)
	
	_s._plyr = {}

	_s._plyr._msh = {}
	for idx, key in pairs(Inp.plyr.keys) do
		_s._plyr._msh[key] = {
			time = 0,
			cnt  = 0,
		}
	end

	_s._plyr._lng_fil = {}  -- keep time

	_s._plyr._key     = nil
	_s._plyr._keyact  = nil

	_s._plyr._keep_ltst = nil
	_s._plyr._keep = {}
end

-- upd

function Inp.plyr.upd_plyr(_s, dt)

	_s:upd_plyr_msh_time__dec(dt)
	_s:upd_plyr_lng__inc(dt)
end

function Inp.plyr.upd_plyr_msh_time__dec(_s, dt)

	for key, tbl in pairs(_s._plyr._msh) do

		if _s._plyr._msh[key].time > 0 then

			_s._plyr._msh[key].time = _s._plyr._msh[key].time - dt
			if _s._plyr._msh[key].time <= 0 then
				_s._plyr._msh[key].cnt = 0
			end
		end
	end
end

function Inp.plyr.upd_plyr_lng__inc(_s, dt)

	if not _s._plyr._key then return end
	
	-- lng_fil
	for key, time in pairs(_s._plyr._lng_fil) do
		_s._plyr._lng_fil[key] = _s._plyr._lng_fil[key] + dt
	end
end

-- on_inp

function Inp.plyr.on_inp_plyr(_s, keyHa, keyact)
	-- log._("Inp on_inp_plyr")

	local key = ha.de(keyHa)

	_s:on_inp_plyr__(key, keyact)

	_s:on_inp_plyr_pst()

	_s:on_inp_plyr_msh__()

	_s:on_inp_fairy_pst()

	-- final
	_s:on_inp_plyr_keep__(key)
	-- _s:on_inp_plyr_keep_ltst__(key)
end

function Inp.plyr.on_inp_plyr__(_s, key, keyact)
	-- log._("inp.plyr on_inp_plyr__", key)

	_s._plyr._key    = key
	_s._plyr._keyact = keyact

	-- lng_fil
	if     keyact.pressed  then
		_s._plyr._lng_fil[key] = 0
	elseif keyact.released then
		_s._plyr._lng_fil[key] = nil
	end
end

function Inp.plyr.on_inp_fairy_pst(_s)

	if not _s:is_arw() then return end

	local fairy_id = Game.fairy_id()

	local prm = {}
	prm.dir = Inp.arw_2_dir[_s._plyr._key]

	if     _s:p() then

		if     _s:is_arw_v()
		or not _s:with("a") then
			pst.scrpt(fairy_id, "mv__dir"       , prm)
		end

	elseif _s:k() and _s:is_arw_v() and _s:is_lng() then

		pst.scrpt(fairy_id, "mv__plychara_v", prm)

	elseif _s:f() then
		
	end
end

function Inp.plyr.is_arw(_s, key)

	key = key or _s._plyr._key

	local ret = ar.in_(key, Inp.keys_arw)
	return ret
end

function Inp.plyr.is_arw_v(_s, key)

	key = key or _s._plyr._key

	local ret = ar.in_(key, Inp.keys_arw_v)
	return ret
end

function Inp.plyr.on_inp_plyr_pst(_s)
	
	local plychara_id = Game.plychara_id()

	-- mv ( arw )
	if     _s:k("arw_l") then
		pst.scrpt(
			plychara_id, "mv",
			{dir = "l", dive = _s:is_lng("arw_l"), facing = _s:with("a")}
		)

	elseif _s:k("arw_r") then
		pst.scrpt(
			plychara_id, "mv",
			{dir = "r", dive = _s:is_lng("arw_r"), facing = _s:with("a")}
		)

	elseif _s:k("arw_u") then
		pst.scrpt(plychara_id, "mv", {dir = "u"})

	elseif _s:k("arw_d") then
		pst.scrpt(plychara_id, "mv", {dir = "d"})

	-- arw free
	elseif _s:f("arw_d") then
		pst.scrpt(plychara_id , "arw_d_f" )

	-- button
	elseif _s:p("z") then
		pst.scrpt(plychara_id , "jmp"     )

	-- elseif _s:p("a") then
	elseif _s:f("a") then
		pst.scrpt(plychara_id , "itm_use" )

	elseif _s:p("x") then
		pst.scrpt(plychara_id , "hld__ox" )

	elseif _s:p("s") then
		pst.scrpt(plychara_id , "menu_opn")

	elseif _s:p("q") then
		pst.scrpt(Sys.cmr_id(), "zoom__o" )

	elseif _s:p("w") then
		pst.scrpt(Sys.cmr_id(), "zoom__i" )
	end
end

function Inp.plyr.on_inp_plyr_msh__(_s)

	local key = _s._plyr._key -- alias

	local is_msh, cnt

	if _s:p(key) then

		_s._plyr._msh[key].time = Inp.plyr.msh_time_lmt

		is_msh, cnt = _s:is_msh(key)
		if is_msh then
			_s._plyr._msh[key].cnt = cnt + 1
		end
	end
end

function Inp.plyr.on_inp_plyr_keep__(_s, key)

	if     _s:k(key) then
		_s._plyr._keep[key] = _.t
		_s._plyr._keep_ltst = key

	elseif _s:f(key) then
		_s._plyr._keep[key] = nil
		_s._plyr._keep_ltst = nil
	end

	-- _s:on_inp_plyr_keep_ltst__(key)
end

--[[
function Inp.plyr.on_inp_plyr_keep_ltst__(_s, key)

	if     _s:k(key) then
		_s._plyr._keep_ltst = key
	elseif _s:f(key) then
		_s._plyr._keep_ltst = nil
	end
end
--]]

function Inp.plyr.p(_s, key) -- press

	local ret = _.f

	if key then
		if not u.eq(_s._plyr._key, key) then return ret end
	else
		key = _s._plyr._key
	end

	if _s._plyr._keyact.pressed then
		ret = _.t
	end
	return ret
end

function Inp.plyr.f(_s, key) -- free ( released )

	local ret = _.f

	if key then
		if not u.eq(_s._plyr._key, key) then return ret end
	else
		key = _s._plyr._key
	end

	if _s._plyr._keyact.released then
		ret = _.t
	end
	return ret
end

function Inp.plyr.k(_s, key) -- press keep

	local ret = _.f

	if key then
		if not u.eq(_s._plyr._key, key) then return ret end
	else
		key = _s._plyr._key
	end

	if not _s._plyr._keyact.released then
		ret = _.t
	end
	return ret
end

function Inp.plyr.is_lng(_s, key) -- lng press

	key = key or _s._plyr._key

	local ret = _.f
	
	if not _s._plyr._lng_fil[key] then
		-- nothing
	elseif _s._plyr._lng_fil[key] >= Inp.plyr.lng_fil_num then
		ret = _.t
	end
	return ret
end

function Inp.plyr.is_msh(_s, key)

	key = key or _s._plyr._key

	local ret, cnt
	if _s._plyr._msh[key].time > 0 then
		ret = _.t
		cnt = _s:msh_cnt(key)
	else
		ret = _.f
	end
	return ret, cnt
end

function Inp.plyr.msh_cnt(_s, key)
	local cnt = _s._plyr._msh[key].cnt
	return cnt
end

function Inp.plyr.is_msh_cnt_ovr(_s, key, p_cnt) -- msh success cnt, use not, but rest

	local ret
	local is_msh, cnt = _s:is_msh(key)
	if is_msh and cnt >= p_cnt then
		ret = _.t
	else
		ret = _.f
	end
	return ret
end

function Inp.plyr.with(_s, key) -- keep, use not, but rest
	-- log._("plyr is_with", key, _s._plyr._keep_ltst)

	local ret
	if _s._plyr._keep_ltst == key then
		ret = _.t
	else
		ret = _.f
	end
	return ret
end

-- key1 keep and key2 press
function Inp.plyr.p_with(_s, key1, key2) -- use not, but rest

	local ret
	if _s:p(key1) and _s._plyr._keep_ltst == key2 then
		ret = _.t
	else
		ret = _.f
	end
	return ret
end

-- key1 keep and key2 keep
function Inp.plyr.k_with(_s, key1, key2) -- use not, but rest

	local ret
	if _s:k(key1) and _s._plyr._keep_ltst == key2 then
		ret = _.t
	else
		ret = _.f
	end
	return ret
end

