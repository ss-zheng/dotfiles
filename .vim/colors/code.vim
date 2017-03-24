" Basic {{{
set background=dark
hi clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'code'

if !exists('g:colors')
    " no gui colors defined, use NONE
    let g:colors = map(range(18), '"NONE"')
end
" }}}

" Highlight Function {{{
function s:hl(gp, fg, bg, ...)
    let cmd = 'hi ' . a:gp

    if a:fg >= 0
        let fg = a:fg < 16 ? a:fg : 'NONE'
        let cmd .= ' guifg=' . g:colors[a:fg] . ' ctermfg=' . fg
    endif

    if a:bg >= 0
        let bg = a:bg < 16 ? a:bg : 'NONE'
        let cmd .= ' guibg=' . g:colors[a:bg] . ' ctermbg=' . bg
    endif

    let st = a:0 > 0 ? a:1 : 'NONE'
    let cmd .= ' gui=' . st . ' cterm=' . st

    if a:0 > 1
        let cmd .= ' guisp=' . g:colors[a:2]
    endif

    exe cmd
endfunction
" }}}

" Normal {{{
call s:hl('Normal',         16, 17)
" }}}

" UI {{{
call s:hl('ColorColumn',    -1,  0)
call s:hl('Conceal',        -1, 17)
call s:hl('Cursor',         -1, -1)
call s:hl('CursorIM',       -1, -1)
call s:hl('CursorColumn',   -1,  0)
call s:hl('CursorLine',     -1,  0)
call s:hl('Directory',      12, -1)
call s:hl('DiffAdd',         2,  0)
call s:hl('DiffChange',      3,  0)
call s:hl('DiffDelete',      1,  0)
call s:hl('DiffText',        4,  0)
call s:hl('EndOfBuffer',     0, -1)
call s:hl('ErrorMsg',        9, 17)
call s:hl('VertSplit',      -1,  8)
call s:hl('Folded',          7, 17)
call s:hl('FoldColumn',      7,  8)
call s:hl('SignColumn',      7,  8)
call s:hl('IncSearch',      16,  0, 'reverse')
call s:hl('LineNr',          7,  0)
call s:hl('CursorLineNr',   16,  8)
call s:hl('MatchParen',     15,  8, 'bold')
call s:hl('ModeMsg',        12, -1)
call s:hl('MoreMsg',        12, -1)
call s:hl('NonText',         7, -1)
call s:hl('Pmenu',          16,  8)
call s:hl('PmenuSel',       12,  0)
call s:hl('PmenuSbar',      -1,  0)
call s:hl('PmenuThumb',     -1,  7)
call s:hl('Question',       12, -1)
call s:hl('Search',         15,  0, 'bold')
call s:hl('SpecialKey',     13, -1)
call s:hl('SpellBad',       -1, 17, 'undercurl', 1)
call s:hl('SpellCap',       -1, 17, 'undercurl', 4)
call s:hl('SpellLocal',     -1, 17, 'undercurl', 2)
call s:hl('SpellRare',      -1, 17, 'undercurl', 3)
call s:hl('StatusLine',     15,  8, 'bold')
call s:hl('StatusLineNC',   16,  8)
call s:hl('TabLine',         7,  0)
call s:hl('TabLineFill',    -1,  0)
call s:hl('TabLineSel',     12,  0)
call s:hl('Title',          11, -1, 'bold')
call s:hl('Visual',         15,  8)
call s:hl('VisualNOS',       9,  8)
call s:hl('WarningMsg',     11, 17)
call s:hl('WildMenu',       12,  0)
" }}}

" Syntax components {{{
call s:hl('Comment',         7, -1)

call s:hl('Constant',        9, -1)
call s:hl('String',         11, -1)
call s:hl('Character',      11, -1)

call s:hl('Identifier',      5, -1)
call s:hl('Function',       13, -1, 'bold')

call s:hl('Statement',      12, -1)
call s:hl('Conditional',    12, -1, 'bold')
call s:hl('Repeat',         12, -1, 'bold')
call s:hl('Operator',        7, -1)

call s:hl('PreProc',         4, -1)

call s:hl('Type',           14, -1, 'bold')
call s:hl('StorageClass',    6, -1)
call s:hl('Structure',      14, -1)

call s:hl('Special',        10, -1)
call s:hl('SpecialChar',    10, -1, 'bold')
call s:hl('Tag',            10, -1, 'underline')
call s:hl('Delimiter',       7, -1)
call s:hl('SpecialComment',  2, -1)
call s:hl('Debug',          10, -1, 'italic')

call s:hl('Underlined',      4, -1, 'underline')

call s:hl('Error',           1, 17)

call s:hl('Todo',           15, 17, 'bold')

call s:hl('Noise',           7, -1)

call s:hl('htmlBold',       15, -1, 'bold')
call s:hl('htmlItalic',     -1, -1, 'italic')
" }}}

" Cleanup {{{
delf s:hl
" }}}
