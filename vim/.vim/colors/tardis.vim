" Vim color file
" Maintainer:   Bohdan Vlasyuk <bohdan@vstu.edu.ua>
" Last Change:  2008 Jul 18

" darkblue -- for those who prefer dark background
" [note: looks bit uglier with come terminal palettes,
" but is fine on default linux console palette.]

set bg=dark
if exists("syntax_on")
    syntax reset
endif
hi clear
let colors_name = "tardis"

hi Normal       guifg=#c6c6c6 guibg=#00005f                     ctermfg=251 ctermbg=17
hi ErrorMsg     guifg=#ffffff guibg=#287eff                     ctermfg=white ctermbg=16
hi Visual       guifg=#8080ff guibg=fg      gui=reverse         ctermfg=black ctermbg=fg cterm=reverse
hi VisualNOS    guifg=#8080ff guibg=fg      gui=reverse   ctermfg=lightblue ctermbg=fg
hi Todo         guifg=#d14a14 guibg=#1248d1                     ctermfg=red ctermbg=darkblue
hi Search       guifg=#90fff0 guibg=#2050d0                     ctermfg=white ctermbg=darkblue
hi IncSearch    guifg=#b0ffff guibg=#2050d0                         ctermfg=darkblue ctermbg=gray

hi SpecialKey       guifg=cyan          ctermfg=darkcyan
hi Directory        guifg=cyan          ctermfg=cyan
hi Title            guifg=magenta gui=none ctermfg=magenta cterm=bold
hi WarningMsg       guifg=red           ctermfg=red
hi WildMenu         guifg=yellow guibg=black ctermfg=yellow ctermbg=black cterm=none term=none
hi ModeMsg          guifg=#22cce2       ctermfg=lightblue
hi MoreMsg          ctermfg=darkgreen   ctermfg=darkgreen
hi Question         guifg=green gui=none ctermfg=green cterm=none
hi NonText          guifg=#0030ff       ctermfg=darkblue

hi StatusLine   guifg=blue guibg=darkgray gui=none      ctermfg=blue ctermbg=gray term=none cterm=none
hi StatusLineNC guifg=black guibg=darkgray gui=none     ctermfg=black ctermbg=gray term=none cterm=none
hi VertSplit    guifg=black guibg=darkgray gui=none     ctermfg=black ctermbg=gray term=none cterm=none

hi Folded   guifg=#808080 guibg=#000040         ctermfg=243 ctermbg=17 cterm=bold term=bold
hi FoldColumn   guifg=#808080 guibg=#000040         ctermfg=darkgrey ctermbg=17 cterm=bold term=bold
hi LineNr   guifg=#90f020  ctermbg=17          ctermfg=240 cterm=none

hi DiffAdd  guibg=darkblue  ctermbg=darkblue term=none cterm=none
hi DiffChange   guibg=darkmagenta ctermbg=magenta cterm=none
hi DiffDelete   ctermfg=blue ctermbg=cyan gui=bold guifg=Blue guibg=DarkCyan
hi DiffText cterm=bold ctermbg=red gui=bold guibg=Red

hi Cursor   guifg=black guibg=white ctermfg=black ctermbg=white
hi lCursor  guifg=black guibg=white ctermfg=black ctermbg=white
hi CursorLine guibg=#00005f ctermbg=18 ctermfg=none term=none cterm=none

hi Comment  guifg=#80a0ff ctermfg=darkred
hi Constant ctermfg=magenta guifg=#ffa0a0 cterm=none
hi Special  ctermfg=brown guifg=Orange cterm=none gui=none
hi Identifier   ctermfg=cyan guifg=#40ffff cterm=none
hi Statement    ctermfg=yellow cterm=none guifg=#ffff60 gui=none
hi PreProc  ctermfg=magenta guifg=#ff80ff gui=none cterm=none
hi type     ctermfg=green guifg=#60ff60 gui=none cterm=none
hi Underlined   cterm=underline term=underline
hi Ignore   guifg=bg ctermfg=bg

" suggested by tigmoid, 2008 Jul 18
hi Pmenu guifg=#c0c0c0 guibg=#404080
hi PmenuSel guifg=#c0c0c0 guibg=#2050d0
hi PmenuSbar guifg=blue guibg=darkgray
hi PmenuThumb guifg=#c0c016

hi ColorColumn ctermbg=18 guibg=#000087
