log.scrpt("spwood.lua")

Spwood = {}

-- script method

function Spwood.__init(_s)
end

function Spwood.on_msg(_s, msg_id, prm, sndr_url)
	
	Sp    .on_msg(_s, msg_id, prm, sndr_url)
	Hldabl.on_msg(_s, msg_id, prm, sndr_url)

	if ha.eq(msg_id, "burn") then
		_s:burn()
	end
end

function Spwood.final(_s)

	Sp    .final(_s)
	Hldabl.final(_s)
end

function Spwood.burn(_s)
	-- log._("wpwood burn")
	_s:trnsf(Fire)
end

