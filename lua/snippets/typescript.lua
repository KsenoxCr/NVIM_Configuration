local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.filetype_extend('typescriptreact', { 'typescript', 'javascript' })
ls.filetype_extend('javascriptreact', { 'javascript' })

ls.add_snippets('typescript', {
  -- Trigger: 'cl' -> Expands to: console.log(...)
  s('cl', {
    t 'console.log(',
    i(1), -- Cursor jumps here first
    t ');',
  }),

  -- Trigger: 'af' -> Arrow Function
  s('af', {
    t 'const ',
    i(1, 'name'),
    t ' = (',
    i(2, 'args'),
    t ') => {',
    t { '', '\t' },
    i(0), -- i(0) is the final cursor position
    t { '', '};' },
  }),
})
