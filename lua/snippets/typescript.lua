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

  -- Trigger: 'lm' -> Expands to: () => {}  (lambda)
  s('lm', {
    t '() => {',
    i(1),
    t '}',
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

  -- Trigger: 'for' -> For loop with let i
  s({
    trig = 'for',
    priority = 2000, -- Higher priority than default snippets
  }, {
    t 'for (let i = 0; i < ',
    i(1, 'length'),
    t '; i++) {',
    t { '', '\t' },
    i(0),
    t { '', '}' },
  }),
  -- Trigger: 'for2' -> For loop with let j
  s({
    trig = 'for2',
    priority = 2000, -- Higher priority than default snippets
  }, {
    t 'for (let j = 0; j < ',
    i(1, 'length'),
    t '; j++) {',
    t { '', '\t' },
    i(0),
    t { '', '}' },
  }),
})
