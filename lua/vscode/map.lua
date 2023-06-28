vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.cmd([[

nmap <enter> :w<cr>
nmap <esc> :nohlsearch<cr><Cmd>call VSCodeNotify('workbench.action.debug.stop')<CR><Cmd>call VSCodeNotify('removeSecondaryCursors')<CR>

nnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.quickOpenPreviousEditor')<CR><Cmd>call VSCodeNotify('workbench.action.acceptSelectedQuickOpenItem')<CR>
nnoremap K <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

nnoremap <leader>r <Cmd>call VSCodeNotify('workbench.action.quickOpenPreviousEditor')<CR>
nnoremap <leader>p <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>

nmap <tab> <Cmd>call VSCodeNotify('editor.action.indentLines')<CR>
nmap <s-tab> <Cmd>call VSCodeNotify('editor.action.outdentLines')<CR>

xmap <tab> <Cmd>call VSCodeNotifyVisual('editor.action.indentLines', 1)<CR>
xmap <s-tab> <Cmd>call VSCodeNotifyVisual('editor.action.outdentLines', 1)<CR>

nmap <leader>/ <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>
xmap <leader>/ <Cmd>call VSCodeNotifyVisual('editor.action.commentLine', 1)<CR>

nnoremap ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>') })<CR>

nmap <leader>/ <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>

]])

vim.keymap.set('n', '*', '*N')

vim.keymap.set('n', '.', '.`[')
vim.keymap.set('x', '.', ":'<,'>normal .<cr>")

vim.keymap.set('n', 'Q', '@q')
vim.keymap.set('x', 'Q', ":'<,'>normal @q<cr>")

vim.keymap.set('n', 'n', 'nzz')

vim.keymap.set('n', '<leader>ml', 'V:s/; /;\r/g<cr>^MggVG:sort<cr>')
