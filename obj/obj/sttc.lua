log.scrpt("sttc.lua")

Sttc = {}

function Sttc.upd_pos_sttc(_s)

	if _s:is_grv_off() then return end

	if _s:is_grounding() then
		_s:accl_speed__clr()
		
		_s:pos__6_tile()
	else
		_s:vec_grv__() -- 3sec

		_s:vec_total__() -- 3sec

		_s:pos__pls_vec_total() -- 3sec
	end
end

function Sp.upd_pos_sttc(_s) -- 3sec root

	if _s:is_grv_off() then return end

	if _s:is_grounding() then
		_s:accl_speed__clr()
		
		_s:pos__6_tile()
	else
		_s:vec_grv__() -- 3sec

		_s:vec_total__() -- 3sec

		_s:pos__pls_vec_total() -- 3sec
	end
end

