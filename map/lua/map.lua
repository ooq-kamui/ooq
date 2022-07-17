log.scrpt("map.lua")

Map = {
	sq = 48,

	area = {
		"grassy",
		"snow",
	},
	tilemap = {"ground", "wall", "underground", },
	
	act_intrvl_time = 15, -- 45, -- 5,

	-- obj
	chara = {
		-- {name = "", id = hash}
	},
	chara_clb = {
		fe     = {},
		tohoku = {},
	},

	dstrct_max = n.vec(1, 1),
	
	-- pause = _.f,
}
Map.tilemap_dflt = Map.tilemap[1]
Map.layer        = Map.tilemap
Map.layer_dflt   = Map.layer[1]

Map.sqh   = Map.sq / 2 -- half
Map.sqq   = Map.sq / 4 -- quarter
Map.verge = Map.sq * 4 -- use scroll

Map.maptip = n.vec(Map.sq, Map.sq)

Map.inside = {
	mrgn = {
		lr = Map.sq,
		l  = Map.sq,
		r  = Map.sq,
		ud = Map.sq,
		u  = Map.sq,
		d  = Map.sq,
	},
}
Map.dstrct_mv = {
	mrgn = {
		lr = Map.sq * 2,
		l  = Map.sq * 2,
		r  = Map.sq * 2,
		ud = Map.sq * 2,
		u  = Map.sq * 2,
		d  = Map.sq * 2,
	},
}

Map.obj = nil -- alias -- old

-- static

function Map.cre(p_clct)

	local area = "grassy"

	local clct_url = "/map-clct-fac#"..area.."-"..p_clct
	local t_pos = n.vec()
	local prm = {}
	prm[ha._("/ground")] = {
		_areaHa = ha._(area),
	}
	local clct_id = clct.cre(clct_url, t_pos, prm)
	local map_id  = clct_id["/ground"]
	
	Map.chara__clr()

	return map_id
end

function Map.chara__clr()

	ar.clr(Map.chara           )
	ar.clr(Map.chara_clb.fe    )
	ar.clr(Map.chara_clb.tohoku)
end

-- scrpt method

function Map.init(_s)

	extnd._(_s, Map)

	_s._id          = id._()
	_s._game_id     = Game.id()
	_s._ply_slt_idx = Game.ply_slt_idx()
	_s._dstrct      = id.prp(_s._game_id, "_dstrct")
	
	_s._act_intrvl = 0

	_s:rng_pos__init()
	_s:dstrct_mv_rng_pos__init()
	
	_s:save_data__init()
	
	_s._obj = {} -- cnt
	Map.obj = _s._obj -- alias -- old
	Mapobj.init(_s._id) -- old

	_s:tile_xy__init()

	_s:new_or_load()
end

function Map.new_or_load(_s)

	local is_exst, file_idx_ltst = file.map.is_exst(_s._ply_slt_idx, _s._dstrct)

	local prm = {}
	if not is_exst then
		pst._(".", "new" , prm)
	else
		prm.file_idx = file_idx_ltst
		pst._(".", "load", prm)
	end
	-- log._("Map.new_or_load()", _s._dstrct)
end

function Map.cmr_pos__plychara(_s)
	pst.scrpt(Sys.cmr_id(), "pos__plychara")
end

