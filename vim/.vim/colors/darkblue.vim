hi      clear
syntax  reset
set     background=dark
let     colors_name ="darkblue"
hi      Normal           ctermfg=253     ctermbg=none
hi      Type             cterm=none     ctermfg=34
hi      VertSplit        ctermfg=63    ctermbg=none    cterm=bold
hi      String           cterm=NONE     ctermfg=69
hi      Comment          cterm=NONE     ctermfg=246
hi      Error            cterm=bold     ctermfg=202    ctermbg=234
hi      LineNr           cterm=NONE     ctermfg=245
hi      CursorLineNr     cterm=NONE     ctermfg=245
hi      NonText          cterm=NONE     ctermfg=238
hi      SpecialKey       cterm=NONE     ctermfg=238
hi      Boolean          ctermfg=135
hi      Search           ctermbg=27      ctermfg=255
hi      CursorLine       ctermbg=57      ctermfg=none  cterm=none
hi      FoldColumn       ctermbg=none    ctermfg=247
hi      Folded           ctermbg=none    ctermfg=247
hi      VisualNOS        ctermbg=238
hi      Visual           ctermbg=240
hi      WildMenu         ctermfg=81     ctermbg=16
hi      Pmenu            ctermfg=81      ctermbg=16
hi      PmenuSel         ctermbg=24      ctermfg=231
hi      PmenuSbar        ctermbg=23
hi      Statement        cterm=bold     ctermfg=34
hi      Function         cterm=none     ctermfg=202
hi      Operator         ctermfg=231
hi      Identifier       cterm=none     ctermfg=34
hi      Keyword          cterm=bold     ctermfg=39
hi      MatchParen       ctermbg=22     ctermfg=253
hi      Cursor           ctermfg=231    ctermbg=238
hi      ColorColumn      cterm=none     ctermbg=25    ctermfg=123
hi      Character        ctermfg=144
hi      Number           ctermfg=135
hi      Conditional      ctermfg=161
hi      Constant         ctermfg=135
hi      Directory        ctermfg=34
hi      TabLine          ctermfg=240     ctermbg=232
hi      TabLineSel       ctermfg=253     ctermbg=234
hi      Todo             ctermfg=253     ctermbg=234
hi      TabLineFill      ctermfg=232     ctermbg=255
hi      def              Indent          ctermbg=237
hi      StatusLine       ctermfg=26      ctermbg=16
hi      StatusLineNC     ctermfg=26      ctermbg=233
if      has("spell")
hi      SpellBad         ctermbg=52      ctermfg=231
hi      SpellCap         ctermfg=253     ctermbg=23
hi      SpellLocal       ctermbg=25
hi      SpellRare        ctermbg=130
endif
hi      DiffAdd          ctermfg=70      ctermbg=234
hi      DiffChange       ctermbg=234     ctermfg=130
hi      DiffDelete       ctermbg=16      ctermfg=52
hi      DiffText         ctermfg=33      ctermbg=234    cterm=bold
