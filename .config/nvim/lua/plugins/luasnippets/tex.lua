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
\section{<>}
\begin{enumerate}[label=(\alph*)]
	\item
	      \begin{equation}
		      $$
			      <>
		      $$
	      \end{equation}
\end{enumerate}
  ]],
			{
				i(1, "1"),
				i(2, "1+1=2"),
			},
			{
				delimiters = "<>",
			}
		)
	),
}
return snippets
