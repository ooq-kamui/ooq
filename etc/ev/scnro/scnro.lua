log.scrpt("scnro.lua")

Scnro = {}

Scnro.tst = {
	function ()
		Obj.fall.tst()
		D.c("sanae")
		---[[
		D.v("わーい")
		D._("こんかいは")
		D.v("fairy ちゃん をつくりました")
		D._("わたしの まわりを とんでいるのが")
		D.v("fairy ちゃん だよ")
		D._("fairy ちゃん は")
		D._("block を つくる いち の")
		D.x("めじるし に なるよ")
		--]]
	end,
}

Scnro.chara_fall = {
	function ()
		Obj.fall.chara()
		D.c("sanae")
		D.x("わー")
	end,
	---[[
	function ()
		Wa._(1.5)
	end,
	function ()
		D.c("sanae")
		D._("！")
		D.v("わたしと いっしょに ...")
		D._("みんなも おちてきた！")
		D.x("たのしいね")
	end,
	--]]
}

Scnro.fire_fall = {
	function ()
		Obj.fall.fire()
		D.c("sanae")
		D.x("わー")
	end,
	---[[
	function ()
		Wa._(1.5)
	end,
	function ()
		D.c("sanae")
		D.v("！")
		D._("わたしと いっしょに ...")
		D.v("ひ が おちてきた！")
		D._("き の ブロック には")
		D._("もえ うつっちゃう から")
		D.x("つくっちゃ だめだよ！")
	end,
	--]]
}

Scnro.tree_fall = {
	function ()
		Obj.fall.tree()
		D.c("sanae")
		D.x("わー")
	end,
	---[[
	function ()
		Wa._(1.5)
	end,
	function ()
		D.c("sanae")
		D.v("！")
		D._("わたしと いっしょに ...")
		D._("たくさんの きが ...")
		D.v("ふってきてる！")
		D._("きっと これは")
		D.v("かみさまの おめぐみよ")
		D._("いっぱい しゅうかく")
		D.x("しちゃいましょう！")
	end,
	--]]
}

Scnro.game_start = {
	function ()
		Obj.fall.game_start()
		D.c("sanae")
		D.x("わー")
	end,
	---[[
	function ()
		Wa._(1.5)
	end,
	function ()
		D.c("sanae")
		D.v("！")
		D._("...")
		D.v("えーと ...")
		D._("ここは ...")
		D.x("どこかしら ... ？")
	end,
	function ()
		Wa._(1.5)
	end,
	function ()
		D.c("sanae")
		D._("うーん ...")
		D.v("ここが どこかは ")
		D._("...")
		D._("わからない")
		D.v("だけど")
		D._("...")
		D.v("わたし")
		D.v("きめた！")
		D._("ここで")
		D.v("くらしていくわ")
		D._("...")
		D.v("だって ...")
		D._("ここは とても")
		D.v("へいわ そうな ところだし")
		D._("ここが どこかなんて")
		D.v("きにしないわ")
		D._("そんなこと")
		D._("ちっとも")
		D.x("きにしないわ！")
	end,
	function ()
		Wa._(1.5)
	end,
	function ()
		D.c("sanae")
		D.v("うーん ...")
		D._("わたしと いっしょに")
		D._("いろんな ものが")
		D.v("おちてきた")
		D._("...")
		D.v("とても ... ふしぎなことね")
		D._("...")
		D.v("だけど")
		D.v("そんなこと きにしないわ")
		D._("わたし")
		D._("かつよう できる ものは")
		D.v("なんだって かつよう して")
		D.x("ここで くらしていくの")
	end,
	--]]
}

