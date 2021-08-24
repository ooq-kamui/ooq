log.scrpt("warp.lua")

Warp = {
	t_cls = {"chara", "plychara"},
}

-- scrpt method

function Warp.__init(_s)
end

function Warp.on_msg_clsn(_s, msg_id, prm, sndr_url)
	
	if not ha.eq_cpr(msg_id) then return end
	
	if _s._hldd_id then return end

	local o_pos = prm.other_position
	local o_id  = prm.other_id

	if ar.inHa(prm.group, Warp.t_cls) then

		local accl_speed = id.prp(o_id, "_accl_speed")
		if accl_speed.y < 0 then
			pst.scrpt(o_id, "to_cloud")
		end
	end
end

