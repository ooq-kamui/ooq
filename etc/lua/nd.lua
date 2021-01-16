log.script("nd.lua")

nd = {}

function nd._(name)
	local r_nd = gui.get_node(name)
	return r_nd
end

function nd.clone(p_nd)
	local r_nd = gui.clone_tree(p_nd)
	return r_nd
end

function nd.del(p_nd)
	gui.delete_node(p_nd)
end

-- enbl

function nd.enbl__o(p_nd)
	nd.enbl__(p_nd, _.t)
end

function nd.enbl__x(p_nd)
	nd.enbl__(p_nd, _.f)
end

function nd.enbl__(p_nd, val)
	gui.set_enabled(p_nd, val)
	nd.dsp__o(p_nd)
end

function nd.pos(p_nd)
	local pos = gui.get_position(p_nd)
	return pos
end

function nd.pos__(p_nd, p_vec)
	p_vec = p_vec or n.vec()
	gui.set_position(p_nd, p_vec)
end

function nd.color(p_nd)
	local color = gui.get_color(p_nd)
	return color
end

function nd.color__(p_nd, color)
	gui.set_color(p_nd, color)
end

function nd.w(p_nd)
	local color = nd.color(p_nd)
	local w = color.w
	return w
end

function nd.w__(p_nd, w)
	local color = nd.color(p_nd)
	color.w = w
	nd.color__(p_nd, color)
end

function nd.dsp__o(p_nd)
	nd.dsp__(p_nd, _.t)
end

function nd.dsp__x(p_nd)
	nd.dsp__(p_nd, _.f)
end

function nd.dsp__(p_nd, val)
	
	local w = (val) and 1 or 0
	
	nd.w__(p_nd, w)
end

function nd.txt(p_nd)
	return gui.get_text(p_nd)
end

function nd.txt__(p_nd, txt)
	gui.set_text(p_nd, txt)
end

function nd.txtr(p_nd)
	local txtr = gui.get_texture(p_nd)
	return txtr
end

function nd.txtr__(p_nd, txtr)
	gui.set_texture(p_nd, txtr)
end

function nd.anim(p_nd)
	log._("nd.anim", p_nd)
	local anim = gui.get_flipbook(p_nd)
	return anim
end

function nd.anm__(p_nd, p_anm)
	gui.play_flipbook(p_nd, p_anm)
end

function nd.order__by_abv(p_nd, p_nd_abv)
	gui.move_above(p_nd, p_nd_abv)
end

function nd.order__by_blw(p_nd, p_nd_blw)
	gui.move_below(p_nd, p_nd_blw)
end

function nd.parent__(p_nd, p_parent_nd)
	gui.set_parent(p_nd, p_parent_nd)
end
