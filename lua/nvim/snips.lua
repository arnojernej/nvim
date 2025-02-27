local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets("typescript", {
  s("/*", {
    t({
      "/*",
      "|------------------------------------------------------------------------------",
      "| ",
    }),
    i(1, "Description"),
    t({
      "",
      "|------------------------------------------------------------------------------",
      "*/",
    }),
  }),
})

ls.add_snippets("typescriptreact", {
  s("/*", {
    t({
      "/*",
      "|------------------------------------------------------------------------------",
      "| ",
    }),
    i(1, "Description"),
    t({
      "",
      "|------------------------------------------------------------------------------",
      "*/",
    }),
  }),
})
