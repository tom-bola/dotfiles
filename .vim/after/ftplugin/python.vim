" Show print margin, but don't autowrap
set tw=120
set cc=+1

hi ColorColumn ctermbg=darkgrey guibg=darkgrey

" Highlight overlength charcaters in cpp
hi OverLength ctermbg=darkgrey guibg=#FAAC58
match OverLength /\%121v.*/
