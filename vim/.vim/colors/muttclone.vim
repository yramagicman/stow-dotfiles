hi      clear
syntax  reset
set     background=dark
let     colors_name      =               "muttclone"
hi      Normal           ctermfg=253     ctermbg=234    guifg=#dadada  guibg=#1c1c1c
hi      Type             gui=bold        term=bold      cterm=none     ctermfg=34     guifg=#00af00
hi      VertSplit        guifg=#808080   guibg=#080808  gui=bold       ctermfg=244    ctermbg=232    cterm=bold
hi      String           term=NONE  cterm=NONE     ctermfg=69     guifg=#5f87ff  gui=NONE
hi      Comment          term=bold       cterm=NONE     ctermfg=246    guifg=#949494
hi      Error            term=reverse    cterm=bold     ctermfg=202    ctermbg=234    guifg=#ff5f00
hi      LineNr           term=bold       cterm=NONE     ctermfg=245    guifg=#8a8a8a
hi      CursorLineNr     term=bold       cterm=NONE     ctermfg=245    guifg=#8a8a8a
hi      NonText          term=bold       cterm=NONE     ctermfg=238    guifg=#444444
hi      SpecialKey       term=bold       cterm=NONE     ctermfg=238    guifg=#444444
hi      Boolean          ctermfg=135     guifg=#af5fff
hi      Search           ctermbg=233     ctermfg=250    guibg=#000000  guifg=#ffffff
hi      CursorLine       ctermbg=236     cterm=none     guibg=#262626
hi      FoldColumn       ctermbg=234     ctermfg=247    guifg=#1c1c1c  guibg=#1c1c1c
hi      Folded           ctermbg=234     ctermfg=247    guifg=#9e9e9e  guibg=#1c1c1c
hi      VisualNOS        ctermbg=238     guibg=#444444
hi      Visual           ctermbg=240     guibg=#585858
hi      WildMenu         guifg=#5fd7ff   guibg=#000000  ctermfg=81     ctermbg=16
hi      Pmenu            ctermfg=81      ctermbg=16     guifg=#66D9EF  guibg=#000000
hi      PmenuSel         ctermbg=24      ctermfg=231    guibg=#005f87
hi      PmenuSbar        ctermbg=23      guibg=#005f5f
hi      Statement        gui=bold        term=bold      cterm=bold     ctermfg=34     guifg=#00af00
hi      Function         gui=none        term=bold      cterm=none     ctermfg=202    guifg=#ff5f00
hi      Operator         ctermfg=231     guifg=#ffffff
hi      Identifier       gui=none        term=bold      cterm=none     ctermfg=34     guifg=#00af00
hi      Keyword          gui=bold        term=bold      cterm=bold     ctermfg=39     guifg=#00afff
hi      MatchParen       term=bold       ctermbg=22     ctermfg=253    guibg=#005f00  guifg=#dadada  gui=bold
hi      Cursor           guifg=#ffffff   guibg=#444444  ctermfg=231    ctermbg=238
hi      ColorColumn      ctermbg=232     guibg=#080808
hi      Character        ctermfg=144     guifg=#afaf87
hi      Number           ctermfg=135     guifg=#af5fff
hi      Conditional      ctermfg=161     guifg=#d7005f
hi      Constant         ctermfg=135     guifg=#af5fff
hi      Directory        ctermfg=34      guifg=#00af00
hi      TabLine          ctermfg=240     ctermbg=232    guibg=#080808  guifg=#585858
hi      TabLineSel       ctermfg=253     ctermbg=234    guibg=#1c1c1c  guifg=#dadada
hi      Todo       ctermfg=253     ctermbg=234    guibg=#1c1c1c  guifg=#dadada
hi      TabLineFill      ctermfg=232     ctermbg=255    guibg=#1c1c1c  guifg=#080808
hi      def              IndentGuides    guibg=#303030  ctermbg=237
hi      StatusLine       ctermfg=233     ctermbg=246    guifg=#080808  guibg=#949494
hi      StatusLineNC     ctermfg=235     ctermbg=246    guifg=#080808  guibg=#949494
hi      ColorColumn      ctermbg=233     guibg=#121212
if      has("spell")
hi      SpellBad         guibg=#5f0000   guifg=#ffffff  ctermbg=52     ctermfg=231
hi      SpellCap         guibg=#7070F0   gui=undercurl  ctermfg=253    ctermbg=23
hi      SpellLocal       guibg=#70F0F0   gui=undercurl  ctermbg=25
hi      SpellRare        guibg=#FFFFFF   gui=undercurl  ctermbg=130
endif
hi      DiffAdd          ctermfg=70      ctermbg=234    guifg=#5faf00  guibg=#1c1c1c
hi      DiffChange       ctermbg=234     ctermfg=130    guifg=#af5f00  guibg=#1c1c1c
hi      DiffDelete       ctermbg=16      ctermfg=52     guifg=#5f0000  guibg=#000000
hi      DiffText         ctermfg=33      ctermbg=234    cterm=bold     guifg=#005fff guibg=#000000  gui=bold
