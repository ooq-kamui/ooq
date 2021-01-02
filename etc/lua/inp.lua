log.script("inp.lua")

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

function Inp.init(_s)
	
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

function Inp._upd_dec_chain_limit(i, dt)
	for key, val in pairs(i.chain_limit) do
		if i.chain_limit[key] > 0 then
			i.chain_limit[key] = i.chain_limit[key] - dt
			if i.chain_limit[key] <= 0 then
				i.chain_cnt[key] = 0
			end
		end
	end
end

function Inp._upd_inc_long(i, dt)
	if not i.key then return end
	
	-- long_fill
	for key, time in pairs(i.long_fill) do
		i.long_fill[key] = i.long_fill[key] + dt
	end
end

--- method

function Inp.__(i, key, keyact)
	i.key    = key    -- action_id
	i.keyact = keyact -- action

	-- use _upd_inc_long
	if     keyact.pressed  then
		i.long_fill[key] = 0
	elseif keyact.released then
		i.long_fill[key] = nil
	end
end

function Inp.p(i, key) -- press
	return i:_is_key_act(key, "pressed")
end

function Inp.k(i, key) -- press keep
	if  i.key == ha._(key) and not i.keyact.released then
		return _.t
	end
	return _.f
end

function Inp.f(i, key) -- release -> free
	local ret = i:_is_key_act(key, "released")
	return ret
end

function Inp._is_key_act(i, key, act)
	local ret = _.f
	if not (i.key == ha._(key)) then
		-- nothing
	elseif (act == "pressed"  and i.keyact.pressed )
	    or (act == "released" and i.keyact.released) then
		ret = _.t
	end
	return ret
end

function Inp.within(i, key) -- within
	local ret = _.f
	if i.chain_limit[key] > 0 then
		ret = _.t
	end
	return ret
end

function Inp.cc(i, key) -- get chain count
	local cc = i.chain_cnt[key] or 0
	return cc
end

function Inp.ccWithin(i, key, cnt) -- success cnt + is possible chain
	local ret = _.f
	if i:cc(key) >= cnt and i:within(key) then
		ret = _.t
	end
	return ret
end

function Inp.l(i, key) -- press long
	local ret = _.f
	
	if not i.long_fill[ha._(key)] then
		-- nothing
	elseif i.long_fill[ha._(key)] >= Inp.long_fill_num then
		ret = _.t
	end
	return ret
end

function Inp.next(i)
	
	local key = Inp.key_by_ha(i.key) -- input key , refac?

	-- chain press
	if i:p(key) then
		i.chain_limit[key] = Inp.chain_limit_time
		if i:within(key) then
			i.chain_cnt[key] = i:cc(key) + 1
		end
	end

	-- keep
	if     i:k(key) then
		i.keep = key
	elseif i:f(key) then
		i.keep = nil
	end
end

function Inp.with(i, key) -- key keep and ...
	local ret = _.f
	if i.keep == key then
		ret = _.t
	end
	return ret
end

function Inp.with_p(i, key1, key2) -- key1 keep and key2 press
	local ret = _.f
	if i.keep == key1 and i:p(key2) then
		ret = _.t
	end
	return ret
end

function Inp.with_k(i, key1, key2) -- key1 keep and key2 keep
	local ret = _.f
	if i.keep == key1 and i:k(key2) then
		ret = _.t
	end
	return ret
end

function Inp.on_input_player(i)
	
	if Gui_inp.focus_gui then return end

	local p_id = Game.plychara_id()

	-- mv
	if     i:k("arw_l") then
		-- log._("ar_l")
		pst.script(p_id, "mv", {dir = "l", s = i:p("arw_l"), l = i:l("arw_l")})

	elseif i:k("arw_r") then
		-- log._("ar_r")
		pst.script(p_id, "mv", {dir = "r", s = i:p("arw_r"), l = i:l("arw_r")})

	elseif i:k("arw_u") then
		pst.script(p_id, "mv", {dir = "u"})

	elseif i:k("arw_d") then
		pst.script(p_id, "mv", {dir = "d"})

	-- button
	elseif i:p("z") then -- jmp
		pst.script(p_id, "jmp")

	elseif i:p("a") then -- item
		
		local dir_h, hchain, dir_v, vchain, l
		-- h
		dir_h = ""; hchain = 0
		if     i:ccWithin("arw_l", 2) then
			dir_h = "l"; hchain = 2
		
		elseif i:with("arw_l") then
			dir_h = "l"
		
		elseif i:ccWithin("arw_r", 2) then
			dir_h = "r"; hchain = 2

		elseif i:with("arw_r") then
			dir_h = "r"
		end

		-- v
		dir_v = ""; vchain = 0; l = _.f
		if     i:l("arw_u")  then
			dir_v = "u"; l = _.t
		elseif i:ccWithin("arw_u", 2) then
			dir_v = "u"; vchain = 2
		elseif i:ccWithin("arw_u", 1) then
			dir_v = "u"; vchain = 1
			
		elseif i:l("arw_d") then
			dir_v = "d"; l = _.t
		elseif i:ccWithin("arw_d", 2) then
			dir_v = "d"; vchain = 2
		elseif i:ccWithin("arw_d", 1) then
			dir_v = "d"; vchain = 1
		end
		pst.script(p_id, "itm_use", {dir_h = dir_h, hchain = hchain, dir_v = dir_v, vchain = vchain, l = l})

	elseif i:p("x") then
		pst.script(p_id, "hld__ox")

	elseif i:p("s") then
		pst.script(p_id, "menu_opn")

	elseif i:p("q") then
		pst.script(Sys.cmr_id(), "zoom__o")
	elseif i:p("w") then
		pst.script(Sys.cmr_id(), "zoom__i")
	end
end

-- static

function Inp.key_by_ha(keyHa)
	local key = ha.de(keyHa)
	return key
end

function Inp.arwHa_2_inp_dir(key) -- key:hash
	local dir = Gui_inp.arwHa_2_inp_dir[key]
	return dir
end
