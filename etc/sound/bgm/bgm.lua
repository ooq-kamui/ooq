log.scrpt("bgm.lua")

Bgm = {
	_plying_idx = nil,
	cfg = {
		gain = 0.2, -- 0.4,
		fade_o_gain = 0.003,
		fade_o_intrvl = 0.05,
	},
}

function Bgm.plying_idx()
	if not Bgm._plying_idx then return end
	return Bgm._plying_idx
end

function Bgm.plying_bgm()
	-- log._("bgm plying_bgm", Bgm._plying_idx)
	
	if not Bgm._plying_idx then return end
	
	return Bgm.bgm[Bgm._plying_idx]
end

function Bgm.is_plying()
	local ret
	if Bgm.plying_bgm() then ret = _.t
	else                     ret = _.f
	end
	-- log._("bgm is_plying", ret)
	return ret
end

function Bgm.ply(bgm_idx, gain)
	
	Bgm.stp()
	
	bgm_idx = bgm_idx or 1
	gain    = gain    or Bgm.cfg.gain

	Bgm.gain__()
	local bgm = Bgm.bgm[bgm_idx]
	pst._("/bgm#"..bgm, "play_sound", {delay = 1, gain = gain})
	Bgm._plying_idx = bgm_idx
	Msg.s("bgm:"..bgm)
	log._("Bgm.ply:"..bgm)
end

function Bgm.ply_rnd()
	local bgm_idx = rnd.int(1, #Bgm.bgm)
	Bgm.ply(bgm_idx)
end

function Bgm.ply_nxt()
	local bgm_idx = u.inc_loop(Bgm._plying_idx, #Bgm.bgm)
	Bgm.ply(bgm_idx)
end

function Bgm.gain()
	local gain = sound.get_group_gain("master")
	return gain
end

function Bgm.gain__(gain)

	gain = gain or Bgm.cfg.gain
	
	-- log._("bgm gain__", gain)
	sound.set_group_gain("master", gain)
end

function Bgm.gain__fade_o()
	
	local gain = Bgm.gain()
	gain = gain - Bgm.cfg.fade_o_gain
	Bgm.gain__(gain)
	
	return gain
end

function Bgm.stp()

	if not Bgm.is_plying() then return end

	pst._("/bgm#"..Bgm.plying_bgm(), "stop_sound")
	Bgm._plying_idx = nil
end

function Bgm.fade_o_ply_rnd()
	local bgm_idx = rnd.int(1, #Bgm.bgm, Bgm._plying_idx)
	-- log._("Bgm fade_o_ply_rnd bgm_idx", bgm_idx)
	Bgm.fade_o_ply(bgm_idx)
end

function Bgm.fade_o_ply(bgm_idx)

	bgm_idx = bgm_idx or 1

	if not Bgm.is_plying() then
		Bgm.ply(bgm_idx)
		return
	end

	local fnc = function (slf, hndl, elpsd)
		-- log._("bgm fade_o_ply fnc")

		local gain = Bgm.gain__fade_o()
		if gain <= 0 then
			timer.cancel(hndl)
			Bgm.ply(bgm_idx)
		end
	end
	local hndl = timer.delay(Bgm.cfg.fade_o_intrvl, _.t, fnc)
end