function Map.on_msg(_s, msg_id, prm, sndr_url)
	
	if     ha.eq(msg_id, "del" ) then
		_s:del()

	elseif ha.eq(msg_id, "new" ) then
		_s:new(prm.plychara_pos)

	elseif ha.eq(msg_id, "load") then
		_s:load(prm.file_idx, prm.plychara_pos)

	elseif ha.eq(msg_id, "save") then
		_s:save()

	elseif ha.eq(msg_id, "save_del"  ) then
		_s:save_del()

	elseif ha.eq(msg_id, "dstrct__ch") then
		_s:dstrct__ch(prm.plychara)
		
	elseif ha.eq(msg_id, "pause__"   ) then
		_s:pause__(prm.val)
		
	elseif ha.eq(msg_id, "cloud__cre") then
		_s:cloud__cre()
		
	elseif ha.eq(msg_id, "plychara__cre") then
		_s:plychara__cre(prm.pos, prm.dir)

	elseif ha.eq(msg_id, "fairy__cre"   ) then
		_s:fairy__cre(prm.pos, prm)

	elseif ha.eq(msg_id, "save_data_obj__") then
		_s:save_data_obj__(prm)

	elseif ha.eq(msg_id, "pf__file__save" ) then
		_s:pf__file__save(sndr_url)

	elseif ha.eq(msg_id, "file__save") then
		_s:file__save()

	elseif ha.eq(msg_id, "obj__add"  ) then
		_s:obj__add(prm.id, prm.cls)

	elseif ha.eq(msg_id, "obj__del"  ) then
		_s:obj__del(prm.id, prm.cls)

	elseif ha.eq(msg_id, "obj_cnt_all") then
		_s:obj_cnt_all()

	elseif ha.eq(msg_id, "fade__i")  then
		_s:fade__i(nil, prm.delay)

	elseif ha.eq(msg_id, "fade__o")  then
		_s:fade__o(nil, prm.delay)

	elseif ha.eq(msg_id, "fade__oi") then
		_s:fade__oi(nil, prm.delay)

	elseif ha.eq(msg_id, "drk__i") then
		_s:drk__i()

	elseif ha.eq(msg_id, "drk__o") then
		_s:drk__o()

	elseif ha.eq(msg_id, "tile__") then
		_s:tile__(prm.pos, prm.tile)

	elseif ha.eq(msg_id, "tile_xy_obj__del_add") then
		_s:tile_xy_obj__del_add(prm.id, prm.cls, prm.pos_c, prm.pos_n)

	elseif ha.eq(msg_id, "tile_xy_obj__add")     then
		_s:tile_xy_obj__add(prm.id, prm.cls, prm.pos)

	elseif ha.eq(msg_id, "tile_xy_obj__del")     then
		_s:tile_xy_obj__del(prm.id, prm.cls, prm.pos)
	end
end

function Map.final(_s)

	if _s._final_fnc then _s._final_fnc() end
end

-- method

function Map.new(_s, plychara_pos)
	
	_s:obj__new()
	
	_s:tile_xy_tile__crnt()
end

function Map.load(_s, file_idx)

	if not _s._ply_slt_idx then return end
	if not _s._dstrct      then return end
	
	local save_data = file.map.load(_s._ply_slt_idx, _s._dstrct, file_idx)

	if not save_data then return end

	_s:tiles__save_data(save_data["tile"])
	_s:obj__save_data_obj_ar( save_data["obj"] )

	_s:tile_xy_tile__crnt()
	
	Msg.s("load complete")
	-- Se.pst_ply("exe")
end

function Map.save_data__init(_s)

	_s._save_data = {}
	_s._save_data.tile = {}
	_s._save_data.obj  = {}
end

function Map.save_data__clr(_s)

	ar.clr(_s._save_data.tile)

	for t_cls, obj_ar in pairs(_s._save_data.obj) do
		ar.clr(obj_ar)
	end
end

function Map.save(_s)

	_s:pf__save_data__()

	pst.scrpt(_s._id, "pf__file__save")
end

function Map.pf__save_data__(_s)

	_s:save_data__clr()

	_s._save_data.tile = _s:save_data_tiles()

	_s:pf__save_data_obj__()
end

function Map.pf__file__save(_s, sndr_url)

	_s:pb__file__save(sndr_url)
end

function Map.pb__file__save(_s, sndr_url)

	pst._(sndr_url, "file__save")
end

function Map.file__save(_s)
	-- log.pp("Map.file__save", _s._save_data.obj)

	file.map.save(_s._ply_slt_idx, _s._dstrct, _s._save_data)
end

function Map.del(_s)

	_s:obj__clr()

	go.delete(_.t)
end

function Map.obj__clr(_s)

	for t_cls, t_id_ar in pairs(_s._obj) do
		ar.clr(t_id_ar)
	end
end

function Map.save_del(_s)
	-- log._("save_del")

	_s:save()
	_s:del()
end

function Map.dstrct__ch(_s, plychara)

	_s._final_fnc = function ()
		pst.scrpt(_s._game_id, "map_dstrct__ch_map_cre", {plychara = plychara})
	end
	
	_s:save_del()
end

-- xxx_id

function Map.game_id(_s)
	return _s._game_id
end

function Map.cloud_id(_s)
	return _s._cloud_id
end

