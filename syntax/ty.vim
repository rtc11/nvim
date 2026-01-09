" ========================
" Keywords and Types
syntax keyword tyKeyword let fn return if else macro
syntax keyword tyBoolean true false
syntax keyword tyType i32 str struct

" ========================
" Comments
syntax match tyComment "//.*"

" ========================
" Literals
syntax region tyString start=+"+ skip=+\\\\\|\\"+ end=+"+
syntax match tyNumber "\<\d\+\>"

" ========================
" Operators and Symbols
syntax match tyOperator "==\|!=\|[-+*/<>!=]=\?" contained
syntax match tyAssign "=" contained

syntax match tyBrace "[{}]" contained
syntax match tyParen "[()]" contained
syntax match tyBracket "[\[\]]" contained
syntax match tySemicolon ";" contained
syntax match tyColon ":" contained
syntax match tyComma "," contained
syntax match tyDot "\." contained
syntax match tyQuote "'" contained

" ========================
" Function calls (like foo(...))
syntax match tyFunctionCall "\<[a-zA-Z_][a-zA-Z0-9_]*\>\ze\s*(" contained
syntax match tyFunctionCall "\<[a-zA-Z_][a-zA-Z0-9_]*\>\s*("
" syntax match tyFunctionCall "\<[a-zA-Z_][a-zA-Z0-9_]*\>\s*(" contained

" ========================
" Top-Level wrapper (must include everything else!)
syntax region tyTopLevel start=+\%^+ end=+\%$+ contains=tyKeyword,tyBoolean,tyType,tyComment,tyString,tyNumber,tyOperator,tyAssign,tyBrace,tyParen,tyBracket,tySemicolon,tyColon,tyComma,tyDot,tyQuote,tyFunctionCall

" ========================
" Highlight links
highlight link tyKeyword Keyword
highlight link tyBoolean Boolean
highlight link tyType Type

highlight link tyComment Comment
highlight link tyString String
highlight link tyNumber Number

highlight link tyOperator Operator
highlight link tyAssign Operator

highlight link tyBrace Delimiter
highlight link tyParen Delimiter
highlight link tyBracket Delimiter
highlight link tySemicolon Delimiter
highlight link tyColon Delimiter
highlight link tyComma Delimiter
highlight link tyDot Delimiter
highlight link tyQuote Delimiter

highlight link tyFunctionCall Function

