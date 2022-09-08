local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                                -- Enable mouse support
opt.clipboard = 'unnamedplus'                  -- Copy/paste to system clipboard
opt.completeopt = 'menu,menuone,noselect'      -- Autocomplete options
opt.title = true                               -- Set window title

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------

opt.wrap = false              -- Disable line wrapping
opt.number = true             -- Show line number
opt.relativenumber = true     -- Enable relative line number
opt.showmatch = true          -- Highlight matching parenthesis
opt.cursorline = true         -- Highlight line number
opt.showmode = false          -- Do not show mode at bottom
opt.showcmd = false           -- Do not show command
opt.splitright = true         -- Vertical split to the right
opt.splitbelow = true         -- Horizontal split to the bottom
opt.ignorecase = true         -- Ignore case letters when search
opt.smartcase = true          -- Ignore lowercase for the whole pattern
opt.scrolloff = 3             -- Always keep X lines visible above and below cursor
opt.signcolumn = 'auto:9'     -- Show sign column only if there is something to show
opt.startofline = true        -- Attempt to keep cursor in same column when scrolling
opt.showtabline = 1           -- Always show tab line
opt.laststatus = 3            -- Global status line
opt.grepprg = 'rg --vimgrep'  -- Uss ripgrep as grepper

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true

-----------------------------------------------------------
-- Directories
-----------------------------------------------------------
opt.backupdir = '/tmp//,.'
opt.directory = '/tmp//,.'
opt.undodir = '/tmp//,.'

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 700        -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
opt.shortmess:append 'sI'     -- Disable nvim intro

-- Disable builtin plugins
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
  'tutor',
  'rplugin',
  'synmenu',
  'optwin',
  'compiler',
  'bugreport',
  'ftplugin',
}

for _, plugin in pairs(disabled_built_ins) do
  g['loaded_' .. plugin] = 1
end
