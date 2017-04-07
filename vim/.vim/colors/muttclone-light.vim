hi      clear
syntax  reset
set     background=light
let     colors_name      =               "muttclone-light"
hi      Normal           ctermbg=255     ctermfg=234    guifg=#dadada  guibg=#e4e4e4
hi      Type             gui=bold        term=bold      cterm=none     ctermfg=23     guifg=#00af00
hi      VertSplit        guifg=#808080   guibg=#080808  gui=bold       ctermbg=250    ctermfg=247    cterm=bold
hi      String           term=underline  cterm=NONE     ctermfg=25     guifg=#5f87ff  gui=underline
hi      Comment          term=bold       cterm=NONE     ctermfg=241    guifg=#949494
hi      Error            term=reverse    cterm=bold     ctermfg=202    ctermbg=234    guifg=#ff5f00
hi      LineNr           term=bold       cterm=NONE     ctermfg=245    guifg=#8a8a8a
hi      CursorLineNr     term=bold       cterm=NONE     ctermfg=245    guifg=#8a8a8a
hi      NonText          term=bold       cterm=NONE     ctermfg=235    guifg=#444444
hi      SpecialKey       term=bold       cterm=NONE     ctermfg=235    guifg=#444444
hi      Boolean          ctermfg=129     guifg=#af5fff
hi      Search           ctermbg=247     ctermfg=232    guibg=#303030  guifg=#ffffff
hi      CursorLine       ctermbg=250     cterm=none     guibg=#262626
hi      FoldColumn       ctermbg=253     ctermfg=253    guifg=#1c1c1c  guibg=#1c1c1c
hi      Folded           ctermbg=253     ctermfg=238    guifg=#9e9e9e  guibg=#1c1c1c
hi      VisualNOS        ctermbg=238     guibg=#444444
hi      Visual           ctermbg=240     guibg=#585858
hi      WildMenu         guifg=#5fd7ff   guibg=#000000  ctermfg=241     ctermbg=253
hi      Pmenu            ctermfg=81      ctermbg=16     guifg=#66D9EF  guibg=#000000
hi      PmenuSel         ctermbg=24      guibg=#005f87
hi      PmenuSbar        ctermbg=23      guibg=#005f5f
hi      Statement        gui=bold        term=bold      cterm=bold     ctermfg=22     guifg=#00af00
hi      Function         gui=none       term=bold      cterm=none     ctermfg=166    guifg=#ff5f00
hi      Operator         ctermfg=232     guifg=#ffffff
hi      Identifier       gui=none        term=bold      cterm=none     ctermfg=22     guifg=#00af00
hi      Keyword          gui=bold        term=bold      cterm=bold     ctermfg=22     guifg=#00afff
hi      MatchParen       term=bold       ctermbg=22     ctermfg=253    guibg=#005f00  guifg=#dadada  gui=bold
hi      Cursor           guifg=#ffffff   guibg=#444444  ctermfg=231    ctermbg=238
hi      Character        ctermfg=132     guifg=#afaf87
hi      Number           ctermfg=129     guifg=#af5fff
hi      Conditional      ctermfg=161     guifg=#d7005f
hi      Constant         ctermfg=129     guifg=#af5fff
hi      Directory        ctermfg=22      guifg=#00af00
hi      TabLine          ctermbg=252     ctermfg=232    guibg=#080808  guifg=#585858
hi      TabLineSel       ctermfg=232     ctermbg=247    guibg=#1c1c1c  guifg=#dadada
hi      TabLineFill      ctermfg=252     ctermbg=232    guibg=#1c1c1c  guifg=#080808
hi      def              IndentGuides    guibg=#303030  ctermbg=250
hi      StatusLine       ctermfg=246     ctermbg=232    guifg=#080808  guibg=#949494
hi      StatusLineNC     ctermfg=252     ctermbg=240    guifg=#080808  guibg=#949494
hi      ColorColumn      ctermbg=250     guibg=#121212
if      has("spell")
hi      SpellBad         guibg=#5f0000   guifg=#ffffff  ctermbg=52     ctermfg=231
hi      SpellCap         guibg=#7070F0   gui=undercurl  ctermfg=253    ctermbg=23
hi      SpellLocal       guibg=#70F0F0   gui=undercurl
hi      SpellRare        guibg=#FFFFFF   gui=undercurl
endif
hi      DiffAdd          ctermfg=70      ctermbg=234    guifg=#5faf00  guibg=#1c1c1c
hi      DiffChange       ctermbg=234     ctermfg=130    guifg=#af5f00  guibg=#1c1c1c
hi      DiffDelete       ctermbg=16      ctermfg=52     guifg=#5f0000  guibg=#000000
hi      DiffText         ctermfg=33      ctermbg=234    cterm=bold     guifg=#005fff guibg=#000000  gui=bold
