" Vim color file
" Last Change:  2008 Jan 16

" Remove all existing highlighting and set the defaults.
highlight clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
   syntax reset
endif

let colors_name = "basicDark"

" Remove all highlighting
hi clear Constant
hi clear Number
hi clear Statement
hi clear PreProc
hi clear Type
hi clear Special
hi clear Identifier
hi clear Title
hi clear String
hi clear Comment
hi clear Error
hi clear LineNr
hi clear NonText
hi clear SpecialKey
hi clear Directory

" Set up some simple non-intrusive colors_name
hi Normal ctermfg=15 ctermbg=NONE
hi VertSplit ctermfg=244 ctermbg=NONE   cterm=bold
hi String term=underline cterm=NONE ctermfg=247
hi Comment term=bold cterm=NONE ctermfg=241 guifg=#626262
hi Error term=reverse cterm=NONE ctermbg=Red guifg=Red
hi LineNr term=bold cterm=NONE ctermfg=7
hi NonText term=bold cterm=NONE ctermfg=238
hi SpecialKey term=bold cterm=NONE ctermfg=238
hi Search ctermbg=236 ctermfg=231
hi CursorLine cterm=UNDERLINE
hi FoldColumn ctermbg=NONE ctermfg=247 guifg=#465457 guibg=#000000
hi Folded ctermbg=232 ctermfg=247 guifg=#465457 guibg=#000000
hi VisualNOS ctermbg=238 guibg=#403D3D
hi Visual ctermbg=240 guibg=#403D3D
hi WildMenu ctermfg=15  ctermbg=0
hi Pmenu ctermfg=81  ctermbg=16
hi PmenuSel ctermbg=24 guibg=#333333
hi PmenuSbar ctermbg=23 guibg=#333333
hi def IndentGuides guibg=#303030 ctermbg=237
hi Statement gui=bold term= bold cterm=bold
hi MatchParen term=bold ctermbg=253 ctermfg=233 guibg= #dadada guifg= #121212 gui=bold
hi Cursor guifg=#ffffff guibg=#444444 ctermfg=231 ctermbg=238
hi ColorColumn ctermbg=232 guibg=#080808
