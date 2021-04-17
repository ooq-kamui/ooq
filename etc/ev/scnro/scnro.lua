log.scrpt("scnro.lua")

Scnro = {}

Scnro.tst = {
	function ()
		Tst.obj.tst()
		D.c("sanae")
		---[[
		D.v("わーい")
		D._("こんかいは")
		D.v("いろいろ つくりました")
		D._("いろいろ ありすぎるので")
		D._("くわしくは どうがの がいようらんを")
		D.x("よんでください ></")
		--]]
	end,
}

Scnro.chara_fall = {
	function ()
		Tst.obj.chara()
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
		Tst.obj.fire()
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
		Tst.obj.tree()
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
		Tst.obj.game_start()
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

