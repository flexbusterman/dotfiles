local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local snippets = {
	s(
		{ trig = "media", name = "css media query" },
		{ t("/* tablet */\z@media (min-width: 768px) {\z}\z/* desktop */\z@media (min-width: 1024px) {\z}") }
	),
}
return snippets
