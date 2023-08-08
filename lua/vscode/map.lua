vim.cmd([[

nmap <silent> <enter> :w<cr>
nmap <silent> <esc> :nohlsearch<cr><Cmd>call VSCodeNotify('workbench.action.debug.stop')<CR><Cmd>call VSCodeNotify('removeSecondaryCursors')<CR>

nnoremap <silent> <leader>b <Cmd>call VSCodeNotify('workbench.action.quickOpenPreviousEditor')<CR><Cmd>call VSCodeNotify('workbench.action.acceptSelectedQuickOpenItem')<CR>
nnoremap <silent> K <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

nnoremap <silent> <leader>r <Cmd>call VSCodeNotify('workbench.action.quickOpenPreviousEditor')<CR>
nnoremap <silent> <leader>p <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>

xmap <silent> <tab> <Cmd>call VSCodeCall('editor.action.indentLines')<CR>
xmap <silent> <s-tab> <Cmd>call VSCodeCall('editor.action.outdentLines')<CR>

nmap <silent> <leader>/ <Cmd>call VSCodeCall('editor.action.commentLine')<CR>
xmap <silent> <leader>/ <Cmd>call VSCodeCall('editor.action.commentLine')<CR>

nnoremap <silent> ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>') })<CR>

nmap <silent> <space> <Cmd>call VSCodeNotify('editor.toggleFold')<CR>

nnoremap j <Cmd>call VSCodeCall('cursorDown')<CR>
nnoremap k <Cmd>call VSCodeCall('cursorUp')<CR>

]])

vim.keymap.set('n', '*', '*N', { silent = true })

vim.keymap.set('n', '.', '.`[', { silent = true })
vim.keymap.set('x', '.', ":'<,'>normal .<cr>", { silent = true })

vim.keymap.set('n', 'Q', '@q', { silent = true })
vim.keymap.set('x', 'Q', ":'<,'>normal @q<cr>", { silent = true })

vim.keymap.set('n', '<leader>ml', 'V:s/; /;\r/g<cr>^MggVG:sort<cr>', { silent = true })
