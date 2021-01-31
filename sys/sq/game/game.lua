log.scrpt("game.lua")

Game = {
	act_interval_time = 60, -- 30, 15, 10, 5,
}

-- static

function Game.cre(ply_slt_idx)
	local t_url = "/sys#game"
	local t_id = fac.cre(t_url, nil, nil, {_ply_slt_idx = ply_slt_idx})
	return t_id
end

function Game.cre_new(ply_slt_idx)
	local t_id = Game.cre(ply_slt_idx)
	pst._(t_id, "new")
	return t_id
end

function Game.cre_continue(ply_slt_idx, ply_data_file_idx)
	local t_id = Game.cre(ply_slt_idx)
	pst._(t_id, "continue", {ply_data_file_idx = ply_data_file_idx})
	return t_id
end

function Game.id()
	local game_id = Sys.game_id()
	return game_id
end

function Game.map_id()
	
	local game_id = Game.id()
	if u.is_emp(game_id) then return end
	
	local map_id = id.prp(game_id, "_map_id")
	return map_id, game_id
end

function Game.map_rng_pos()

	if Game._map_rng_pos then return Game._map_rng_pos end

	local map_id, game_id = Game.map_id()
	if u.is_emp(map_id) then return end

	Game._map_rng_pos = {
		min = id.prp(map_id, "_rng_pos_min"),
		max = id.prp(map_id, "_rng_pos_max"),
	}
	return Game._map_rng_pos
end

function Game.ply_slt_idx()
	local game_id = Game.id()
	local ply_slt_idx = id.prp(game_id, "_ply_slt_idx")
	return ply_slt_idx
end

function Game.plychara_id()
	
	local game_id = Game.id()
	if u.is_emp(game_id) then return end
	
	local map_id = id.prp(game_id, "_map_id")
	if u.is_emp(map_id) then return end

	-- log._("Game.plychara_id()", map_id)
	
	local plychara_id = id.prp(map_id, "_plychara_id")
	if u.is_emp(plychara_id) then return end
	
	return plychara_id
end

function Game.plychara_pos()
	
	local plychara_id = Game.plychara_id()
	if u.is_emp(plychara_id) then return end
	
	local plychara_pos = id.pos(plychara_id)
	return plychara_pos
end

function Game.plychara_dir()

	local plychara_id = Game.plychara_id()
	if u.is_emp(plychara_id) then return end

	local plychara_dir = id.prp(plychara_id, "_dir_h")
	return plychara_dir
end

function Game.dstrct()

	local game_id = Game.id()
	if u.is_emp(game_id) then return end

	local dstrct = id.prp(game_id, "_dstrct")
	return dstrct
end

function Game.cloud_id()
	local game_id  = Game.id()
	local map_id   = id.prp(game_id, "_map_id")
	local cloud_id = id.prp(map_id , "_cloud_id")
	return cloud_id
end

function Game.cloud_pos()
	local cloud_id = Game.cloud_id()
	local cloud_pos = id.pos(cloud_id)
	return cloud_pos
end

function Game.map_clct(p_dstrct)

	p_dstrct = p_dstrct or n.vec(0, 0)

	local clct = "hrzn"

	if     p_dstrct.y > 0 then
		clct = "aerial"

	elseif p_dstrct.y < 0 then
		clct = "ug"
	end
	return clct
end

function Game.dia_id()
	local game_id = Game.id()
	local dia_id  = id.prp(game_id, "_dia_id")
	return dia_id
end

-- script method

function Game.init(_s)
	
	extend._(_s, Game)

	_s._id = id._()
	-- _s._id = go.get_id()
	-- log._("game init", _s._map_id)

	-- gui
	_s._bag_id = fac.cre("#fac_bag_gui")
	
	Ev.cre()

	-- log._("game init _ply_slt_idx", _s._ply_slt_idx)

	_s._ply_start_ts = ts.now()

	_s._act_interval = 0

	_s:bgm_ply_rnd()

	-- pst.scrpt(Sys.cmr_id(), "pos__dflt")
end

function Game.upd(_s, dt)
	
	_s:act_interval(dt)
	
	
end

function Game.act_interval(_s, dt)

	if not _s:is_loop__act_interval__(dt) then return end

	-- log._("game act_intrvl", _s._id)
	
	_s:save()

	_s:bgm_ply_nxt_rnd()
end

function Game.is_loop__act_interval__(_s, dt)
	local is_loop = _s:act_interval__(dt)
	return is_loop
end

function Game.act_interval__(_s, dt)
	local is_loop
	_s._act_interval, is_loop = u.pls_loop(_s._act_interval, dt, Game.act_interval_time)
	return is_loop
end

function Game.bgm_ply_rnd(_s)
	Bgm.fade_o_ply_rnd()
end

function Game.bgm_ply_nxt_rnd(_s)
	Bgm.fade_o_ply_rnd()
end

