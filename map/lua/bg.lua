log.script("bg.lua")

Bg = {
	_ = {},

	_cmr_pos_rng = nil,
}

-- script

function Bg.init(_s)

	_s._id = go.get_id()
	_s._tilemap = _s._name

	_s._cmr_pos_rate = n.vec()
	_s._bg_mv_scl    = n.vec()
	
	-- log._("Bg.init", _s._map_id, _s._map_tilesize)
end

function Bg.upd(_s, dt)
	_s:pos__()
end

function Bg.pos__(_s, pos)
	-- log._("bg pos__", _s._area, _s._name)

	pos = pos or _s:pos_by_bg_mv_scl()

	id.pos__(_s._id, pos)
end

function Bg.rng_pos(_s)

	if _s._rng_pos then return _s._rng_pos end
	
	_s._rng_pos = map.rng_pos(_s._id, _s._tilemap , _s._tilesize)

	return _s._rng_pos
end

function Bg.map_rng_pos(_s)

	if _s._map_rng_pos then return _s._map_rng_pos end

	local map_id, map_tilesize = _s:map_id(), _s:map_tilesize()
	_s._map_rng_pos = map.rng_pos(map_id, "ground", map_tilesize)
	return _s._map_rng_pos
end

function Bg.map_id(_s)

	if _s._map_id then return _s._map_id end

	_s._map_id = Game.map_id()
	return _s._map_id
end

function Bg.map_tilesize(_s)

	if _s._map_tilesize then return _s._map_tilesize end

	_s._map_tilesize = id.prp(_s:map_id(), "_tilesize")
	return _s._map_tilesize
end

function Bg.pos_by_bg_mv_scl(_s)

	local bg_mv_scl   = _s:bg_mv_scl()
	local mv_cntr_pos = _s:mv_cntr_pos()
	local mv_len_hlf  = _s:mv_len_hlf()
	
	local x = mv_cntr_pos.x + mv_len_hlf.x * bg_mv_scl.x
	local y = mv_cntr_pos.y + mv_len_hlf.y * bg_mv_scl.y
	local pos = n.vec(x, y)
	return pos
end

function Bg.mv_len_hlf(_s)

	if _s._mv_len_hlf then return _s._mv_len_hlf end

	local mv_len = _s:mv_len()
	
	_s._mv_len_hlf = mv_len / 2

	return _s._mv_len_hlf
end

function Bg.mv_len(_s)

	if _s._mv_len then return _s._mv_len end

	local mv_rng_pos   = _s:mv_rng_pos()
	
	_s._mv_len = n.vec(mv_rng_pos.max.x - mv_rng_pos.min.x, mv_rng_pos.max.y - mv_rng_pos.min.y)

	return _s._mv_len
end

function Bg.mv_cntr_pos(_s)

	if _s._mv_cntr_pos then return _s._mv_cntr_pos end

	local mv_rng_pos   = _s:mv_rng_pos()
	
	local x = ( mv_rng_pos.max.x + mv_rng_pos.min.x ) / 2
	local y = ( mv_rng_pos.max.y + mv_rng_pos.min.y ) / 2
	_s._mv_cntr_pos = n.vec(x, y)

	return _s._mv_cntr_pos
end

function Bg.mv_rng_pos(_s)

	if _s._mv_rng_pos then return _s._mv_rng_pos end
	
	if     ha.is_emp(_s._mv_rng_pos_algn) then
		_s:mv_rng_pos__c()
		
	elseif ha.eq(_s._mv_rng_pos_algn, "c") then
		_s:mv_rng_pos__c()
		
	elseif ha.eq(_s._mv_rng_pos_algn, "d") then
		_s:mv_rng_pos__d()

	elseif ha.eq(_s._mv_rng_pos_algn, "d_hrzn") then
		_s:mv_rng_pos__d_hrzn()
	end
	
	return _s._mv_rng_pos
end

function Bg.mv_rng_pos__c(_s)

	-- if _s._mv_rng_pos then return _s._mv_rng_pos end

	local map_rng_pos = _s:map_rng_pos()
	local rng_pos     = _s:rng_pos()
	
	_s._mv_rng_pos = {
		min = n.vec(map_rng_pos.min.x - rng_pos.min.x, map_rng_pos.min.y - rng_pos.min.y),
		max = n.vec(map_rng_pos.max.x - rng_pos.max.x, map_rng_pos.max.y - rng_pos.max.y),
	}
