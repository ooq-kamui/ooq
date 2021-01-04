log.script("serifu.lua")

Serifu = {
	_ = {
		{len =  3, txt = "ここに"},
		{len =  2, txt = "ここ"},
		{len =  3, txt = "いたか"},

		{len =  2, txt = "うそ"},

		{len =  4, txt = "わすれた"},
		{len =  5, txt = "わすれない"},
		
		{len =  8, txt = "はずかしいですぅ"},
		
		{len =  3, txt = "まいご"},
		{len =  4, txt = "さまよう"},
		{len =  4, txt = "まよった"},

		{len =  4, txt = "やっぱり"},
		{len =  3, txt = "まって"},

		{len =  6, txt = "いんびじぶる"},
		{len =  4, txt = "みえない"},

		{len =  6, txt = "あたしだって"},
		{len =  3, txt = "もっと"},
		{len =  7, txt = "もっと もっと"},

		{len =  4, txt = "よくきた"},

		{len =  5, txt = "かんぺきね"},

		{len =  6, txt = "がんばろうね"},
		{len =  6, txt = "どんなときも"},

		{len =  6, txt = "いいのかしら"},
		{len =  5, txt = "おめでとう"},
		
		{len =  4, txt = "すっごい"},

		{len =  6, txt = "かたじけない"},
		
		{len =  6, txt = "ひとりぼっち"},
		{len =  4, txt = "ようやく"},
		{len =  5, txt = "しましょう"},
		{len =  3, txt = "へんだ"},
		{len =  5, txt = "たいへんだ"},
		{len =  2, txt = "ある"},
		{len =  4, txt = "いつから"},
		{len =  4, txt = "おもいで"},

		{len =  7, txt = "どうでもいいわ"},
		{len =  3, txt = "かえる"},
		{len =  6, txt = "もう かえる"},
		{len =  5, txt = "とうぜんよ"},

		{len =  3, txt = "みんな"},
		{len =  5, txt = "いつのまに"},
		
		{len =  4, txt = "かわいい"},
		
		{len =  5, txt = "もうすこし"},
		{len =  4, txt = "たいせつ"},
		{len =  4, txt = "よいしょ"},

		{len =  3, txt = "いつも"},
		{len =  5, txt = "いつまでも"},
		{len =  4, txt = "まいにち"},

		{len =  4, txt = "でんせつ"},
		{len =  5, txt = "れじぇんど"},
		{len =  3, txt = "せかい"},

		{len =  3, txt = "きほん"},

		{len =  4, txt = "みないで"},
		{len =  4, txt = "たやすい"},

		{len =  3, txt = "やっと"},

		{len =  3, txt = "のぼる"},
		{len =  3, txt = "つかう"},

		{len =  3, txt = "わるい"},

		{len =  4, txt = "いかにも"},

		{len =  8, txt = "じゅんび できた"},
		{len =  7, txt = "じゅんび する"},

		-- guess
		{len =  3, txt = "かもね"},
		-- console
		{len = 10, txt = "そんなときも あるよ"},
		
		-- amount many
		{len =  4, txt = "いっぱい"},
		-- time
		{len =  2, txt = "とき"},
		{len =  6, txt = "ときが きた"},
		-- thanks
		{len =  5, txt = "ありがとう"},

		-- name
		{len =  4, txt = "ねえさま"},
		{len =  7, txt = "しらない ひと"},
		-- personal pronoun
		{len =  5, txt = "あたしたち"},
		{len =  3, txt = "わたし"},
		-- interjection
		{len =  4, txt = "ああん！"},
		{len =  3, txt = "いやん"},
		{len =  3, txt = "はうっ"},
		{len =  3, txt = "ふうぅ"},
		{len =  3, txt = "え！？"},
		{len =  2, txt = "えっ"},
		{len =  3, txt = "もう〜"},
		{len =  2, txt = "もう"},
		{len =  3, txt = "えい！"},
		{len =  4, txt = "でやぁ！"},
		{len =  3, txt = "えっと"},
		{len =  3, txt = "あのぉ"},
		{len =  2, txt = "ねえ"},
		{len =  5, txt = "ねえ ねえ"},
		{len =  6, txt = "ねえ ってば"},
		{len =  3, txt = "あら？"},
		{len =  3, txt = "うふふ"},
		{len =  2, txt = "くぅ"},
		{len =  2, txt = "む？"},
		{len =  2, txt = "わあ"},
		{len =  2, txt = "わぁ"},
		{len =  4, txt = "きゃっ！"},
		{len =  2, txt = "あら"},
		{len =  4, txt = "うわーっ"},
		{len =  3, txt = "..."},
		
		-- demonstrative pronoun
		{len =  2, txt = "その"},
		{len =  6, txt = "これは..."},
		{len =  2, txt = "それ"},
		{len =  3, txt = "こっち"},
		{len =  7, txt = "こっち こっち"},

		-- shop
		{len =  5, txt = "まいどあり"},
	
		-- food
		{len =  3, txt = "おでん"},
		{len =  5, txt = "ましゅまろ"},
		{len =  4, txt = "のみたい"},
		{len =  4, txt = "たべたい"},
		
		--
		-- emotion
		--
		-- joyful
		{len =  4, txt = "よろこび"},
		{len =  4, txt = "たのしい"},
		{len =  3, txt = "わーい"},
		{len =  2, txt = "わー"},
		{len =  3, txt = "えへへ"},
		{len =  3, txt = "げんき"},
		{len =  4, txt = "うれしい"},
		{len =  3, txt = "あはは"},
		-- calm
		{len =  4, txt = "よかった"},
		-- surprise
		{len =  6, txt = "びっくりした"},
		-- pretty low
		{len =  3, txt = "なんだ"},
		{len =  4, txt = "そんなぁ"},
		
		-- sleep
		{len =  3, txt = "ねてた"},
		{len =  8, txt = "ゆめを みていた"},
		{len =  2, txt = "ゆめ"},
		{len =  7, txt = "むにゃ むにゃ"},
		{len =  3, txt = "ねむい"},
		{len =  5, txt = "りらっくす"},
		-- like
		{len =  4, txt = "なかよし"},
		-- love
		{len = 11, txt = "ずーっと いっしょだよ"},
		{len =  4, txt = "だいすき"},
		-- hate
		{len =  3, txt = "じゃま"},
		{len =  7, txt = "じゃましないで"},
		{len =  8, txt = "のろいを かけた"},
		{len =  8, txt = "のろいを かける"},
		{len =  2, txt = "ばか"},
		{len =  3, txt = "きらい"},
		{len =  4, txt = "しつこい"},
		-- fin
		{len =  4, txt = "やめない"},
		{len =  5, txt = "やめないよ"},
		{len =  3, txt = "やめた"},
		{len =  6, txt = "もう やめた"},
		{len =  6, txt = "もう おわり"},
		-- fight
		{len =  7, txt = "あたし やるわ"},
		{len =  5, txt = "まけないよ"},
		{len =  2, txt = "やる"},
		{len =  3, txt = "やるわ"},
		{len =  6, txt = "やりましょう"},
		{len =  2, txt = "いざ"},
		{len =  6, txt = "やっちゃうよ"},
		{len = 10, txt = "おしおき しちゃうよ"},
		-- fight win
		{len =  3, txt = "かった"},
		{len =  6, txt = "どっこいしょ"},
		{len =  8, txt = "わたしが まもる"},
		{len =  4, txt = "たすける"},
		{len =  3, txt = "つるぎ"},
		{len =  5, txt = "かくごしろ"},
		{len =  4, txt = "わざあり"},
		-- fight lose
		{len =  4, txt = "たすけて"},
		{len =  5, txt = "たすかった"},
		{len =  8, txt = "すきなようにして"},
		{len =  5, txt = "これまでか"},
		{len =  2, txt = "まけ"},
		-- yes
		{len =  3, txt = "いいよ"},
		{len =  4, txt = "そうだよ"},
		-- no
		{len =  2, txt = "だめ"},
		{len =  2, txt = "いや"},
		{len =  2, txt = "やだ"},
		{len =  3, txt = "いいえ"},
		{len =  4, txt = "ちがうよ"},
		-- weather
		{len =  4, txt = "すずしい"},
		{len =  2, txt = "あめ"},
		{len =  3, txt = "やんだ"},
		{len =  3, txt = "あつい"},
		{len =  3, txt = "さむい"},
		-- color
		{len =  4, txt = "とうめい"},

		-- can
		{len =  5, txt = "もういちど"},
		{len =  3, txt = "できた"},
		{len =  6, txt = "できなかった"},

		-- explain
		{len =  4, txt = "せつめい"},
		{len =  8, txt = "せつめい するね"},
		{len =  7, txt = "せつめい して"},
		{len =  8, txt = "せつめい してね"},

		-- know
		{len =  3, txt = "わかる"},
		{len =  4, txt = "わかった"},
		{len =  6, txt = "わかりました"},
		{len =  6, txt = "わかったかも"},
		
		{len =  5, txt = "わからない"},
		{len =  6, txt = "わからないわ"},
		{len =  6, txt = "わかりません"},
		{len =  4, txt = "わからん"},
		{len =  4, txt = "わからん"},
		
		{len =  4, txt = "きがする"},
		{len =  8, txt = "そんなはず ない"},

		-- question
		{len =  5, txt = "どうだろう"},
		{len =  4, txt = "しらない"},
		{len =  5, txt = "しらないよ"},
		{len =  7, txt = "もう しらない"},
		{len =  5, txt = "もしかして"},
		{len =  6, txt = "もしかすると"},
		{len =  6, txt = "もしかしたら"},
		{len =  3, txt = "もしも"},
		{len =  3, txt = "なんで"},
		{len =  5, txt = "どうしよう"},
		{len =  8, txt = "どうしようもない"},
		{len =  3, txt = "ふしぎ"},
		{len =  4, txt = "おかしい"},
		{len =  4, txt = "もしや？"},
		{len =  4, txt = "なんだ？"},
		{len =  3, txt = "なに？"},
		{len =  4, txt = "そうかな"},
		{len =  4, txt = "なにゆえ"},
		{len =  4, txt = "どうして"},
		{len =  4, txt = "なるほど"},
		-- story
		{len =  4, txt = "おはなし"},

		-- day
		{len =  3, txt = "あした"},
		{len =  3, txt = "きのう"},

		-- greeting 
		{len =  6, txt = "はじめまして"},
		-- greeting 
		{len =  6, txt = "また あした"},
		{len =  4, txt = "じゃあね"},

		-- past
		{len =  5, txt = "すぎたこと"},
		{len =  5, txt = "すぎさった"},

		-- play
		{len =  4, txt = "あそぼう"},
		
		-- think
		{len =  6, txt = "かんがえてた"},


		-- plant, flower
		{len =  2, txt = "はな"},

		-- animal
		{len =  3, txt = "さかな"},


		-- cloth
		{len =  3, txt = "よろい"},
		{len =  2, txt = "ふく"},
		-- modesty
		{len =  3, txt = "どうぞ"},
		-- space
		{len =  3, txt = "せまい"},
		{len =  3, txt = "ひろい"},
	},
	tail = {
		-- 01 -10
		{len =  1, txt = "わ"},
		{len =  1, txt = "の"},
		{len =  1, txt = "よ"},
		{len =  1, txt = "ね"},
		{len =  2, txt = "なの"},
		{len =  1, txt = "?"},
		{len =  3, txt = "かしら"},
		{len =  2, txt = "です"},
		{len =  2, txt = "かも"},
		{len =  2, txt = "かな"},
		-- 11 - 20
		{len =  1, txt = "だ"},
		{len =  1, txt = "な"},
	},
}

-- Fuki.serifu = Serifu._