function Game.on_msg(_s, msg_id, prm, sender)
	
	if     ha.eq(msg_id, "del") then
		_s:del()
		
	elseif ha.eq(msg_id, "new") then
		_s:new()

	elseif ha.eq(msg_id, "continue") then
		_s:continue(prm.ply_data_file_idx)

	elseif ha.eq(msg_id, "bag_opn") then
		_s:bag_opn()

	elseif ha.eq(msg_id, "save") then
		_s:save()

	elseif ha.eq(msg_id, "dia__o") then
		-- log._("game dia__o")
		_s:dia__o()

	elseif ha.eq(msg_id, "dia__clr") then
		-- log._("game dia__clr")
		_s:dia__clr()

	elseif ha.eq(msg_id, "map_dstrct__mv") then
		-- log._("game map_dstrct__mv", prm.dir, prm.plychara_dir)
		_s:map_dstrct__mv(prm.dir, prm.plychara_dir)

	elseif ha.eq(msg_id, "map_dstrct__ch_map_cre") then
		_s:map_dstrct__ch_map_cre(prm)
	end
end

function Game.del(_s)
	-- log._("game del")

	_s:map__del()
	_s:sky__del()
	
	Ply_data.clr()

	-- gui del
	go.delete(_s._bag_id)
	
	go.delete()
	log._("game del fin")
end

function Game.final(_s)
end

-- game

function Game.new(_s)
	-- log._("game new()")

	_s:ply_data__new()
	
	_s:map__cre()
	_s:sky__cre()

	_s:map_cloud__cre()
	_s:map_plychara__cre()
	_s:map_fairy__cre()
	
	pst.scrpt(Sys.cmr_id(), "__game_start")

	_s:new_event()
end

function Game.continue(_s, ply_data_file_idx)

	if not _s._ply_slt_idx then return end

	local data = _s:ply_data__load(ply_data_file_idx)
	local dstrct       = data["plyr"]["dstrct"] -- n.vec(0, 0)
	local plychara_pos = data["plyr"]["pos"]
	
	_s:map__cre(dstrct)
	_s:sky__cre()

	_s:map_cloud__cre()
	_s:map_plychara__cre(plychara_pos)
	_s:map_fairy__cre()
	
	pst.scrpt(Sys.cmr_id(), "__game_start")
end

function Game.save(_s)
	-- log._("game save")

	if not _s._ply_slt_idx then return end

	if _s:is_map_pause()  then log._("map is_pause") return end

	if Inp_gui.is_focus() then log._("map Inp_gui.is_focus") return end

	-- save
	_s:ply_data__save()
	_s:map__save()
end

-- ply data

function Game.ply_data__new(_s)
	Ply_data.new()
end

function Game.ply_data__load(_s, ply_data_file_idx)
	
	local data = Ply_data.load(_s._ply_slt_idx, ply_data_file_idx)

	--[[
	_s._dstrct       = data["plyr"]["dstrct"]
	_s._plychara_pos = data["plyr"]["pos"]
	--]]
	return data
end

function Game.ply_data__save(_s)
	_s._ply_data_ltst_ts = Ply_data.save(_s._ply_slt_idx)
end

-- map

function Game.map__cre(_s, dstrct)

	if not _s._ply_slt_idx then return end

	_s._dstrct = dstrct or n.vec(0, 0)

	local clct    = Game.map_clct(_s._dstrct)
	_s._map_id    = Map.cre(clct)
	-- log._("map__cre", _s._map_id)
	
	return _s._map_id
end

function Game.map_plychara__cre(_s, pos, dir)

	if not _s._map_id then return end

	pst.scrpt(_s._map_id, "plychara__cre", {pos = pos, dir = dir})
end

function Game.map_fairy__cre(_s)

	if not _s._map_id then return end

	pst.scrpt(_s._map_id, "fairy__cre")
end

function Game.map_cloud__cre(_s)

	if not _s._map_id then return end

	pst.scrpt(_s._map_id, "cloud__cre")
end

function Game.map__save(_s)
	
	if not _s._map_id then return end

	pst.scrpt(_s._map_id, "save")
end

function Game.map__del(_s)

	if not _s._map_id then return end
	
	pst.scrpt(_s._map_id, "del")
	_s._map_id = ha.emp()
end

function Game.map__save_del(_s)

	if not _s._map_id then return end
	
	pst.scrpt(_s._map_id, "save_del")
	_s._map_id = ha.emp()
end

-- map dstrct

function Game.map_dstrct__mv(_s, dir, plychara_dir) -- dir : u d l r
	-- log._("map_dstrct__mv", dir)

	-- if     ar.in_(dir, {"l", "r"}) then
	if     ar.in_(dir, u.dir_h) then
		_s:map_dstrct__mv_h(dir, plychara_dir)

	-- elseif ar.in_(dir, {"u", "d"}) then
	elseif ar.in_(dir, u.dir_v) then
		_s:map_dstrct__mv_v(dir, plychara_dir)
	end
end