function Map.plychara_id(_s)
	return _s._plychara_id
end

function Map.plychara_pos(_s)

	if not _s._plychara_id then return end

	local plychara_pos = id.pos(_s._plychara_id)
	return plychara_pos
end

function Map.fairy_id(_s)
	return _s._fairy_id
end

function Map.tilemap_url(_s, p_tilemap)

	if not _s._id then return end
	
	local tilemap_url = url._(_s._id, p_tilemap)
	return tilemap_url
end

function Map.pause__(_s, val)

	_s._pause = val
end

function Map.rng_pos__init(_s)

	_s._rng_pos = map.rng_pos(_s._id, "ground", _s._tilesize)

	_s._rng_pos_min = _s._rng_pos.min
	_s._rng_pos_max = _s._rng_pos.max
	
	return _s._rng_pos
end

function Map.rng_pos(_s)

	if _s._rng_pos then return _s._rng_pos end

	_s:rng_pos__init()
	return _s._rng_pos
end

function Map.dstrct_mv_rng_pos__init(_s)

	local rng_pos = _s:rng_pos()

	_s._dstrct_mv_rng_pos = {
		min = n.vec(rng_pos.min.x - Map.dstrct_mv.mrgn.l, rng_pos.min.y - Map.dstrct_mv.mrgn.d),
		max = n.vec(rng_pos.max.x + Map.dstrct_mv.mrgn.r, rng_pos.max.y + Map.dstrct_mv.mrgn.u),
	}
	_s._dstrct_mv_rng_pos_min = _s._dstrct_mv_rng_pos.min
	_s._dstrct_mv_rng_pos_max = _s._dstrct_mv_rng_pos.max
	
	return _s._dstrct_mv_rng_pos
end

-- anm

function Map.fade__i(_s, fnc, delay)

	delay = delay or 0

	anm.fade__i(_s._id, "ground", nil, delay, fnc)
end

function Map.fade__o(_s, fnc, delay)

	delay = delay or 0

	anm.fade__o(_s._id, "ground", nil, delay, fnc)
end

function Map.fade__oi(_s, fnc, delay)

	local t_anm = {}
	t_anm[1] = function ()
		_s:fade__o(t_anm[2])
	end
	t_anm[2] = function ()
		if fnc then
			fnc()
		end
		t_anm[3]()
	end
	t_anm[3] = function ()
		_s:fade__i()
	end
	t_anm[1]()
end

function Map.drk__i(_s, fnc)

	local time = 60
	anm.drk__i(_s._id, "ground", time, nil, fnc)
end

function Map.drk__o(_s, fnc)

	local time = 60
	anm.drk__o(_s._id, "ground", time, nil, fnc)
end

-- static

function Map.chara_is_appear_all()

	local ret = _.f

	if #Map.chara >= #Chara.chara then
		ret = _.t
	end
	return ret
end

function Map.not_appear_chara()

	local not_appear = ar.exclude_cp(Chara.chara, Map.chara)
	return not_appear
end

function Map.chara_clb_fe_is_appear_all()

	local ret = _.f
	if #Map.chara_clb.fe >= #Chara_clb_fe.chara then ret = _.t end
	return ret
end

function Map.not_appear_chara_clb_fe()

	local not_appear = ar.exclude_cp(Chara_clb_fe.chara, Map.chara_clb.fe)
	return not_appear
end

function Map.chara_clb_tohoku_is_appear_all()

	local ret = _.f
	if #Map.chara_clb.tohoku >= #Chara_clb_tohoku.chara then ret = _.t end
	return ret
end

function Map.not_appear_chara_clb_tohoku()

	local not_appear = ar.exclude_cp(Chara_clb_tohoku.chara, Map.chara_clb.tohoku)
	return not_appear
end

--[[
function Map.upd(_s, dt)
	_s:act_intrvl(dt)
end

function Map.act_intrvl(_s, dt)
	if not _s:is_loop__act_intrvl__(dt) then return end
end

function Map.is_loop__act_intrvl__(_s, dt)
	local is_loop = _s:act_intrvl__(dt)
	return is_loop
end

function Map.act_intrvl__(_s, dt)
	local is_loop
	_s._act_intrvl, is_loop = num.pls_loop(_s._act_intrvl, dt, Map.act_intrvl_time)
	return is_loop
end
--]]

