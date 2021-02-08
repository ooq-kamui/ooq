log.scrpt("inp_plyr.lua")

Inp.plyr = {

	-- static
	keys = {
		"arw_l", "arw_r", "arw_u", "arw_d",
		"a", "z", "x", "s",
		"q", "w",
	},
	msh_time_lmt = 0.5, -- msh lmt ( time )
	-- msh_lmt_time = 0.5, -- msh lmt ( time )
	lng_fil_num  = 0.5, -- lng press ( time )
}
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

	_s._plyr._keep    = nil -- atonce

	_s._plyr._key     = nil
	_s._plyr._keyact  = nil

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
	_s:on_inp_plyr__nxt()
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

function Inp.plyr.on_inp_plyr_pst(_s)
	
	local p_id = Game.plychara_id()

	-- fairy
	if     _s:k("arw_l") then

		_s:is_lng("arw_u")
		_s:is_msh_cnt_within("arw_u", 2)

	elseif _s:k("arw_r") then
	elseif _s:k("arw_u") then
	elseif _s:k("arw_d") then
	end

	-- mv
	if     _s:k("arw_l") then
		-- log._("ar_l")
		pst.scrpt(p_id, "mv", {dir = "l", l = _s:is_lng("arw_l")})
		-- pst.scrpt(p_id, "mv", {dir = "l", s = _s:p("arw_l"), l = _s:is_lng("arw_l")})

	elseif _s:k("arw_r") then
		-- log._("ar_r")
		pst.scrpt(p_id, "mv", {dir = "r", l = _s:is_lng("arw_r")})
		-- pst.scrpt(p_id, "mv", {dir = "r", s = _s:p("arw_r"), l = _s:is_lng("arw_r")})

	elseif _s:k("arw_u") then
		pst.scrpt(p_id, "mv", {dir = "u"})

	elseif _s:k("arw_d") then
		pst.scrpt(p_id, "mv", {dir = "d"})

	-- button
	elseif _s:p("z") then -- jmp
		pst.scrpt(p_id, "jmp")

	elseif _s:p("a") then -- itm
		
		local dir_h, dir_h_msh_cnt
		local dir_v, dir_v_msh_cnt
		local is_lng

		-- h
		dir_h         = ""
		dir_h_msh_cnt = 0
		if     _s:is_msh_cnt_within("arw_l", 2) then
			dir_h         = "l"
			dir_h_msh_cnt = 2
		
		elseif _s:is_with("arw_l") then
			dir_h         = "l"
		
		elseif _s:is_msh_cnt_within("arw_r", 2) then
			dir_h         = "r"
			dir_h_msh_cnt = 2

		elseif _s:is_with("arw_r") then
			dir_h         = "r"
		end

		-- v
		dir_v         = ""
		dir_v_msh_cnt = 0
		is_lng        = _.f
		if     _s:is_lng("arw_u")  then
			dir_v         = "u"
			is_lng        = _.t

		elseif _s:is_msh_cnt_within("arw_u", 2) then
			dir_v         = "u"
			dir_v_msh_cnt = 2

		elseif _s:is_msh_cnt_within("arw_u", 1) then
			dir_v         = "u"
			dir_v_msh_cnt = 1
			
		elseif _s:is_lng("arw_d") then
			dir_v         = "d"
			is_lng        = _.t

		elseif _s:is_msh_cnt_within("arw_d", 2) then
			dir_v         = "d"
			dir_v_msh_cnt = 2

		elseif _s:is_msh_cnt_within("arw_d", 1) then
			dir_v         = "d"
			dir_v_msh_cnt = 1
		end
		local prm = {
			dir_h         = dir_h        ,
			dir_h_msh_cnt = dir_h_msh_cnt,
			dir_v         = dir_v        ,
			dir_v_msh_cnt = dir_v_msh_cnt,
			is_lng        = is_lng       ,
		}
		pst.scrpt(p_id, "itm_use", prm)

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

function Inp.plyr.on_inp_plyr__nxt(_s)
	-- log._("inp.plyr on_inp_plyr__nxt")
	
	local key = _s._plyr._key -- alias
	
	-- msh
	if _s:p(key) then

		if not _s._plyr._msh[key] then _s._plyr._msh[key] = {} end

		_s._plyr._msh[key].time = Inp.plyr.msh_time_lmt

		if _s:is_within(key) then
			_s._plyr._msh[key].cnt = _s:msh_cnt(key) + 1
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

	local ret = _.f

	if u.eq(_s._plyr._key, key) and not _s._plyr._keyact.released then
		ret = _.t
	end

	return ret
end

function Inp.plyr.f(_s, key) -- free ( released )
	local ret = _s:is_key_act(key, "released")
	return ret
end

function Inp.plyr.is_lng(_s, key) -- lng press

	local ret = _.f
	
	if not _s._plyr._lng_fil[key] then
		-- nothing
	elseif _s._plyr._lng_fil[key] >= Inp.plyr.lng_fil_num then
		ret = _.t
	end
	return ret
end

function Inp.plyr.is_key_act(_s, key, act)

	local ret = _.f

	if not u.eq(_s._plyr._key, key) then
	-- if not ha.eq(_s._plyr._key, key) then
		-- nothing

	elseif (act == "pressed"  and _s._plyr._keyact.pressed ) then
		ret = _.t

	elseif (act == "released" and _s._plyr._keyact.released) then
		ret = _.t
	end
	return ret
end

function Inp.plyr.is_within(_s, key)

	local ret
	if _s._plyr._msh[key].time > 0 then
		ret = _.t
	else
		ret = _.f
	end
	-- log._("inp.plyr is_within", key, ret)
	return ret
end

function Inp.plyr.msh_cnt(_s, key)
	-- log._("inp.plyr msh_cnt", key)
	-- log._("inp.plyr msh_cnt", key, _s._plyr._msh[key].cnt)

	return _s._plyr._msh[key].cnt
end

-- msh success cnt
function Inp.plyr.is_msh_cnt_within(_s, key, cnt)

	local ret
	if _s:msh_cnt(key) >= cnt and _s:is_within(key) then
		ret = _.t
	else
		ret = _.f
	end
	-- log._("inp.plyr is_msh_cnt_within", key, ret)
	return ret
end

function Inp.plyr.is_with(_s, key) -- keep

	local ret
	if _s._plyr._keep == key then
		ret = _.t
	else
		ret = _.f
	end
	-- log._("inp.plyr is_with", ret)
	return ret
end

-- key1 keep and key2 press
function Inp.plyr.is_with_p(_s, key1, key2) -- use not

	local ret
	if _s._plyr._keep == key1 and _s:p(key2) then
		ret = _.t
	else
		ret = _.f
	end
	-- log._("inp.plyr is_with_p", key, ret)
	return ret
end

-- key1 keep and key2 keep
function Inp.plyr.is_with_k(_s, key1, key2) -- use not

	local ret
	if _s._plyr._keep == key1 and _s:k(key2) then
		ret = _.t
	else
		ret = _.f
	end
	-- log._("inp.plyr is_with_k", key, ret)
	return ret
end