function Game.map_dstrct__mv_h(_s, dir, plychara_dir) -- dir : l r
	-- log._("map_dstrct__mv_h", dir)

	-- local dstrct = id.prp(_s._map_id, "_dstrct")
	
	local x_max  = Map.dstrct_max.x
	local x_min  = - x_max

	local plychara ={}
	plychara.dir = dir
	plychara.pos = _s:plychara_pos()
	local map_rng_pos_min  = id.prp(_s._map_id, "_rng_pos_min")
	local map_rng_pos_max  = id.prp(_s._map_id, "_rng_pos_max")

	local dstrct = n.vec(_s._dstrct.x, _s._dstrct.y)
	if     dir == "l" then
		dstrct.x = u.dec_loop(dstrct.x, x_max, x_min)
		plychara.pos.x = map_rng_pos_max.x + Map.sqh
		
	elseif dir == "r" then
		dstrct.x = u.inc_loop(dstrct.x, x_max, x_min)
		plychara.pos.x = map_rng_pos_min.x - Map.sqh
	end
	-- log._("game.map_dstrct__mv_h dstrct", dstrct)

	_s:map_dstrct__ch(dstrct, plychara)
end

function Game.map_dstrct__mv_v(_s, dir, plychara_dir) -- dir : u d

	-- local dstrct = id.prp(_s._map_id, "_dstrct")
	
	local y_max  = Map.dstrct_max.y
	local y_min  = - y_max

	local plychara = {}
	plychara.dir = plychara_dir
	plychara.pos = _s:plychara_pos()
	
	local map_rng_pos_min  = id.prp(_s._map_id, "_rng_pos_min")
	local map_rng_pos_max  = id.prp(_s._map_id, "_rng_pos_max")

	local dstrct = n.vec(_s._dstrct.x, _s._dstrct.y)
	if     dir == "u" then
		dstrct.y = u.inc_loop(dstrct.y, y_max, y_min)
		plychara.pos.y = map_rng_pos_min.y - Map.sqh

	elseif dir == "d" then
		dstrct.y = u.dec_loop(dstrct.y, y_max, y_min)
		plychara.pos.y = map_rng_pos_max.y - Map.sqh
	end
	-- log._("game.map_dstrct__mv_v dstrct", dstrct)
	
	_s:map_dstrct__ch(dstrct, plychara)
end

function Game.map_dstrct__ch(_s, dstrct, plychara)

	if not _s._map_id then return end

	_s:map_dstrct__ch_tmp__(dstrct, plychara)

	-- pst.scrpt(_s._map_id, "dstrct__ch", {dstrct = dstrct, plychara = plychara})
	pst.scrpt(_s._map_id, "dstrct__ch")

	-- pst.scrpt(Sys.cmr_id(), "pos__plychara")
end

function Game.map_dstrct__ch_tmp__(_s, dstrct, plychara)
	
	_s._map_dstrct__ch_dstrct   = dstrct
	_s._map_dstrct__ch_plychara = plychara
end

function Game.map_dstrct__ch_tmp__clr(_s, dstrct, plychara)

	if _.t then return end

	_s._map_dstrct__ch_dstrct   = nil
	_s._map_dstrct__ch_plychara = nil
end

function Game.map_dstrct__ch_map_cre(_s)

	_s:map__cre(_s._map_dstrct__ch_dstrct)
	-- log._("Map._final_fnc", _s._game_id, map_id)

	_s:map_cloud__cre()
	local pos = _s._map_dstrct__ch_plychara.pos
	local dir = ha.eq(_s._map_dstrct__ch_plychara.dir, "l") and "l" or "r"
	-- log._("map_dstrct__ch_map_cre", prm.pos, prm.dir)
	_s:map_plychara__cre(pos, dir)
	_s:map_fairy__cre()
	
	_s:map_dstrct__ch_tmp__clr()
	
	pst.scrpt(Sys.cmr_id(), "__dstrct_ch")

	Msg.s("district ".._s._dstrct.x..", ".._s._dstrct.y)
end

-- sky

function Game.sky_idx(_s)
	return _s._sky_idx
end

function Game.sky_id(_s)
	return _s._sky_id
end

function Game.sky__cre(_s)
	
	_s._sky_id = Sky.cre(_s._sky_idx)
end

function Game.sky__del(_s)

	if not _s._sky_id then return end

	pst.scrpt(_s._sky_id, "del")
	_s._sky_id = ha.emp()
end

-- pause

function Game.is_map_pause(_s)

	local ret = id.prp(_s._map_id, "_pause")
	return ret
end

-- bag

function Game.bag_opn(_s)
	-- log._("game bag_opn", _s._bag_id)
	pst.gui(_s._bag_id, "gui:opn")
end

-- dia

function Game.dia__cre(_s)
	-- log._("game dia__cre")

	_s._dia_id = g.Dia.cre()
end

function Game.dia__o(_s)
	-- log._("game dia__o")

	if ha.is_emp(_s._dia_id) then _s:dia__cre() end

	pst.gui(_s._dia_id, "chara__", {chara = Dia.chara})
end

function Game.dia__clr(_s)
	-- log._("game dia__clr")

	_s._dia_id = ha.emp()
end

--

function Game.new_event(_s)

	Ply_data.reizoko.__new()

	-- scnro start
	Ev._("tst")
	-- Ev._("game_start")
	-- Ev._("tree_fall")
	-- Ev._("fire_fall")
	-- Ev._("chara_fall")
end

