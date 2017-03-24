let g:airline#themes#code#palette = {}

function s:hl(fg, bg, ...)
    let op = a:0 > 0 ? a:1 : ''
    let fg = a:fg < 16 ? a:fg : 'NONE'
    let bg = a:bg < 16 ? a:bg : 'NONE'
    return [ g:colors[a:fg], g:colors[a:bg], fg, bg, op ]
endfunction


let s:D2 = s:hl(16, 8)
let s:D3 = s:hl(7, 0)
let s:MD = {
      \ 'airline_c': s:hl(15, 0)
      \ }


let s:N1 = s:hl(8, 7)
let g:airline#themes#code#palette.normal = airline#themes#generate_color_map(s:N1, s:D2, s:D3)
let g:airline#themes#code#palette.normal_modified = s:MD


let s:I1 = s:hl(8, 12)
let g:airline#themes#code#palette.insert = airline#themes#generate_color_map(s:I1, s:D2, s:D3)
let g:airline#themes#code#palette.insert_modified = s:MD
let g:airline#themes#code#palette.insert_paste = {
      \ 'airline_a': s:hl(16, 10)
      \ }


let s:R1 = s:hl(8, 9)
let g:airline#themes#code#palette.replace = airline#themes#generate_color_map(s:R1, s:D2, s:D3)
let g:airline#themes#code#palette.replace_modified = s:MD


let s:V1 = s:hl(8, 13)
let g:airline#themes#code#palette.visual = airline#themes#generate_color_map(s:V1, s:D2, s:D3)
let g:airline#themes#code#palette.visual_modified = s:MD


let s:IN1 = s:hl(16, 8)
let s:IN2 = s:hl(16, 0)
let g:airline#themes#code#palette.inactive = airline#themes#generate_color_map(s:IN1, s:IN2, s:D3)
let g:airline#themes#code#palette.inactive_modified = s:MD


let g:airline#themes#code#palette.accents = {
      \ 'red': s:hl(1, 17)
      \ }


" Warnings
let s:WI = s:hl(3, 8)
let g:airline#themes#code#palette.normal.airline_warning           = s:WI
let g:airline#themes#code#palette.normal_modified.airline_warning  = s:WI
let g:airline#themes#code#palette.insert.airline_warning           = s:WI
let g:airline#themes#code#palette.insert_modified.airline_warning  = s:WI
let g:airline#themes#code#palette.insert_paste.airline_warning     = s:WI
let g:airline#themes#code#palette.visual.airline_warning           = s:WI
let g:airline#themes#code#palette.visual_modified.airline_warning  = s:WI
let g:airline#themes#code#palette.replace.airline_warning          = s:WI
let g:airline#themes#code#palette.replace_modified.airline_warning = s:WI


" Errors
let s:ER = s:hl(8, 1)
let g:airline#themes#code#palette.normal.airline_error           = s:ER
let g:airline#themes#code#palette.normal_modified.airline_error  = s:ER
let g:airline#themes#code#palette.insert.airline_error           = s:ER
let g:airline#themes#code#palette.insert_modified.airline_error  = s:ER
let g:airline#themes#code#palette.insert_paste.airline_error     = s:ER
let g:airline#themes#code#palette.visual.airline_error           = s:ER
let g:airline#themes#code#palette.visual_modified.airline_error  = s:ER
let g:airline#themes#code#palette.replace.airline_error          = s:ER
let g:airline#themes#code#palette.replace_modified.airline_error = s:ER


delf s:hl
