local ls = require'luasnip'
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local snippets = {
s( { trig = "cl", name = "console.log()" }, { t("console.log("), i(1), t(")"), }),
s( { trig = "im", name = "CSS important" }, { t("!important"), }),
s( { trig = "hc", name = "HTML comment" }, { t("<!-- "), i(1), t(" -->"), }),
s( { trig = "test", name = "Test SuperCollider audio" }, { t("{SinOsc.ar(freq: 440.0,  phase: 0.0,  mul: 0.2,  add: 0.0)!2}.play;"), })
}
return snippets
