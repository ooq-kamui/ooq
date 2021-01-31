log.scrpt("nd_anm.lua")

nd.anm = {
	time      = 0.2,
	fade_time = 0.4,
	dsp_time  = 0.25,
}

G_anim = {} -- old

nd.prp = {
	pos = gui.PROP_POSITION,
	pos_x = "position.x",
	pos_y = "position.y",
	scl = gui.PROP_SCALE,
	color = gui.PROP_COLOR,
	color_w = "color.w",
	clr = gui.PROP_COLOR,
	clr_w = "color.w",
	a     = "color.w", -- alpha
}

nd.anm.es = {
	io     = gui.EASING_INOUT,
	sin_io = gui.EASING_INOUTSINE,
	sin_i  = gui.EASING_INSINE,
	sin_o  = gui.EASING_OUTSINE,

	els_o = gui.EASING_OUTELASTIC,

	bnd_o = gui.EASING_OUTBOUNCE,
}

nd.anm.ply = { -- plyopt
	fw = gui.PLAYBACK_ONCE_FORWARD,
	pp = gui.PLAYBACK_ONCE_PINGPONG,

	pp_l = gui.PLAYBACK_LOOP_PINGPONG,
}

function nd.anm.fade__i(p_nd, time, fin)
	-- log._("nd.anm.fade__i")
	local w = 1
	nd.anm.fade__(p_nd, w, time, fin)
end

function nd.anm.fade__o(p_nd, time, fin)
	-- log._("nd.anm.fade__o")
	local w = 0
	nd.anm.fade__(p_nd, w, time, fin)
end

function nd.anm.fade__(p_nd, w, time, fin) -- alias nd.anm.w__()

	time = time or nd.anm.fade_time

	nd.anm.w__(p_nd, w, time, fin)
end

function nd.anm.dsp__o(p_nd, fin, time)
	local val = _.t
	-- nd.anm.dsp__(val, p_nd, nil, fin, time)
	nd.anm.dsp__(p_nd, val, time, fin)
end

function nd.anm.dsp__x(p_nd, fin, time)
	local val = _.f
	-- nd.anm.dsp__(val, p_nd, nil, fin, time)
	nd.anm.dsp__(p_nd, val, time, fin)
end

-- function nd.anm.dsp__(val, p_nd, pos, fin, time) -- old. pos -> del

function nd.anm.dsp__(p_nd, val, time, fin)

	--[[
	local 
	local pos
	local prm = {...}

	if     #prm == 4 then -- new
		p_nd, val, time, fin = ...

	elseif #prm == 5 then -- old
		val, p_nd, pos, fin, time = ...
	end
	--]]
	
	time = time or nd.anm.dsp_time
	
	local w = (val) and 1 or 0

	nd.anm.w__(p_nd, w, time, fin)
end

function nd.anm.w__(p_nd, w, time, fin)
	
	local t_color = nd.color(p_nd)
	t_color.w = w
	
	nd.anm.color__(p_nd, t_color, time, fin)
end

function nd.anm.color__(p_nd, p_color, time, fin)
	gui.animate(p_nd, nd.prp.color, p_color, nd.anm.es.sin_o, time, 0, fin)
end

function nd.anm.mv(p_nd, pos, fin, time)

	time = time or nd.anm.time

	local anim = {}
	anim[1] = function ()
		-- log._("g_anim mv", time)
		gui.animate(p_nd, nd.prp.pos, pos, nd.anm.es.sin_io, time, 0, fin)
	end
	anim[1]()
end

function nd.anm.poyon(p_nd, fin, time, scl_val)

	time = time or 0.35 -- nd.anm.time
	scl_val = scl_val or 1.3
	local scl = n.vec(scl_val, scl_val)

	local anim = {}
	anim[1] = function ()
		gui.animate(p_nd, nd.prp.scl, scl, nd.anm.es.sin_io, time, 0, fin, nd.anm.ply.pp)
	end
	anim[1]()
end

function nd.anm.dkdk(p_nd, time, scl_val)

	time    = time    or 0.35
	scl_val = scl_val or 1.3
	local scl = n.vec(scl_val, scl_val)

	gui.animate(p_nd, nd.prp.scl, scl, nd.anm.es.sin_io, time, 0, nil, nd.anm.ply.pp_l)
end

function nd.anm.scl0(p_nd, fin, time)
	time = time or nd.anm.time
	gui.animate(p_nd, nd.prp.scl, n.vec(), nd.anm.es.sin_io, time, 0, fin, nd.anm.ply.fw)
end

function nd.anm.iyaiya(p_nd, time)
	time = time or 0.7
	-- gui.cancel_animation(p_nd, G_prp.pos_x)
	local pos = nd.pos(p_nd)
	local anim = {}
	anim[1] = function ()
		gui.animate(p_nd, nd.prp.pos_x, pos.x - 10, nd.anm.es.sin_o , time*1/4, 0, anim[2], nd.anm.ply.fw)
	end
	anim[2] = function ()
		gui.animate(p_nd, nd.prp.pos_x, pos.x     , nd.anm.es.bnd_o , time*3/4, 0,     nil, nd.anm.ply.fw)
	end
	anim[1]()
end

function nd.anm.pyon_d_l(p_nd, time)
	time = time or 1
	local pos = nd.pos(p_nd)
	local anim = {}
	anim[1] = function ()
		gui.animate(p_nd, nd.prp.pos_y, pos.y - 7, nd.anm.es.sin_o , time, 0, nil, nd.anm.ply.pp_l)
	end
	anim[1]()
end
