log.script("obj.lua")

Obj = {}
Obj.fac = "objFac#"
Obj.fall = {}

function Obj.fall.tst()
	local Cls = {
		Chara,
		Block,
		Animal,
		Seed,
		Kagu,
		Plant,
		Bush, Bush,
		Mshrm, Mshrm, Mshrm,
		Fluff, Fluff,
		Flower, Flower,
		Dish, Dish, Dish, Dish, Dish, Dish,
	}
	Obj.fall._(Cls)
end

function Obj.fall.chara()
	local Cls = {
		Chara,Chara,Chara,Chara,Chara,Chara,
		Chara,Chara,Chara,Chara,Chara,Chara,
		Seed,Seed,Seed,Seed,
	}
	Obj.fall._(Cls)
end

function Obj.fall.fire()
	local Cls = {
		Chara, -- Chara,Chara,Chara,Chara,
		Fire,Fire,Fire,Fire, -- Fire,Fire,
		Seed, -- Seed,Seed,Seed,Seed,
		Wood,Wood,Wood,Wood,Wood,
		Leaf,Leaf,Leaf,
		Dryleaf,Dryleaf,Dryleaf,Dryleaf,Dryleaf,
	}
	Obj.fall._(Cls)
end

function Obj.fall.tree()
	local Cls = {
		Chara, -- Chara,Chara,Chara,Chara,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
		Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,Tree,
	}
	Obj.fall._(Cls)
end

function Obj.fall.game_start()
	
	local Cls = {
		Chara, -- Chara,Chara,Chara,Chara,
		Animal,Animal,Animal,Animal,Animal,Animal,Animal,Animal,
		---[[
		Flower,Flower,Flower,Flower,
		Veget,Veget,Veget,Veget,Veget,Veget,
		Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,Seed,
		Plant,Plant,Plant,
		Tree,Tree,Tree,Tree,Tree,Tree,
		Fruit,Fruit,Fruit,Fruit,Fruit,
		Egg,Egg,Egg,Egg,Egg,Egg,Egg,Egg,Egg,
		Fish,Fish,Fish,Fish,
		Dish,Dish,Dish,
		Dairy,Dairy,Dairy,
		Meat,Meat,Meat,
		Fruit,Fruit,Fruit,
		Wood,Wood,Wood,Wood,
		Leaf,Leaf,Leaf,
		Dryleaf,Dryleaf,Dryleaf,Dryleaf,
		Kagu,Kagu,Kagu,Kagu,Kagu,Kagu,
		Grave,
		Phantom,
		Fire,
		Door,Door,
		-- Block,Block,Block,Block,Block,
		--]]
	}
	Obj.fall._(Cls)
end

function Obj.fall._(p_Cls)
	
	local pos = n.vec(-800, 200)
	local y, idx
	local cnt = 1
	local pos_ini = n.vec(pos.x, pos.y)
	local rng = Game.map_rng_pos()
	while #p_Cls > 0 do
		idx = rnd.int(1, #p_Cls)
		p_Cls[idx].cre(pos, nil)
		ar.del_by_idx(p_Cls, idx)
		pos.x = pos.x + Map.sq
		if pos.x > rng.max.x - Map.verge then
			pos.x = pos_ini.x + cnt * 10
			cnt = cnt + 1
		end
		y = rnd.int(0, 1)
		pos.y = pos.y + Map.sq * y
	end
end
