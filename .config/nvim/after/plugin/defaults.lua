-- Use relative numbers
vim.opt.relativenumber = true

-- Allow modified buffers in the background
vim.opt.hidden = true

-- Use the clipboard register '*' by default
vim.opt.clipboard = 'unnamed'

-- Avoid that vim is resizing other windows when closing one
vim.opt.equalalways = false

-- Do not update the screen during macro playback
vim.opt.lazyredraw = true

-- Search options
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

-- Use decimal number format, always
vim.opt.nrformats = ''

-- Timeout settings
vim.opt.timeoutlen = 750
vim.opt.ttimeoutlen = 0

-- Time until CursorHold/CursorHoldI events
vim.opt.updatetime = 2000

-- Split to right and below
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Move lines up/down
vim.keymap.set('v', '<S-j>', ":m '>+1<cr>gv=gv", { noremap = true })
vim.keymap.set('v', '<S-k>', ":m '>-2<cr>gv=gv", { noremap = true })

-- Avoid unintentionally entering Ex mode
vim.keymap.set('n', 'Q', 'q')

-- Move between windows in the same tab
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true})
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true})
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true})
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true})
vim.keymap.set('i', '<C-h>', '<C-[><C-w>h', { noremap = true})
vim.keymap.set('i', '<C-j>', '<C-[><C-w>j', { noremap = true})
vim.keymap.set('i', '<C-k>', '<C-[><C-w>k', { noremap = true})
vim.keymap.set('i', '<C-l>', '<C-[><C-w>l', { noremap = true})
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h', { noremap = true})
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j', { noremap = true})
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k', { noremap = true})
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l', { noremap = true})


-- Don't loose selection when indenting blocks of code
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })


