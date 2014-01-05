function! mkdtodo#Toggle()
  let line  = getline(".")
  if line =~? '^\s*- \[ \]'
    " line is an unchecked checkbox -- check it
    let spaces = match(line, "-")
    let line = substitute(line, '^\s*- \[ \]', repeat(" ", spaces) . "- [X]", "")
  elseif line =~? '^\s*- \[X\]'
    " line is a checked checkbox -- uncheck it
    let spaces = match(line, "-")
    let line = substitute(line, '^\s*- \[X\]', repeat(" ", spaces) . "- [ ]", "")
  elseif line =~? '^\s*-'
    " line is a list item
    let spaces = match(line, "-")
    let line = substitute(line, '^\s*-', repeat(" ", spaces) . "- [ ] ", "")
  else
    " No checkbox on this line nor is this line a list item.
    " Make it both a list item and a checkbox.
    let line = substitute(line, '^\(\s*\)\(.*\)', '\1' . '- [ ] ' . '\2', "")
  endif
  call setline(".", line)
  " CR bgrundmann: Figure out how to do substitute calls without
  " affecting active searches if any
  nohlsearch
endfunction

