log.scrpt("se.lua")

Se = {}

-- static

function Se.pst_ply(se)
	pst._("/se#script", "play_gate_sound", {se = se})
end