end

function Bg.mv_rng_pos__d(_s)

	local map_rng_pos = _s:map_rng_pos()
	
	local cmr_view_y = Cmr.far.z * 2 * ( Disp.y / Disp.x ) + Map.sq * 3
	
	local rng_pos = _s:rng_pos()

	local max_y = map_rng_pos.max.y - cmr_view_y - rng_pos.min.y
	
	_s._mv_rng_pos = {
		min = n.vec(map_rng_pos.min.x - rng_pos.min.x, map_rng_pos.min.y - rng_pos.min.y),
		max = n.vec(map_rng_pos.max.x - rng_pos.max.x, max_y),
	}
end

function Bg.mv_rng_pos__d_hrzn(_s)

	local map_rng_pos = _s:map_rng_pos()

	local cmr_view_y = Cmr.far.z * 2 * ( Disp.y / Disp.x ) + Map.sq * 3

	local rng_pos = _s:rng_pos()

	local max_y = map_rng_pos.max.y - cmr_view_y - rng_pos.min.y

	_s._mv_rng_pos = {
		min = n.vec(map_rng_pos.min.x - rng_pos.min.x, 0 - rng_pos.min.y),
		max = n.vec(map_rng_pos.max.x - rng_pos.max.x, max_y),
	}
end

function Bg.bg_mv_scl(_s)
	
	if ha.eq(_s._mv_rng_pos_algn, "d_hrzn") then
		_s:bg_mv_scl__d_hrzn()
	else
		_s:cmr_pos_rate__()
		_s._bg_mv_scl.x = _s._cmr_pos_rate.x
		_s._bg_mv_scl.y = _s._cmr_pos_rate.y
	end
	return _s._bg_mv_scl
end

function Bg.cmr_pos_rate__(_s)

	local cmr_pos = Sys.cmr_pos()
	local cmr_pos_rng = _s:cmr_pos_rng()

	_s._cmr_pos_rate.x = cmr_pos.x / cmr_pos_rng.max.x
	_s._cmr_pos_rate.y = cmr_pos.y / cmr_pos_rng.max.y
	
	if     _s._cmr_pos_rate.x >  1 then
		_s._cmr_pos_rate.x =  1
	elseif _s._cmr_pos_rate.x < -1 then
		_s._cmr_pos_rate.x = -1
	end
	if     _s._cmr_pos_rate.y >  1 then
		_s._cmr_pos_rate.y =  1
	elseif _s._cmr_pos_rate.y < -1 then
		_s._cmr_pos_rate.y = -1
	end
end

function Bg.bg_mv_scl__d_hrzn(_s)

	local cmr_pos = Sys.cmr_pos()
	local cmr_pos_rng = _s:cmr_pos_rng()
	local map_rng_pos = _s:map_rng_pos()
	
	_s._bg_mv_scl.x = cmr_pos.x / cmr_pos_rng.max.x
	_s._bg_mv_scl.y = ( cmr_pos.y - map_rng_pos.max.y ) / ( cmr_pos_rng.max.y / 2)

	if     _s._bg_mv_scl.x >  1 then
		_s._bg_mv_scl.x =  1
	elseif _s._bg_mv_scl.x < -1 then
		_s._bg_mv_scl.x = -1
	end
	if     _s._bg_mv_scl.y >  1 then
		_s._bg_mv_scl.y =  1
	elseif _s._bg_mv_scl.y < -1 then
		_s._bg_mv_scl.y = -1
	end
end

function Bg.cmr_pos_rng(_s)

	if Bg._cmr_pos_rng then return Bg._cmr_pos_rng end

	local mrgn_x = Cmr.far.z                       + Map.sq * 2
	local mrgn_y = Cmr.far.z * ( Disp.y / Disp.x ) + Map.sq * 2
	local map_rng_pos = _s:map_rng_pos()
	
	Bg._cmr_pos_rng = {
		min = n.vec(map_rng_pos.min.x + mrgn_x, map_rng_pos.min.y + mrgn_y),
		max = n.vec(map_rng_pos.max.x - mrgn_x, map_rng_pos.max.y - mrgn_y),
	}
	
	return Bg._cmr_pos_rng
end
