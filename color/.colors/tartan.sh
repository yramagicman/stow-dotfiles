#!/bin/sh
if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P02e3436
  \e]P1cc0000
  \e]P24e9a06
  \e]P3c4a000
  \e]P43465a4
  \e]P575507b
  \e]P606989a
  \e]P7d3d7cf
  \e]P8555753
  \e]P9ef2929
  \e]PA8ae234
  \e]PBfce94f
  \e]PC729fcf
  \e]PDad7fa8
  \e]PE34e2e2
  \e]PFeeeeec
  "
  # get rid of artifacts
  clear
fi
