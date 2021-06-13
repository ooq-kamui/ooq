log.scrpt("accl.lua")

accl = {}

function accl.dst_6_speed(p_speed, p_accl, t_speed)

	if not p_speed then return end

	p_accl  = p_accl  or Accl.grv_dflt
	t_speed = t_speed or 0

	if p_speed <= 0 then return end
	if p_accl  <= 0 then return end

	local t_dst = 0

	t_dst = - ( t_speed ^ 2 - p_speed ^ 2 ) / ( 2 * p_accl )
	-- log._("accl.dst_6_speed", t_dst)

	return t_dst
end

function accl.speed_6_dst(p_dst, p_accl)

	if not p_dst then return end

	p_accl = p_accl or - Accl.grv_dflt.y

	local t_speed = math.sqrt( 2 * p_accl  * p_dst )
	-- log._("accl.speed_6_dst", p_dst, t_speed)

	return t_speed
end

function accl.dcl_len(speed, p_accl)
	
	if p_accl >= 0 or speed <= 0 then return 0 end

	local len = speed
	while speed > 0 do
		speed = speed + p_accl
		if speed < 0 then speed = 0 end

		len = len + speed
	end
	return len
end

