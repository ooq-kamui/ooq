log.scrpt("warp.lua")

Warp = {
	act_interval_time = 50,
	name_idx_max = 1,
}
Warp.cls = "warp"
Warp.Fac = Obj.fac..Warp.cls
Cls.add(Warp)

function Warp.cre(pos, prm)
	local Cls = Warp
	local id = Sp.cre(Cls, pos, prm)
	return id
end

-- script method

function Warp.init(_s)
	
	extend.init(_s, Sp)
	extend._(_s, Warp)
end

function Warp.on_msg(_s, msg_id, prm, sender)
	
	Sp.on_msg(_s, msg_id, prm, sender)
	
	_s:on_msg_clsn(msg_id, prm, sender)
end

function Warp.on_msg_clsn(_s, msg_id, prm, sender)
	
	if not ha.eq(msg_id, "contact_point_response") then return end
	
	local o_pos = prm.other_position
	local o_id  = prm.other_id
	if ar.inHa(prm.group, {"chara", "player"}) then
		pst.scrpt(o_id, "to_cloud")
	end
end
