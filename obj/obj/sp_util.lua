log.scrpt("sp_util.lua")

-- log

function Sp.log(_s, ...)
	log._(_s._clsHa, ...)
end

function Sp.log_only_cls(_s, cls, ...)
	if _s._clsHa == ha._(cls) then
		log._(cls, ...)
	end
end

-- ply_slt, save

function Sp.ply_slt_idx(_s)
	local game_id = _s:game_id()
	local ply_slt_idx = id.prp(game_id, "_ply_slt_idx")
	return ply_slt_idx
end

-- anim, anm, sprite

function Sp.animHa__(_s, animHa)
	
	if ha.is_emp(animHa) then return end

	pst._("#sprite", "play_animation", {id = animHa})

	_s._animHa = animHa
end

function Sp.anim__(_s, p_anim)
	
	if not p_anim         then return end
	if p_anim == _s._anim then return end

	local p_animHa = ha._(p_anim)
	pst._("#sprite", "play_animation", {id = p_animHa})

	_s._anim   = p_anim
	_s._animHa = p_animHa
end

function Sp.anm_cancel_pos(_s)
	go.cancel_animations(_s._id, "position")
end

function Sp.anm_scl__1(_s)
	-- log._("sp anm_scl__1")
	anm.scl__1(_s._id)
end

function Sp.anm_pos__(_s, p_pos, time)

	anm.pos__(_s:id(), p_pos, time)
end

function Sp.flip_h__(_s, val)
	sprite.set_hflip("#sprite", val)
end

function Sp.flip_h__dir(_s, dir_h)

	if dir_h then _s:dir_h__(dir_h) end
	
	local val = _.f
	if     ha.eq(_s._dir_h_Ha, "l") then
		val = _.f
	elseif ha.eq(_s._dir_h_Ha, "r") then
		val = _.t
	end
	_s:flip_h__(val)
end

