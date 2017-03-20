" Vim color file
" Maintainer:   Mikel Ward <mikel@mikelward.com>
" Last Change:  2008 Jan 16

" Remove all existing highlighting and set the defaults.
highlight clear

" Load the syntax highlighting defaults, if it's enabled.
"if exists("syntax_on")
"   syntax reset
"endif

let colors_name = "basicLight"

" Remove all highlighting
highlight clear Constant
highlight clear Number
highlight clear Statement
highlight clear PreProc
highlight clear Type
highlight clear Special
highlight clear Identifier
highlight clear Title
highlight clear String
highlight clear Comment
highlight clear Error
highlight clear LineNr
highlight clear NonText
highlight clear SpecialKey

" Set up some simple non-intrusive colors_name
hi Normal ctermfg=234 ctermbg=252 guifg= #1c1c1c guibg= #d0d0d0
hi VertSplit guifg=#808080 guibg=#d0d0d0 gui=bold ctermfg=244 ctermbg=232   cterm=bold
hi String term=underline cterm=underline ctermfg=240 guifg=#585858 gui=underline
hi Comment term=bold cterm=NONE ctermfg=241 guifg=#626262
hi Error term=reverse cterm=NONE ctermbg=Red guifg=Red
hi LineNr term=bold cterm=NONE ctermfg=245 guifg=black
hi NonText term=bold cterm=NONE ctermfg=246 guifg=#949494
hi SpecialKey term=bold cterm=NONE ctermfg=246 guifg=#949494
hi Search ctermbg=255 ctermfg=16 guibg=#eeeeee guifg= #000000
hi CursorLine ctermbg=254   cterm=none guibg=#e4e4e4
hi FoldColumn guifg=#465457 guibg=#d0d0d0
hi Folded guifg=#465457 guibg=#d0d0d0
hi VisualNOS ctermbg=252 guibg=#403D3D
hi Visual ctermbg=231 guibg=#ffffff
hi WildMenu guifg=#66D9EF guibg=#000000 ctermfg=81  ctermbg=16
hi Pmenu ctermfg=81  ctermbg=16 guifg=#000000 guibg=#ffffff
hi PmenuSel ctermbg=254 guibg=#e4e4e4 cterm=bold gui=bold
hi PmenuSbar ctermbg=23 guibg=#333333
hi def IndentGuides guibg=#a8a8a8 ctermbg=245
hi Statement gui=bold term=bold cterm= bold
hi MatchParen ctermbg=234 ctermfg=252 guibg= #1c1c1c guifg= #d0d0d0
hi Cursor guifg=#ffffff guibg=#444444
hi ColorColumn ctermbg=250 guibg=#bcbcbc
