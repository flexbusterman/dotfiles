local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local snippets = {
	s(
		"section",
		fmt(
			[[
\section*{<>}
\begin{enumerate}[label=(\alph*)]
	\item
		\begin{align*}
			<> \\
		\end{align*}
\end{enumerate}
  ]],
			{
				i(1, ""),
				i(2, "1+1=2"),
			},
			{
				delimiters = "<>",
			}
		)
	),

	s(
		"item",
		fmt(
			[[
	\item
		\begin{align*}
			<> \\
		\end{align*}
  ]],
			{
				i(1, ""),
			},
			{
				delimiters = "<>",
			}
		)
	),

	s({ trig = "pq", name = "PQ-formeln" }, { t("x &= -\\frac{p}{2} \\pm \\sqrt{\\left(\\frac{p}{2}\\right)^2 - q}") }),
}
return snippets
