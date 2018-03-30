" Show print margin for cpp sources, but don't autowrap
set tw=100
set cc=+1

hi ColorColumn ctermbg=darkgrey guibg=darkgrey

" Highlight overlength charcaters in cpp
hi OverLength ctermbg=darkgrey guibg=#FAAC58
match OverLength /\%101v.*/
