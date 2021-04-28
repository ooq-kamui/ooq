log.scrpt("kitchen.lua")

Kitchen = {

	act_intrvl_time = 10,
	name_idx_max = 1,
	z = 0.1,
	
	weight = 2,

	timer = 5.4,
	on_max = 2,
}
Kitchen.cls = "kitchen"
Kitchen.fac = Obj.fac..Kitchen.cls
Cls.add(Kitchen)

-- static

function Kitchen.cre(p_pos, prm)
	local Cls = Kitchen
	local t_id = Sp.cre(Cls, p_pos, prm)
	return t_id
end

-- script method

function Kitchen.init(_s)
	
	extend.init(_s, Sp)
	extend.init(_s, Hldabl)
	extend._(_s, Kitchen)
	
	_s.on = {} -- id ar
	_s.complete = _.f
	_s._cooking_timer = 0
end

function Kitchen.upd(_s, dt)

	-- cooking
	_s:upd_cooking()

	_s:upd_pos_static(dt)

	-- cooking timer dec
	_s:upd_cooking_timer(dt)

	_s:upd_final()
end

function Kitchen.upd_cooking(_s)
	if _s.complete == _.t then
		_s:cre_dish()
		_s.complete = _.f
	end
end

function Kitchen.upd_cooking_timer(_s, dt) -- dec
	if _s._cooking_timer > 0 then
		_s._cooking_timer = _s._cooking_timer - dt
		if _s._cooking_timer <= 0 then
			_s.complete = _.t
		end
	end
end

function Kitchen.on_msg(_s, msg_id, prm, sndr)
	
	Sp.on_msg(_s, msg_id, prm, sndr)
	Hldabl.on_msg(_s, msg_id, prm, sndr)
	
	if     ha.eq(msg_id, "kitchen__o") then
		_s:kitchen__o(prm.id)
	
	elseif ha.eq(msg_id, "kitchen__x") then
		_s:kitchen__x(prm.id)
	end
end

function Kitchen.final(_s)
	
	Sp.final(_s)
	Hldabl.final(_s)
	
	for idx, food_id in pairs(_s.on) do
		pst.scrpt(food_id, "kitchen__x")
	end
end

-- method

function Kitchen.kitchen__o(_s, food_id)
	
	if not ar.inHa(id.cls(food_id), Food.cookabl) then return end
	
	if #_s.on >= Kitchen.on_max then return end
	
	ar.add(_s.on, food_id)
	pst.scrpt(food_id, "kitchen__o", {id = _s._id})
	
	_s:_food_pos__()
	
	if #_s.on < Kitchen.on_max then return end
	
	_s:cooking_start()
end

function Kitchen._food_pos__(_s)

	local x, pos
	for idx, food_id in ipairs(_s.on) do
		x = u.x_by_all_w(idx, Kitchen.on_max, Map.sq)
		pos = n.vec(x, Map.sqh*3/2)
		
		pst.parent__(food_id, _s._id)
		pst.scrpt(food_id, "pos__", {pos = pos})
	end
end

function Kitchen.cooking_start(_s)
	
	_s._cooking_timer = Kitchen.timer
	Se.pst_ply("cooking")
	
	local t_pos, delay
	for idx, food_id in ipairs(_s.on) do
		delay = (idx - 1) * 0.5
		t_pos = id.pos(food_id)
		go.animate(food_id, "position.y", es.pinpon, t_pos.y + Map.sq, es.bnd_i, Kitchen.timer - delay, delay)
	end
end

function Kitchen.kitchen__x(_s, food_id)
	-- log._("kitchen kitchen__x")
	
	if not (#_s.on > 0) then return end

	ar.del_by_val(food_id, _s.on)
	
	_s._cooking_timer = 0

	-- log._("kitchen__x _s.on", unpack(_s.on))
end

function Kitchen.cre_dish(_s)

	for idx, id in pairs(_s.on) do
		pst.scrpt(id, "cook_to_dish")
	end
	for idx = 1, #_s.on do
		table.remove(_s.on)
	end
	
	local pos_w = _s:pos_w() + n.vec(0, Map.sqh)
	
	local dish_id = Dish.cre(pos_w)
	
	local time = 0.7
	local y = pos_w.y + Map.sq
	go.animate(dish_id, "position.y", es.pinpon, y, es.sin_o, time)
	-- go.animate(dish_id, "position.y", go.PLAYBACK_ONCE_PINGPONG, y, go.EASING_OUTSINE, time)
	return dish_id
end

function Kitchen.log(_s)
	log._("kitchen.self.on:", unpack(_s.on))
end

