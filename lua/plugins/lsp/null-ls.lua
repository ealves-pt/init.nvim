-- Plugin: null-ls.nvim
-- url: https://github.com/jose-elias-alvarez/null-ls.nvim

local nls = require('null-ls')
local lspUtils = require('utils.lsp')

local fmt_group = vim.api.nvim_create_augroup('FORMATTING', { clear = true })
-- local fmt_on_save = function(client, bufnr)
--     if client.supports_method('textDocument/formatting') then
--         vim.api.nvim_create_autocmd('BufWritePre', {
--             group = fmt_group,
--             buffer = bufnr,
--             callback = function()
--                 vim.lsp.buf.format({
--                     timeout_ms = 3000,
--                     buffer = bufnr,
--                 })
--             end,
--         })
--     end
-- end

local fmt = nls.builtins.formatting
local dgn = nls.builtins.diagnostics
local cda = nls.builtins.code_actions

-- Configuring null-ls
nls.setup({
   sources = {
       ----------------
       -- FORMATTING --
       ----------------
--        fmt.trim_whitespace.with({
--            filetypes = { 'text', 'zsh', 'toml', 'make', 'conf', 'tmux' },
--        }),
--        -- NOTE:
--        -- 1. both needs to be enabled to so prettier can apply eslint fixes
--        -- 2. prettierd should come first to prevent occassional race condition
--        fmt.prettierd,
--        fmt.eslint_d,
--        -- fmt.prettier.with({
--        --     extra_args = {
--        --         '--tab-width=4',
--        --         '--trailing-comma=es5',
--        --         '--end-of-line=lf',
--        --         '--arrow-parens=always',
--        --     },
--        -- }),
       fmt.stylua,
--        fmt.gofmt,
       fmt.shfmt.with({
           extra_args = { '-i', 4, '-ci', '-sr' },
       }),
       -----------------
       -- DIAGNOSTICS --
       -----------------
--        dgn.eslint_d,
       dgn.luacheck.with({
           extra_args = { '--globals', 'vim', '--std', 'luajit' },
       }),
       dgn.markdownlint,
       dgn.shellcheck,
       ------------------
       -- CODE ACTIONS --
       ------------------
--        cda.eslint_d,
       cda.shellcheck,
   },
   on_attach = function(client, bufnr)
       -- fmt_on_save(client, bufnr)
       lspUtils.buf_mappings(bufnr)
   end,
})
