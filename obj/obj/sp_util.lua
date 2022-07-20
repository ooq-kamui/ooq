log.scrpt("sp_util.lua")

-- log

function Sp.log(_s, ...)
	log._(_s._cls, ...)
end

function Sp.log_cls(_s, p_cls, ...)

	if _s._cls ~= p_cls then return end

	log._(p_cls, ...)
end

-- ply_slt, save

function Sp.ply_slt_idx(_s)
	local game_id = _s:game_id()
	local ply_slt_idx = id.prp(game_id, "_ply_slt_idx")
	return ply_slt_idx
end

-- anim, anm, sprite

function Sp.anim__(_s, p_anim)
	
	if not p_anim         then return end
	if p_anim == _s._anim then return end

	local p_animHa = ha._(p_anim)
	pst._("#sprite", "play_animation", {id = p_animHa})
	-- log._("sp anim__", p_animHa)

	_s._anim   = p_anim
end

function Sp.anm_cancel_pos(_s)
	go.cancel_animations(_s._id, "position")
end

function Sp.anm_scl__1(_s)
	anm.scl__1(_s._id)
end

function Sp.anm_pos__(_s, p_pos, time)

	anm.pos__(_s:id(), p_pos, time)
end

